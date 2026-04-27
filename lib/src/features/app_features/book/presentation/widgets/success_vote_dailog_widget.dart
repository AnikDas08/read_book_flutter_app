import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';

class SuccessVoteDialogWidget extends StatelessWidget {
  final int earnedAmount;
  final int totalAmount;

  const SuccessVoteDialogWidget({
    super.key,
    this.earnedAmount = 2,
    this.totalAmount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 28.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: const BoxDecoration(
              color: Color(0xFF09D04D),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 64,
            ),
          ),
          22.height,
          const CommonText(
            text: 'Vote Completed!',
            fontSize: AppFontSizes.title,
            fontWeight: FontWeight.w700,
            textColor: Color(0xFF111111),
            textAlign: TextAlign.center,
          ),
          16.height,
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                color: Color(0xFF758195),
                fontSize: AppFontSizes.medium,
                fontWeight: FontWeight.w400,
              ),
              children: [
                const TextSpan(text: 'You used '),
                TextSpan(
                  text: '$earnedAmount Power Stones',
                  style: const TextStyle(
                    color: Color(0xFF4D8DFF),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          24.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.electric_bolt_rounded,
                color: Color(0xFFFFC700),
                size: 24,
              ),
              8.width,
              CommonText(
                text: '$totalAmount',
                fontSize: AppFontSizes.display,
                fontWeight: FontWeight.w700,
                textColor: const Color(0xFF111111),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
