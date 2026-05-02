import 'dart:math' as math;

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/data/model/book_model.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/rewarded_ad_dialog_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_state.dart';

class BookReadingWidget extends ConsumerStatefulWidget {
  const BookReadingWidget({super.key});

  @override
  ConsumerState<BookReadingWidget> createState() => _BookReadingWidgetState();
}

class _BookReadingWidgetState extends ConsumerState<BookReadingWidget> {
  late PageController _pageController;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _flipPageNotifier = ValueNotifier<double>(0);
  final Map<int, GlobalKey> _chapterKeys = {};

  @override
  void initState() {
    super.initState();
    final readState = ref.read(readProvider);
    final book = readState.slectedBook;
    var initialPage = 0;
    if (book != null) {
      initialPage = _getInitialPage(book);
    }
    _pageController = PageController(initialPage: initialPage);
    _flipPageNotifier.value = initialPage.toDouble();
    _pageController.addListener(_onPageScroll);
    _scrollController.addListener(_onScrollChapterDetect);
  }

  int _getInitialPage(BookModel book) {
    var pageIndex = 0;
    for (var i = 0; i < book.chapters.length; i++) {
      if (i == book.selectedChapter) return pageIndex;
      final ch = book.chapters[i];
      if (ch.isLocked || ch.pages.isEmpty) {
        pageIndex += 1;
      } else {
        pageIndex += ch.pages.length;
      }
    }
    return pageIndex;
  }

  void _onPageScroll() {
    if (_pageController.hasClients) {
      _flipPageNotifier.value = _pageController.page ?? 0;
    }
  }

  /// Detects which chapter is currently most visible during scroll mode
  /// and updates the app bar title via the provider.
  void _onScrollChapterDetect() {
    if (_chapterKeys.isEmpty) return;
    final scrollBox = context.findRenderObject() as RenderBox?;
    if (scrollBox == null) return;
    final scrollTop = scrollBox.localToGlobal(Offset.zero).dy;

    var visibleChapter = 0;
    for (final entry in _chapterKeys.entries) {
      final key = entry.value;
      final renderObj = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderObj == null) continue;
      final itemTop = renderObj.localToGlobal(Offset.zero).dy - scrollTop;
      final itemBottom = itemTop + renderObj.size.height;
      // If the bottom of this chapter is still below the top of the viewport,
      // this chapter is (at least partially) visible.
      if (itemBottom > 0) {
        visibleChapter = entry.key;
        break;
      }
    }

    final currentSelected =
        ref.read(readProvider).slectedBook?.selectedChapter ?? 0;
    if (visibleChapter != currentSelected) {
      ref.read(readProvider.notifier).selectChapter(visibleChapter);
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _scrollController.removeListener(_onScrollChapterDetect);
    _pageController.dispose();
    _scrollController.dispose();
    _flipPageNotifier.dispose();
    super.dispose();
  }

  List<_ReaderPage> _flattenPages(BookModel book) {
    final pages = <_ReaderPage>[];
    for (var i = 0; i < book.chapters.length; i++) {
      final ch = book.chapters[i];
      if (ch.isLocked || ch.pages.isEmpty) {
        pages.add(
          _ReaderPage(
            chapter: ch,
            chapterIndex: i,
            content: null,
            pageIndex: 0,
            totalPages: 1,
          ),
        );
      } else {
        for (var p = 0; p < ch.pages.length; p++) {
          pages.add(
            _ReaderPage(
              chapter: ch,
              chapterIndex: i,
              content: ch.pages[p],
              pageIndex: p,
              totalPages: ch.pages.length,
            ),
          );
        }
      }
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    final readState = ref.watch(readProvider);
    final book = readState.slectedBook;
    if (book == null) return const SizedBox.shrink();

    final theme = _ReaderVisualTheme.fromMode(readState.selectedMode);
    final currentChapterIndex = book.selectedChapter;
    final chapter = book.chapters[currentChapterIndex];

    final flatPages = _flattenPages(book);
    var targetPageIndex = flatPages.indexWhere(
      (p) => p.chapterIndex == currentChapterIndex,
    );
    if (targetPageIndex == -1) targetPageIndex = 0;

    if (readState.readingMode != ReadingMode.scroll &&
        _pageController.hasClients) {
      final currentFlatPage = _pageController.page?.round() ?? 0;
      if (flatPages.isNotEmpty && currentFlatPage < flatPages.length) {
        final currentDisplayedChapter = flatPages[currentFlatPage].chapterIndex;
        if (currentDisplayedChapter != currentChapterIndex) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _pageController.hasClients) {
              _pageController.jumpToPage(targetPageIndex);
            }
          });
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: chapter.isLocked
              ? _LockedChapterView(chapter: chapter, onUnlock: _startUnlockFlow)
              : _buildReadingContent(
                  context,
                  readState,
                  book,
                  theme,
                  flatPages,
                ),
        ),
        if (readState.readingMode != ReadingMode.scroll) ...[
          4.height,
          ValueListenableBuilder<double>(
            valueListenable: _flipPageNotifier,
            builder: (context, pageValue, child) {
              final flatIndex = pageValue.round();
              if (flatPages.isEmpty || flatIndex >= flatPages.length) {
                return const SizedBox.shrink();
              }
              final pageObj = flatPages[flatIndex];
              return CommonText(
                text: 'Page ${pageObj.pageIndex + 1} of ${pageObj.totalPages}',
                fontSize: AppFontSizes.medium,
                textColor: theme.subtleTextColor,
              ).end;
            },
          ),
        ],
      ],
    );
  }

  /// Builds a single chapter/page card (reused across modes).
  Widget _buildPageCard(
    _ReaderPage page,
    ReadState readState,
    _ReaderVisualTheme theme,
  ) {
    if (page.chapter.isLocked) {
      return _ReadingCard(
        theme: theme,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: CommonText(
              text: AppString.watch_ads_to_unlock,
              fontSize: AppFontSizes.title,
              textColor: theme.subtleTextColor,
            ),
          ),
        ),
      );
    }
    return _ReadingCard(
      theme: theme,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 24.h),
        child: _ChapterText(
          content: page.content ?? '',
          fontSize: readState.fontSize,
          lineSpacing: readState.lineSpacing,
          textColor: theme.contentColor,
        ),
      ),
    );
  }

  Widget _buildReadingContent(
    BuildContext context,
    ReadState readState,
    BookModel book,
    _ReaderVisualTheme theme,
    List<_ReaderPage> flatPages,
  ) {
    // ── SCROLL MODE: continuous scrolling through all chapters ──
    if (readState.readingMode == ReadingMode.scroll) {
      return _ReadingCard(
        theme: theme,
        child: ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 24.h),
          itemCount: book.chapters.length,
          itemBuilder: (context, index) {
            // Ensure a GlobalKey exists for this chapter
            _chapterKeys.putIfAbsent(index, () => GlobalKey());
            final chapter = book.chapters[index];
            if (chapter.isLocked) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Center(
                  child: CommonText(
                    text: AppString.watch_ads_to_unlock,
                    fontSize: AppFontSizes.title,
                    textColor: theme.subtleTextColor,
                  ),
                ),
              );
            }
            return Column(
              key: _chapterKeys[index],
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index > 0) ...[
                  Divider(color: theme.borderColor, height: 48.h),
                  CommonText(
                    text: chapter.title ?? 'Chapter ${index + 1}',
                    fontSize: AppFontSizes.title,
                    fontWeight: FontWeight.w700,
                    textColor: theme.titleColor,
                  ),
                  16.height,
                ],
                _ChapterText(
                  content: chapter.pages.join('\n\n'),
                  fontSize: readState.fontSize,
                  lineSpacing: readState.lineSpacing,
                  textColor: theme.contentColor,
                ),
              ],
            );
          },
        ),
      );
    }

    // ── FLIP MODE: 3D book page-turn animation ──
    if (readState.readingMode == ReadingMode.flip) {
      return PageView.builder(
        key: const ValueKey('flip_page_view'),
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          final targetChapter = flatPages[index].chapterIndex;
          if (targetChapter != readState.slectedBook?.selectedChapter) {
            ref.read(readProvider.notifier).selectChapter(targetChapter);
          }
        },
        itemCount: flatPages.length,
        itemBuilder: (context, index) {
          return ValueListenableBuilder<double>(
            valueListenable: _flipPageNotifier,
            builder: (context, currentPage, child) {
              final pageOffset = (currentPage - index).clamp(-1.0, 1.0);

              // rotation: rotate up to 90° (pi/2) based on page offset
              final angle = pageOffset * math.pi / 2;

              // Scale down slightly as it turns
              final scale = 1.0 - (pageOffset.abs() * 0.15);

              // Shadow intensity during the flip
              final shadowOpacity = pageOffset.abs() * 0.3;

              return Transform(
                alignment: pageOffset >= 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0015) // perspective
                  ..rotateY(-angle)
                  // ignore: deprecated_member_use
                  ..scale(scale),
                child: Stack(
                  children: [
                    child!,
                    // Shadow overlay during page turn
                    if (shadowOpacity > 0.01)
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(
                              alpha: shadowOpacity,
                            ),
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
            child: _buildPageCard(flatPages[index], readState, theme),
          );
        },
      );
    }

    // ── SLIDE MODE (default): standard horizontal PageView ──
    return PageView.builder(
      key: const ValueKey('slide_page_view'),
      controller: _pageController,
      physics: const BouncingScrollPhysics(),
      onPageChanged: (index) {
        final targetChapter = flatPages[index].chapterIndex;
        if (targetChapter != readState.slectedBook?.selectedChapter) {
          ref.read(readProvider.notifier).selectChapter(targetChapter);
        }
      },
      itemCount: flatPages.length,
      itemBuilder: (context, index) {
        return _buildPageCard(flatPages[index], readState, theme);
      },
    );
  }

  Future<void> _startUnlockFlow(BookChapter chapter) async {
    final totalSteps = chapter.unlockAdsRequired == 0
        ? 2
        : chapter.unlockAdsRequired;
    final nextStep = chapter.watchedAds + 1;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          RewardedAdDialogWidget(currentStep: nextStep, totalSteps: totalSteps),
    );

    final updatedChapter = ref
        .read(readProvider)
        .slectedBook
        ?.chapters[ref.read(readProvider).slectedBook!.selectedChapter];
    if (updatedChapter != null &&
        updatedChapter.isLocked &&
        updatedChapter.watchedAds < updatedChapter.unlockAdsRequired) {
      await _startUnlockFlow(updatedChapter);
    }
  }
}

class _ReaderVisualTheme {
  const _ReaderVisualTheme({
    required this.surfaceColor,
    required this.borderColor,
    required this.titleColor,
    required this.subtleTextColor,
    required this.contentColor,
  });

  final Color surfaceColor;
  final Color borderColor;
  final Color titleColor;
  final Color subtleTextColor;
  final Color contentColor;

  factory _ReaderVisualTheme.fromMode(int mode) {
    switch (mode) {
      case 1:
        return const _ReaderVisualTheme(
          surfaceColor: Color(0xFF141414),
          borderColor: Color(0xFF71778B),
          titleColor: Colors.white,
          subtleTextColor: Color(0xFFD1D5DB),
          contentColor: Colors.white,
        );
      case 2:
        return const _ReaderVisualTheme(
          surfaceColor: Color(0xFFF7EFD9),
          borderColor: Color(0xFFD6CCB5),
          titleColor: Color(0xFF111111),
          subtleTextColor: Color(0xFF6B7280),
          contentColor: Color(0xFF161B25),
        );
      case 3:
        return const _ReaderVisualTheme(
          surfaceColor: Color(0xFFDFF4DB),
          borderColor: Color(0xFFBED9B8),
          titleColor: Color(0xFF111111),
          subtleTextColor: Color(0xFF6B7280),
          contentColor: Color(0xFF161B25),
        );
      default:
        return const _ReaderVisualTheme(
          surfaceColor: Colors.white,
          borderColor: Color(0xFFE5E7EB),
          titleColor: Color(0xFF111111),
          subtleTextColor: Color(0xFF98A2B3),
          contentColor: Color(0xFF1F2937),
        );
    }
  }
}

class _ReadingCard extends StatelessWidget {
  const _ReadingCard({required this.theme, required this.child});

  final _ReaderVisualTheme theme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.surfaceColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: theme.borderColor, width: 1.4),
      ),
      child: child,
    );
  }
}

class _ChapterText extends StatelessWidget {
  const _ChapterText({
    required this.content,
    required this.fontSize,
    required this.lineSpacing,
    required this.textColor,
  });

  final String content;
  final double fontSize;
  final double lineSpacing;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final paragraphs = content
        .split('\n\n')
        .where((e) => e.trim().isNotEmpty)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < paragraphs.length; i++) ...[
          CommonText(
            text: paragraphs[i],
            isDescription: true,
            textAlign: TextAlign.left,
            fontSize: fontSize,
            height: lineSpacing,
            textColor: textColor,
            fontWeight: FontWeight.w400,
          ),
          if (i != paragraphs.length - 1) 20.height,
        ],
      ],
    );
  }
}

class _LockedChapterView extends StatelessWidget {
  const _LockedChapterView({required this.chapter, required this.onUnlock});

  final BookChapter chapter;
  final Future<void> Function(BookChapter chapter) onUnlock;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFFD946EF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Icon(
                Icons.lock_outline_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
            32.height,
            CommonText(
              text: AppString.chapter_locked,
              fontSize: AppFontSizes.title,
              fontWeight: FontWeight.w700,
              textColor: const Color(0xFF111111),
            ),
            14.height,
            CommonText(
              text: AppString.unlock_this_chapter_to_continue_reading,
              fontSize: AppFontSizes.medium,
              textColor: const Color(0xFF697386),
            ),
            48.height,
            CommonButton(
              titleSize: AppFontSizes.medium,
              titleText: AppString.watch_2_ads_to_unlock,
              gradient: const LinearGradient(
                colors: [Color(0xFF2A26FF), Color(0xFF8A42FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              onTap: () => onUnlock(chapter),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReaderPage {
  final BookChapter chapter;
  final int chapterIndex;
  final String? content;
  final int pageIndex;
  final int totalPages;

  _ReaderPage({
    required this.chapter,
    required this.chapterIndex,
    this.content,
    required this.pageIndex,
    required this.totalPages,
  });
}
