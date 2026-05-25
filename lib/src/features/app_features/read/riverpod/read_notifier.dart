import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unkutdrama_kpnovel/config/constance/constants.dart';
import 'package:unkutdrama_kpnovel/config/storage/storage_service.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/data/repository/book_repository.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/data/model/book_model.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/data/repository/read_repository.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/riverpod/read_state.dart';

part 'read_notifier.g.dart';

// Storage keys for reading preferences
const _kFontSize = 'reading_font_size';
const _kLineSpacing = 'reading_line_spacing';
const _kBackgroundMode = 'reading_background_mode';
const _kReadingMode = 'reading_mode';

@Riverpod(keepAlive: true)
class ReadNotifier extends _$ReadNotifier {
  final _storage = StorageService.instance;

  @override
  ReadState build() {
    ref.keepAlive();
    _loadSettings();
    return const ReadState();
  }

  /// Loads persisted reading settings from storage.
  Future<void> _loadSettings() async {
    final fontSize = await _storage.get(_kFontSize);
    final lineSpacing = await _storage.get(_kLineSpacing);
    final backgroundMode = await _storage.get(_kBackgroundMode);
    final readingMode = await _storage.get(_kReadingMode);

    state = state.copyWith(
      fontSize: fontSize != null ? double.tryParse(fontSize) ?? 14 : 14,
      lineSpacing: lineSpacing != null
          ? double.tryParse(lineSpacing) ?? 1.0
          : 1.0,
      selectedMode: backgroundMode != null
          ? int.tryParse(backgroundMode) ?? 0
          : 0,
      readingMode: readingMode != null
          ? ReadingMode.values.firstWhere(
              (e) => e.name == readingMode,
              orElse: () => ReadingMode.slide,
            )
          : ReadingMode.slide,
    );
  }

  /// Saves current reading settings to storage.
  Future<void> _saveSettings() async {
    await _storage.set(_kFontSize, state.fontSize.toString());
    await _storage.set(_kLineSpacing, state.lineSpacing.toString());
    await _storage.set(_kBackgroundMode, state.selectedMode.toString());
    await _storage.set(_kReadingMode, state.readingMode.name);
  }

  void toggleAudioPlaying() {
    final nextValue = !state.isAudioPlaying;
    state = state.copyWith(
      isAudioPlaying: nextValue,
      isActionPanelVisible: nextValue ? false : state.isActionPanelVisible,
    );
  }

  Future<void> selectBook(String bookId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final chaptersResponse = await ref
          .read(readRepositoryProvider)
          .getChapters(bookId);
      final bookResponse = await ref
          .read(bookRepositoryProvider)
          .getBookDetails(bookId);

      if (chaptersResponse.isSuccess && chaptersResponse.data != null) {
        final chaptersList = chaptersResponse.data!;
        final parsedChapters = <BookChapter>[];
        for (var i = 0; i < chaptersList.length; i++) {
          parsedChapters.add(
            BookChapter.fromBackendJson(
              chaptersList[i] as Map<String, dynamic>,
              i,
            ),
          );
        }

        final bookDetails = bookResponse.data;

        // Determine the initial chapter index to resume reading
        var initialChapterIndex = 0;
        for (var i = 0; i < parsedChapters.length; i++) {
          final ch = parsedChapters[i];
          if (ch.isLocked) {
            break;
          }

          initialChapterIndex = i;

          if (ch.readCharacterCount > 0 && ch.readCharacterCount < ch.totalCharacterCount) {
            break;
          }
          if (ch.readCharacterCount == 0) {
            break;
          }
        }

        state = state.copyWith(
          isLoading: false,
          slectedBook: BookModel(
            id: bookId,
            title:
                bookDetails?.title ??
                (parsedChapters.isNotEmpty
                    ? parsedChapters.first.title
                    : 'Book Title'),
            description: bookDetails?.description ?? '',
            coverImage: bookDetails?.coverImage ?? Constants.sampleImage,
            author: bookDetails?.userId ?? 'Elena Nightshade',
            genre: bookDetails?.genre ?? 'Fantasy',
            status: bookDetails?.status ?? 'approved',
            chapters: parsedChapters,
            selectedChapter: initialChapterIndex, // Take user to active resume chapter!
          ),
        );

        if (parsedChapters.isNotEmpty) {
          final resumeChapter = parsedChapters[initialChapterIndex];
          final resumePage = _getPageForReadCount(resumeChapter, resumeChapter.readCharacterCount);
          updatePageProgress(initialChapterIndex, resumePage);
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: chaptersResponse.message ?? 'Failed to load chapters',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  int _getPageForReadCount(BookChapter chapter, int readCount) {
    if (readCount <= 0 || chapter.pages.isEmpty) return 0;

    var accumulated = 0;
    for (var p = 0; p < chapter.pages.length; p++) {
      accumulated += chapter.pages[p].length;
      if (accumulated >= readCount) {
        return p;
      }
    }
    return chapter.pages.length - 1;
  }

  void _updateLocalChapterReadCount(int chapterIndex, int currentChapterRead) {
    final book = state.slectedBook;
    if (book == null) return;

    final chapters = [...book.chapters];
    if (chapterIndex >= 0 && chapterIndex < chapters.length) {
      chapters[chapterIndex] = chapters[chapterIndex].copyWith(
        readCharacterCount: currentChapterRead,
      );
      state = state.copyWith(
        slectedBook: book.copyWith(chapters: chapters),
      );
    }
  }

  void updatePageProgress(int chapterIndex, int pageIndex) {
    if (state.slectedBook?.selectedChapter != chapterIndex) {
      state = state.copyWith(
        slectedBook: state.slectedBook?.copyWith(selectedChapter: chapterIndex),
      );
    }
    final ch = state.slectedBook?.chapters[chapterIndex];
    if (ch != null) {
      // 1. Calculate characters read in the current chapter up to pageIndex
      var currentChapterRead = 0;
      for (var p = 0; p <= pageIndex && p < ch.pages.length; p++) {
        currentChapterRead += ch.pages[p].length;
      }

      // 2. Only update if the new read count is greater than the saved readCharacterCount
      if (currentChapterRead > ch.readCharacterCount) {
        // Send only this chapter's exact character progress!
        updateChapterReadCount(ch.id ?? '', currentChapterRead);

        // Update local state to prevent repeated requests
        _updateLocalChapterReadCount(chapterIndex, currentChapterRead);
      }
    }
  }

  void selectChapter(int index) {
    state = state.copyWith(
      slectedBook: state.slectedBook?.copyWith(selectedChapter: index),
    );
    final ch = state.slectedBook?.chapters[index];
    if (ch != null) {
      // For Scroll mode, we update only if the full chapter is read
      if (ch.totalCharacterCount > ch.readCharacterCount) {
        updateChapterReadCount(ch.id ?? '', ch.totalCharacterCount);
        _updateLocalChapterReadCount(index, ch.totalCharacterCount);
      }
    }
  }

  Future<void> updateChapterReadCount(String chapterId, int readCount) async {
    if (chapterId.isEmpty) return;
    try {
      final response = await ref.read(readRepositoryProvider).updateReadCount(chapterId, readCount);
      if (response.isSuccess) {
        // ignore: avoid_print
        print("Read count successfully updated for chapter $chapterId to $readCount");
      } else {
        // ignore: avoid_print
        print("Failed to update read count for chapter $chapterId: ${response.message}");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error updating chapter read count: $e");
    }
  }

  void updateFontSize(double size) {
    state = state.copyWith(fontSize: size);
    _saveSettings();
  }

  void updateLineSpacing(double spacing) {
    state = state.copyWith(lineSpacing: spacing);
    _saveSettings();
  }

  void updateBackgroundMode(int mode) {
    state = state.copyWith(selectedMode: mode);
    _saveSettings();
  }

  void updateReadingMode(ReadingMode mode) {
    state = state.copyWith(readingMode: mode);
    _saveSettings();
  }

  void toggleActionPanel() {
    state = state.copyWith(isActionPanelVisible: !state.isActionPanelVisible);
  }

  void setActionPanelVisible(bool isVisible) {
    state = state.copyWith(isActionPanelVisible: isVisible);
  }

  void watchAdForCurrentChapter() {
    final book = state.slectedBook;
    if (book == null) return;
    final chapterIndex = book.selectedChapter;
    final chapters = [...book.chapters];

    // Find the first locked chapter starting from current or after
    var targetIndex = -1;
    for (var i = chapterIndex; i < chapters.length; i++) {
      if (chapters[i].isLocked) {
        targetIndex = i;
        break;
      }
    }

    if (targetIndex == -1) return;
    final chapter = chapters[targetIndex];

    final watchedAds = chapter.watchedAds + 1;
    final shouldUnlock = watchedAds >= chapter.unlockAdsRequired;

    chapters[targetIndex] = chapter.copyWith(
      watchedAds: watchedAds,
      isLocked: shouldUnlock ? false : chapter.isLocked,
    );

    state = state.copyWith(
      slectedBook: book.copyWith(
        chapters: chapters,
        selectedChapter: targetIndex, // Ensure we are targeting this chapter
      ),
    );
  }

  bool unlockChapterWithStones(int cost) {
    final book = state.slectedBook;
    if (book == null) return false;

    final chapterIndex = book.selectedChapter;
    final chapters = [...book.chapters];

    // Find the first locked chapter
    var targetIndex = -1;
    for (var i = chapterIndex; i < chapters.length; i++) {
      if (chapters[i].isLocked) {
        targetIndex = i;
        break;
      }
    }

    if (targetIndex == -1) return false;

    chapters[targetIndex] = chapters[targetIndex].copyWith(isLocked: false);

    state = state.copyWith(
      slectedBook: book.copyWith(
        chapters: chapters,
        selectedChapter: targetIndex,
      ),
    );
    return true;
  }
}
