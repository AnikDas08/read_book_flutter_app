import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';

class ChaptersDrawer extends ConsumerWidget {
  const ChaptersDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readState = ref.watch(readProvider);
    final book = readState.slectedBook;

    if (book == null) return const SizedBox();

    final totalChapters = book.chapters.length;
    final currentChapterIndex = book.selectedChapter;

    return Drawer(
      child: Column(
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.color.ctaGradientBackgroundAccent.colors[0],
                  context.color.ctaGradientBackgroundAccent.colors[1],
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.only(left: 16,right: 16, bottom: 10),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonText(
                        text: 'Chapters',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white,
                      ),
                      4.height,
                      CommonText(
                        text: '${currentChapterIndex + 1} / $totalChapters chapters',
                        fontSize: 12,
                        textColor: Colors.white70,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Chapters List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              itemCount: totalChapters,
              itemBuilder: (context, index) {
                final chapter = book.chapters[index];
                final isSelected = currentChapterIndex == index;

                return GestureDetector(
                  onTap: () {
                    ref.read(readProvider.notifier).selectChapter(index);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF5B4FEE)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? null
                          : Border.all(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text: 'Chapter ${index + 1}',
                                    fontSize: 12,
                                    textColor: isSelected
                                        ? Colors.white70
                                        : Colors.grey[600],
                                  ),
                                  4.height,
                                  CommonText(
                                    text: chapter.title ?? 'Chapter ${index + 1}',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    textColor: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            8.width,
                            // // Bookmark icon placeholder (if needed)
                            // Icon(
                            //   Icons.bookmark_outline,
                            //   size: 18,
                            //   color: isSelected
                            //       ? Colors.white60
                            //       : Colors.grey[400],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

