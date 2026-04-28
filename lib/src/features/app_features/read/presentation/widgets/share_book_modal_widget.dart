import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';

class ShareBookModalWidget extends ConsumerWidget {
  const ShareBookModalWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readState = ref.watch(readProvider);
    final book = readState.slectedBook;
    final fontSize = readState.fontSize;
    final titleFontSize = fontSize.clamp(16.0, 18.0);
    final subtitleFontSize = (fontSize - 1).clamp(14.0, 16.0);

    return Container(
      padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 28.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 70.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: const Color(0xFFD8DCE5),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          22.height,
          Row(
            children: [
              const Icon(
                Icons.share_outlined,
                size: 28,
                color: Color(0xFF111111),
              ),
              14.width,
              Expanded(
                child: CommonText(
                  text: AppString.share_author_and_book_pages,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w700,
                  textColor: const Color(0xFF111111),
                ),
              ),
            ],
          ),
          10.height,
          CommonText(
            text: book?.title ?? AppString.shadow_of_the_violet_moon,
            left: 42,
            fontSize: subtitleFontSize,
            textColor: const Color(0xFF4B5563),
          ),
          28.height,
          CommonText(
            text: AppString.share_via,
            fontSize: subtitleFontSize,
            fontWeight: FontWeight.w500,
            textColor: const Color(0xFF111111),
          ),
          28.height,
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ShareItem(
                label: 'WhatsApp',
                color: Color(0xFF11C65B),
                icon: Icons.chat_bubble_outline_rounded,
              ),
              _ShareItem(
                label: 'Facebook',
                color: Color(0xFF2563EB),
                icon: Icons.facebook_rounded,
              ),
              _ShareItem(
                label: 'Email',
                color: Color(0xFF475569),
                icon: Icons.email_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShareItem extends StatelessWidget {
  const _ShareItem({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        14.height,
        CommonText(
          text: label,
          fontSize: AppFontSizes.extraLarge,
          textColor: const Color(0xFF64748B),
        ),
      ],
    );
  }
}
