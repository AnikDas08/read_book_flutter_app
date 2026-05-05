import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';

class SuccessRewardDialogWidget extends StatelessWidget {
  final int earnedAmount;
  final int totalAmount;

  const SuccessRewardDialogWidget({super.key, this.earnedAmount = 2, this.totalAmount = 7});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.bgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          40.height,
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFF00D24B), // Success Green
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_rounded, color: Colors.white, size: 50),
          ),
          24.height,

          // 2. Success Title
          CommonText(
            text: AppString.success,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1C1E),
            ),
          ),
          16.height,

          // 3. RichText for Reward Message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(color: Color(0xFF5F6368), fontSize: 16),
                children: [
                  TextSpan(text: earnedAmount > 0 ? AppString.you_earned : 'Chapter Unlocked Successfully!'),
                  if (earnedAmount > 0)
                    TextSpan(
                      text: ' +$earnedAmount ${AppString.power_stones}',
                      style: const TextStyle(
                        color: Color(0xFFFFC107), // Gold/Yellow
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ),
          24.height,

          if (totalAmount > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.electric_bolt_outlined, color: Color(0xFFFFC107), size: 40),
                const SizedBox(width: 8),
                CommonText(
                  text: '$totalAmount',
                  style: const TextStyle(fontSize: 32, color: Color(0xFF1A1C1E)),
                ),
              ],
            ),
          20.height,
        ],
      ),
    );
  }
}
