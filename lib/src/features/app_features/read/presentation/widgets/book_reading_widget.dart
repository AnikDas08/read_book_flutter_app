import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/src/constants/app_font_sizes.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/data/model/book_model.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/presentation/widgets/rewarded_ad_dialog_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/riverpod/read_notifier.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/riverpod/read_state.dart';

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
  bool _isNavigatingToLock = false;
  bool _hasScrolledToInitial = false;

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
      final ch = book.chapters[i];
      if (i == book.selectedChapter) {
        final resumePage = _getPageForReadCount(ch, ch.readCharacterCount);
        return pageIndex + resumePage;
      }
      if (ch.isLocked) {
        return pageIndex; // Can't go beyond first lock
      }
      if (ch.pages.isEmpty) {
        pageIndex += 1;
      } else {
        pageIndex += ch.pages.length;
      }
    }
    return pageIndex;
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

      if (itemBottom > 0) {
        // In Scroll mode, we only want to "select" unlocked chapters via scroll.
        // Locked chapters are handled as separate screens.
        final ch = ref.read(readProvider).slectedBook?.chapters[entry.key];
        if (ch?.isLocked == true) continue;

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

      if (ch.isLocked) {
        // Append the lock screen as the last "page" if there's a locked chapter
        pages.add(
          _ReaderPage(
            chapter: ch,
            chapterIndex: i,
            pageIndex: 0,
            totalPages: 1,
            isLockPage: true,
          ),
        );
        break;
      }

      if (ch.pages.isEmpty) {
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

    // If Scroll mode and current chapter is locked, show lock screen as a separate view
    if (readState.readingMode == ReadingMode.scroll && chapter.isLocked) {
      return Container(
        color: theme.surfaceColor,
        child: _LockedChapterView(
          theme: theme,
          chapter: chapter,
          onUnlock: _startUnlockFlow,
          onBack: () {
            if (currentChapterIndex > 0) {
              ref
                  .read(readProvider.notifier)
                  .selectChapter(currentChapterIndex - 1);
            } else {
              context.router.back();
            }
          },
        ),
      );
    }

    // NEW: Handle automatic scroll/page jump after an unlock happens
    ref.listen(readProvider, (previous, next) {
      final prevBook = previous?.slectedBook;
      final nextBook = next.slectedBook;
      if (prevBook == null || nextBook == null) return;

      final currentChIdx = nextBook.selectedChapter;
      final wasLocked = prevBook.chapters[currentChIdx].isLocked;
      final isNowUnlocked = !nextBook.chapters[currentChIdx].isLocked;

      if (wasLocked && isNowUnlocked) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          if (next.readingMode != ReadingMode.scroll) {
            final newFlatPages = _flattenPages(nextBook);
            final targetIdx =
                newFlatPages.indexWhere((p) => p.chapterIndex == currentChIdx);
            if (targetIdx != -1 && _pageController.hasClients) {
              _pageController.jumpToPage(targetIdx);
            }
          } else {
            // Give the ListView a moment to build the new chapter item
            Future.delayed(const Duration(milliseconds: 100), () {
              if (!mounted) return;
              final key = _chapterKeys[currentChIdx];
              if (key?.currentContext != null) {
                Scrollable.ensureVisible(
                  key!.currentContext!,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            });
          }
        });
      }
    });

    var targetPageIndex = flatPages.indexWhere(
      (p) => p.chapterIndex == currentChapterIndex,
    );
    if (targetPageIndex == -1) {
      targetPageIndex = flatPages.indexWhere((p) => p.isLockPage);
      if (targetPageIndex == -1) targetPageIndex = 0;
    }

    if (readState.readingMode != ReadingMode.scroll &&
        _pageController.hasClients) {
      final currentFlatPage = _pageController.page?.round() ?? 0;
      if (flatPages.isNotEmpty && currentFlatPage < flatPages.length) {
        final currentDisplayedChapter = flatPages[currentFlatPage].chapterIndex;
        if (currentDisplayedChapter != currentChapterIndex) {
          // If the selected chapter is actually a locked one further down,
          // the targetPageIndex should already point to the lock page.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _pageController.hasClients) {
              _pageController.jumpToPage(targetPageIndex);
            }
          });
        }
      }
    }

    // Scroll mode jump logic for TOC selections & initial load
    if (readState.readingMode == ReadingMode.scroll &&
        _scrollController.hasClients) {
      if (!_hasScrolledToInitial) {
        _hasScrolledToInitial = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 250), () {
            if (!mounted) return;
            final key = _chapterKeys[currentChapterIndex];
            if (key?.currentContext != null && _scrollController.hasClients) {
              Scrollable.ensureVisible(
                key!.currentContext!,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          });
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          final key = _chapterKeys[currentChapterIndex];
          if (key?.currentContext != null) {
            // If the selected chapter is rendered but not at the top, we could jump here.
            // However, we usually rely on ref.listen for explicit changes.
          }
        });
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is UserScrollNotification) {
                if (notification.direction != ScrollDirection.idle) {
                  if (ref.read(readProvider).isActionPanelVisible) {
                    ref
                        .read(readProvider.notifier)
                        .setActionPanelVisible(false);
                  }
                }
              }
              return false;
            },
            child: _buildReadingContent(
              context,
              readState,
              book,
              theme,
              flatPages,
            ),
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

  Widget _buildPageCard(
    _ReaderPage page,
    ReadState readState,
    _ReaderVisualTheme theme,
  ) {
    if (page.isLockPage) {
      return _ReadingCard(
        theme: theme,
        child: _LockedChapterView(
          theme: theme,
          chapter: page.chapter,
          onUnlock: _startUnlockFlow,
          onBack: () {
            if (_pageController.hasClients &&
                (_pageController.page ?? 0) > 0.5) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
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
      final firstLockedIndex = book.chapters.indexWhere((c) => c.isLocked);
      return _ReadingCard(
        theme: theme,
        child: ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 24.h),
          itemCount: firstLockedIndex == -1
              ? book.chapters.length
              : firstLockedIndex + 1,
          itemBuilder: (context, index) {
            // Ensure a GlobalKey exists for this chapter
            _chapterKeys.putIfAbsent(index, () => GlobalKey());

            if (index == firstLockedIndex) {
              return _buildNextChapterSection(
                context,
                book.chapters[index],
                theme,
              );
            }

            final chapter = book.chapters[index];
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
          final pageObj = flatPages[index];
          if (!pageObj.isLockPage) {
            ref.read(readProvider.notifier).updatePageProgress(
                  pageObj.chapterIndex,
                  pageObj.pageIndex,
                );
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
        final pageObj = flatPages[index];
        if (!pageObj.isLockPage) {
          ref.read(readProvider.notifier).updatePageProgress(
                pageObj.chapterIndex,
                pageObj.pageIndex,
              );
        }
      },
      itemCount: flatPages.length,
      itemBuilder: (context, index) {
        return _buildPageCard(flatPages[index], readState, theme);
      },
    );
  }

  Widget _buildNextChapterSection(
    BuildContext context,
    BookChapter chapter,
    _ReaderVisualTheme theme,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 20.w),
      child: Column(
        key: _chapterKeys[ref.read(readProvider).slectedBook?.chapters.indexOf(chapter) ?? -1],
        children: [
          Divider(color: theme.borderColor),
          48.height,
          Icon(
            Icons.lock_outline_rounded,
            color: theme.subtleTextColor,
            size: 40,
          ),
          20.height,
          CommonText(
            text: 'The next chapter is locked',
            fontSize: AppFontSizes.large,
            fontWeight: FontWeight.w600,
            textColor: theme.titleColor,
          ),
          8.height,
          CommonText(
            text: 'Continue reading to unlock more of the story',
            fontSize: AppFontSizes.medium,
            textColor: theme.subtleTextColor,
            textAlign: TextAlign.center,
          ),
          40.height,
          CommonButton(
            titleText: 'Read Next Chapter',
            onTap: () {
              final idx = ref
                      .read(readProvider)
                      .slectedBook
                      ?.chapters
                      .indexOf(chapter) ??
                  -1;
              if (idx != -1) {
                ref.read(readProvider.notifier).selectChapter(idx);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showWatchAdDialog(BookChapter chapter) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => RewardedAdDialogWidget(
        currentStep: chapter.watchedAds + 1,
        totalSteps: chapter.unlockAdsRequired,
        rewardType: RewardType.reading,
      ),
    );
  }

  Future<void> _startUnlockFlow(BookChapter chapter) async {
    await context.router.push(const PowerStonesRoute());
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
  const _LockedChapterView({
    super.key,
    required this.theme,
    required this.chapter,
    required this.onUnlock,
    required this.onBack,
  });

  final _ReaderVisualTheme theme;
  final BookChapter chapter;
  final Future<void> Function(BookChapter chapter) onUnlock;
  final VoidCallback onBack;

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
              textColor: theme.titleColor,
            ),
            14.height,
            CommonText(
              text: AppString.unlock_this_chapter_to_continue_reading,
              fontSize: AppFontSizes.medium,
              textColor: theme.subtleTextColor,
              textAlign: TextAlign.center,
            ),
            48.height,
            CommonButton(
              titleSize: AppFontSizes.medium,
              titleText: chapter.watchedAds > 0
                  ? 'Watch ${chapter.unlockAdsRequired - chapter.watchedAds} more to Unlock'
                  : AppString.watch_2_ads_to_unlock,
              gradient: const LinearGradient(
                colors: [Color(0xFF2A26FF), Color(0xFF8A42FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              onTap: () {
                final parent = context
                    .findAncestorStateOfType<_BookReadingWidgetState>();
                parent?._showWatchAdDialog(chapter);
              },
            ),
            16.height,
            CommonButton(
              titleSize: AppFontSizes.medium,
              titleText: 'Back to Reading',
              borderColor: theme.borderColor,
              buttonColor: theme.surfaceColor,
              titleColor: theme.contentColor,
              onTap: onBack,
            ),
            16.height,
            TextButton(
              onPressed: () => onUnlock(chapter),
              child: CommonText(
                text: 'Use Power Stones Instead',
                fontSize: AppFontSizes.medium,
                textColor: const Color(0xFF2A26FF),
                decoration: TextDecoration.underline,
              ),
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
  final bool isLockPage;

  _ReaderPage({
    required this.chapter,
    required this.chapterIndex,
    this.content,
    required this.pageIndex,
    required this.totalPages,
    this.isLockPage = false,
  });
}
