import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/book_mark_modal_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/comment_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';

class ActionBarWidget extends ConsumerWidget {
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final bool isBookSelected;
  const ActionBarWidget({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
    this.isBookSelected = false,
  });
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24), // Adjust for desired roundness
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          _buildActionItem(Icons.volume_up_outlined, AppString.listen, iconColor, textColor, () {
            if (isBookSelected) {
              ref.read(readProvider.notifier).toggleAudioPlaying();
            }
          }),
          _buildActionItem(
            Icons.bookmark_add_outlined,
            AppString.bookmark,
            iconColor,
            textColor,
            () {
              if (isBookSelected) {
                showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.45.h,
                      minChildSize: 0.3.h,
                      maxChildSize: 0.95,
                      expand: false,
                      builder: (context, scrollController) {
                        return BookmarkModalWidget();
                      },
                    );
                  },
                );
              }
            },
          ),
          _buildActionItem(
            Icons.chat_bubble_outline,
            AppString.comment,
            iconColor,
            textColor,
            () {
            if (isBookSelected) {
              showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.45.h,
                    minChildSize: 0.3.h,
                    maxChildSize: 0.95,
                    expand: false,
                    builder: (context, scrollController) {
                      return CommentSection(scrollController: scrollController);
                    },
                  );
                },
              );
            }
          },
          ),
          _buildActionItem(Icons.share_outlined, AppString.share, iconColor, textColor, () {}),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    IconData icon,
    String label,
    Color iconColor,
    Color textColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const .symmetric(vertical: 6, horizontal: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
