import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/action_bar_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/book_audio_reader_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/book_mark_modal_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/book_reading_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/chapters_drawer.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/comment_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/no_book_selected_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/reading_setting_modal.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/share_book_modal_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';

@RoutePage()
class ReadScreen extends ConsumerWidget {
  const ReadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readState = ref.watch(readProvider);
    final backgroundColors = [
      Colors.white,
      const Color(0xFF131313),
      const Color(0xFFF7EFD9),
      const Color(0xFFDFF4DB),
    ];
    final pageBackground = readState.slectedBook == null
        ? context.color.bgColor
        : backgroundColors[readState.selectedMode];
    final book = readState.slectedBook;

    final currentChapterIndex = book?.selectedChapter;
    final chapter = currentChapterIndex != null
        ? book?.chapters[currentChapterIndex]
        : null;
    return Scaffold(
      backgroundColor: pageBackground,
      drawerEnableOpenDragGesture: false,
      appBar: CommonAppBar(
        titleWidget: CommonText(
          text: chapter?.title ?? 'Chapter',
          textColor: Colors.black,
          fontSize: AppFontSizes.extraLarge,
          fontWeight: FontWeight.w700,
        ),
        appbarConfig: AppbarConfig(
          decoration: () => const BoxDecoration(color: Colors.white),
        ),
      ),
      endDrawer: const ChaptersDrawer(),
      body: Builder(
        builder: (scaffoldContext) {
          return SafeArea(
            top: false,
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap:
                        readState.slectedBook == null ||
                            readState.isAudioPlaying
                        ? null
                        : () => ref
                              .read(readProvider.notifier)
                              .toggleActionPanel(),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        16.w,
                        0,
                        16.w,
                        0.w,
                        // readState.slectedBook == null
                        //     ? 16.h
                        //     : readState.isAudioPlaying
                        //     ? 340.h
                        //     : 16.h,
                      ),
                      child: readState.slectedBook == null
                          ? const NoBookSelectedWidget()
                          : const BookReadingWidget(),
                    ),
                  ),
                ),
                if (readState.slectedBook != null && !readState.isAudioPlaying)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: IgnorePointer(
                      ignoring: !readState.isActionPanelVisible,
                      child: AnimatedSlide(
                        duration: const Duration(milliseconds: 280),
                        curve: Curves.easeOutCubic,
                        offset: readState.isActionPanelVisible
                            ? Offset.zero
                            : const Offset(0, 0.2),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                          opacity: readState.isActionPanelVisible ? 1 : 0,
                          child: ActionBarWidget(
                            onOpenChapters: () =>
                                Scaffold.of(scaffoldContext).openDrawer(),
                            onOpenSettings: () => _showSettings(context),
                            onOpenShare: () => _showShare(context),
                            onOpenBookmark: () => _showBookmark(context),
                            onOpenComments: () => _showComments(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (readState.isAudioPlaying)
                  Positioned(
                    bottom: 16.h,
                    left: 16.w,
                    right: 16.w,
                    child: const BookAudioReaderWidget(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.62,
          minChildSize: 0.45,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return ReadingSettingsModal(controller: scrollController);
          },
        );
      },
    );
  }

  void _showShare(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) => const ShareBookModalWidget(),
    );
  }

  void _showBookmark(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.46,
          minChildSize: 0.35,
          maxChildSize: 0.82,
          expand: false,
          builder: (sheetContext, sheetController) {
            return const BookmarkModalWidget();
          },
        );
      },
    );
  }

  void _showComments(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.72,
          minChildSize: 0.5,
          maxChildSize: 0.94,
          expand: false,
          builder: (_, scrollController) {
            return CommentSection(scrollController: scrollController);
          },
        );
      },
    );
  }
}
