import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';

class ActionBarWidget extends ConsumerWidget {
  const ActionBarWidget({
    super.key,
    required this.onOpenChapters,
    required this.onOpenSettings,
    required this.onOpenShare,
    required this.onOpenBookmark,
    required this.onOpenComments,
  });

  final VoidCallback onOpenChapters;
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenShare;
  final VoidCallback onOpenBookmark;
  final VoidCallback onOpenComments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readState = ref.watch(readProvider);
    final book = readState.slectedBook;
    if (book == null) return const SizedBox.shrink();

    final chapter = book.chapters[book.selectedChapter];
    final progress = book.chapters.length <= 1
        ? 0.0
        : book.selectedChapter / (book.chapters.length - 1);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: book.title ?? AppString.shadow_of_the_violet_moon,
            fontSize: AppFontSizes.title,
            fontWeight: FontWeight.w700,
            textColor: const Color(0xFF111827),
          ),
          4.height,
          CommonText(
            text: chapter.title ?? '',
            fontSize: AppFontSizes.extraLarge,
            textColor: const Color(0xFF697386),
          ),
          18.height,
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 7.h,
              color: context.color.blue500,
              backgroundColor: const Color(0xFFD9DCE3),
            ),
          ),
          18.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionItem(Icons.menu_rounded, onOpenChapters),
              _buildActionItem(Icons.tune_rounded, onOpenSettings),
              _buildActionItem(
                Icons.volume_up_outlined,
                () => ref.read(readProvider.notifier).toggleAudioPlaying(),
              ),
              _buildActionItem(Icons.share_outlined, onOpenShare),
              _buildActionItem(Icons.bookmark_add_outlined, onOpenBookmark),
              _buildActionItem(
                Icons.chat_bubble_outline_rounded,
                onOpenComments,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Icon(icon, color: const Color(0xFF4D7DFF), size: 28),
      ),
    );
  }
}
