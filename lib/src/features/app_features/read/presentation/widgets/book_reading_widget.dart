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
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final readState = ref.read(readProvider);
    _pageController = PageController(
      initialPage: readState.slectedBook?.selectedChapter ?? 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final readState = ref.watch(readProvider);
    final book = readState.slectedBook;
    if (book == null) return const SizedBox.shrink();

    final theme = _ReaderVisualTheme.fromMode(readState.selectedMode);
    final currentChapterIndex = book.selectedChapter;
    final chapter = book.chapters[currentChapterIndex];

    if (_pageController.hasClients &&
        (_pageController.page?.round() ?? 0) != currentChapterIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _pageController.jumpToPage(currentChapterIndex);
        }
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: chapter.title ?? 'Chapter',
          fontSize: AppFontSizes.heading,
          fontWeight: FontWeight.w700,
          textColor: theme.titleColor,
        ),
        if (!chapter.isLocked) ...[
          10.height,
          CommonText(
            text:
                '${_countWords(chapter.content ?? '').toString()} ${AppString.words}',
            fontSize: AppFontSizes.title,
            textColor: theme.subtleTextColor,
          ),
        ],
        16.height,
        Expanded(
          child: chapter.isLocked
              ? _LockedChapterView(chapter: chapter, onUnlock: _startUnlockFlow)
              : _buildReadingContent(context, readState, book, theme),
        ),
        16.height,
        CommonText(
          text: '${currentChapterIndex + 1} of ${book.chapters.length}',
          fontSize: AppFontSizes.title,
          textColor: theme.subtleTextColor,
        ).end,
      ],
    );
  }

  Widget _buildReadingContent(
    BuildContext context,
    ReadState readState,
    BookModel book,
    _ReaderVisualTheme theme,
  ) {
    if (readState.readingMode == ReadingMode.scroll) {
      final chapter = book.chapters[book.selectedChapter];
      return _ReadingCard(
        theme: theme,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 24.h),
          child: _ChapterText(
            chapter: chapter,
            fontSize: readState.fontSize,
            lineSpacing: readState.lineSpacing,
            textColor: theme.contentColor,
          ),
        ),
      );
    }

    return PageView.builder(
      controller: _pageController,
      physics: const BouncingScrollPhysics(),
      onPageChanged: (index) =>
          ref.read(readProvider.notifier).selectChapter(index),
      itemCount: book.chapters.length,
      itemBuilder: (context, index) {
        final chapter = book.chapters[index];
        if (chapter.isLocked) {
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

        return Padding(
          padding: EdgeInsets.only(
            right: readState.readingMode == ReadingMode.flip ? 0 : 0,
          ),
          child: _ReadingCard(
            theme: theme,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 24.h),
              child: _ChapterText(
                chapter: chapter,
                fontSize: readState.fontSize,
                lineSpacing: readState.lineSpacing,
                textColor: theme.contentColor,
              ),
            ),
          ),
        );
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

  int _countWords(String text) {
    return text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
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
    required this.chapter,
    required this.fontSize,
    required this.lineSpacing,
    required this.textColor,
  });

  final BookChapter chapter;
  final double fontSize;
  final double lineSpacing;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final paragraphs = (chapter.content ?? '')
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
