import 'package:core_kit/text/common_text.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:core_kit/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_state.dart';

class BookReadingWidget extends ConsumerStatefulWidget {
  const BookReadingWidget({super.key});

  @override
  ConsumerState<BookReadingWidget> createState() => _BookReadingWidgetState();
}

class _BookReadingWidgetState extends ConsumerState<BookReadingWidget> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    final readState = ref.read(readProvider);
    _pageController = PageController(initialPage: readState.slectedBook?.selectedChapter ?? 0);
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
    if (book == null) return const SizedBox();

    final totalChapters = book.chapters.length;
    final currentChapterIndex = book.selectedChapter;
    if (_pageController.hasClients && (_pageController.page?.round() ?? 0) != currentChapterIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pageController.jumpToPage(currentChapterIndex);
      });
    }
    final chapter = book.chapters[currentChapterIndex];
    final wordCount = _countWords(chapter.content ?? '');
    final backgroundColors = [
        Colors.white, // White
      const Color(0xFF2D2D2D), // Dark
      const Color(0xFFF4ECD8), // Sepia
      const Color(0xFFE8F5E9), // Eye Comfort
    ];
    final textColors = [
      Colors.black,
      Colors.white,
      Colors.black,
      Colors.black,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: chapter.title ?? 'Chapter',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          // textColor: textColors[readState.selectedMode],
        ),
        8.height,
        CommonText(
          text: '$wordCount ${AppString.words}',
          // textColor: textColors[readState.selectedMode].withOpacity(0.7),
          fontSize: 14,
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              ref.read(readProvider.notifier).selectChapter(index);
            },
            itemCount: totalChapters,
            itemBuilder: (context, index) {
              final chap = book.chapters[index];
              final htmlContent = _wrapInHtml(chap.content ?? '', readState);
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: backgroundColors[readState.selectedMode],
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: context.color.subtleOverlaysShadows, width: 1.2.w),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: CommonText(
                    isDescription: true,
                    textAlign: TextAlign.start,
                    text: htmlContent,
                    fontSize: readState.fontSize,
                    style: TextStyle(
                      height: readState.lineSpacing,
                    ),
                    textColor: textColors[readState.selectedMode],
                  ),
                ),
              );
            },
          ),
        ),
        CommonText(
          text: '${currentChapterIndex + 1} of $totalChapters',
          textColor: textColors[readState.selectedMode].withOpacity(0.7),
          fontSize: 14,
        ).end,
      ],
    );
  }

  int _countWords(String text) {
    return text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }

  String _wrapInHtml(String content, ReadState readState) {
    final paragraphs = content.split('\n').map((p) => '<p>$p</p>').join('');
    return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    body {
      font-size: ${readState.fontSize}px;
      line-height: ${readState.lineSpacing};
      margin: 0;
      padding: 0;
    }
    p {
      margin: 0 0 16px 0;
    }
  </style>
</head>
<body>
$paragraphs
</body>
</html>
''';
  }
}
