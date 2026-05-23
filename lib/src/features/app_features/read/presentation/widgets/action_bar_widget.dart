import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';
import 'package:unkutdrama_kpnovel/gen/assets.gen.dart';
import 'package:unkutdrama_kpnovel/src/constants/app_font_sizes.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/riverpod/read_notifier.dart';

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
      height: 160.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16),
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
            fontSize: AppFontSizes.medium,
            fontWeight: FontWeight.w600,
            textColor: const Color(0xFF111827),
          ),
          4.height,
          CommonText(
            text: chapter.title ?? '',
            fontSize: AppFontSizes.small,
            fontWeight: FontWeight.w400,
            textColor: const Color(0xFF697386),
          ),
          12.height,
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 4.h,
              color: context.color.blue500,
              backgroundColor: const Color(0xFFD9DCE3),
            ),
          ),
          18.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionItem(Assets.images.menu, onOpenChapters),
              _buildActionItem(Assets.images.settings, onOpenSettings),
              _buildActionItem(
                Assets.images.audio,
                () => ref.read(readProvider.notifier).toggleAudioPlaying(),
              ),
              _buildActionItem(Assets.images.share, onOpenShare),
              _buildActionItem(Assets.images.bookmark, onOpenBookmark),
              _buildActionItem(Assets.images.message, onOpenComments),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(String icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: CommonImage(src: icon, size: 24),
      ),
    );
  }
}
