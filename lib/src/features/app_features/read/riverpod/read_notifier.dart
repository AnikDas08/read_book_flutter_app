import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/data/model/book_model.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_state.dart';

part 'read_notifier.g.dart';

@Riverpod(keepAlive: true)
class ReadNotifier extends _$ReadNotifier {
  @override
  ReadState build() {
    ref.keepAlive();
    return const ReadState();
  }

  void toggleAudioPlaying() {
    final nextValue = !state.isAudioPlaying;
    state = state.copyWith(
      isAudioPlaying: nextValue,
      isActionPanelVisible: nextValue ? false : state.isActionPanelVisible,
    );
  }

  void selectBook() {
    state = state.copyWith(
      slectedBook: BookModel(
        title: 'Shadow of the Violet Moon',
        author: 'M. M. KAYE',
        coverImage: Constants.sampleImage,
        chapters: [
          const BookChapter(
            title: 'Chapter 1: The Beginning',
            content:
                'The night was darker than usual. Violet stepped out of her apartment, unaware that her life was about to change forever.\n\nThe city lights flickered in the distance, casting long shadows across the empty streets. She pulled her coat tighter around her shoulders, feeling a chill that had nothing to do with the weather.\n\n"You\'re late," a voice said from the shadows.\n\nViolet froze. She knew that voice. It had haunted her dreams for years.\n\n"I didn\'t think you\'d come," she replied, her voice steadier than she felt.\n\nA figure emerged from the darkness. Tall, imposing, with eyes that seemed to glow in the dim light. This was the man who had changed everything. The man who had awakened powers within her that she never knew existed.\n\n"We need to talk," he said simply. "About what you are. About what you\'re meant to become."\n\nViolet\'s hands trembled. She had spent her entire life running from the truth. But tonight, there would be no more running.\n\n"I\'m listening," she said.\n\nAnd with those two words, her destiny began to unfold.',
          ),
          const BookChapter(
            title: 'Chapter 2: Awakening Powers',
            content:
                'The night was darker than usual. Violet stepped out of her apartment, unaware that her life was about to change forever.\n\nThe city lights flickered in the distance, casting long shadows across the empty streets. She pulled her coat tighter around her shoulders, feeling a chill that had nothing to do with the weather.\n\n"You\'re late," a voice said from the shadows.\n\nViolet froze. She knew that voice. It had haunted her dreams for years.\n\n"I didn\'t think you\'d come," she replied, her voice steadier than she felt.\n\nA figure emerged from the darkness. Tall, imposing, with eyes that seemed to glow in the dim light. This was the man who had changed everything. The man who had awakened powers within her that she never knew existed.\n\n"We need to talk," he said simply. "About what you are. About what you\'re meant to become."\n\nViolet\'s hands trembled. She had spent her entire life running from the truth. But tonight, there would be no more running.\n\nViolet\'s hands trembled. She had spent her entire life running from the truth. But tonight, there would be no more running.\n\n"I\'m listening," she said.\n\nAnd with those two words, her destiny began to unfold.',
          ),
          const BookChapter(
            title: 'Chapter 3: First Lesson',
            content:
                'The first lesson waited beyond a locked gate, hidden behind courage and patience.',
            isLocked: true,
            unlockAdsRequired: 2,
            watchedAds: 0,
            showSparkle: true,
          ),
        ],
        selectedChapter: 0,
      ),
      readingMode: ReadingMode.slide,
      selectedMode: 0,
      fontSize: 16,
      lineSpacing: 1.8,
      isAudioPlaying: false,
      isActionPanelVisible: true,
    );
  }

  void selectChapter(int index) {
    state = state.copyWith(
      slectedBook: state.slectedBook?.copyWith(selectedChapter: index),
    );
  }

  void updateFontSize(double size) {
    state = state.copyWith(fontSize: size);
  }

  void updateLineSpacing(double spacing) {
    state = state.copyWith(lineSpacing: spacing);
  }

  void updateBackgroundMode(int mode) {
    state = state.copyWith(selectedMode: mode);
  }

  void updateReadingMode(ReadingMode mode) {
    state = state.copyWith(readingMode: mode);
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
    final chapter = chapters[chapterIndex];
    if (!chapter.isLocked) return;

    final watchedAds = chapter.watchedAds + 1;
    final shouldUnlock = watchedAds >= chapter.unlockAdsRequired;

    chapters[chapterIndex] = chapter.copyWith(
      watchedAds: watchedAds,
      isLocked: shouldUnlock ? false : chapter.isLocked,
    );

    state = state.copyWith(slectedBook: book.copyWith(chapters: chapters));
  }
}
