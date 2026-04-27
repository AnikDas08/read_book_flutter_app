import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/gen/assets.gen.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/power_stones/presentation/widgets/success_reward_dailog_widget.dart';

class DailyBonusBanner extends StatelessWidget {
  const DailyBonusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6236FF), Color(0xFF9136FF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: CommonImage(src: Assets.images.giftBox),
          ),
          10.width,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  text: AppString.daily_bonus,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: AppFontSizes.extraLarge,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                CommonText(
                  text: AppString.power_stones_5,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: AppFontSizes.medium,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) =>
                    const Dialog(child: SuccessRewardDialogWidget()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: CommonText(
                text: AppString.claim,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSizes.large,
                  color: Color(0xFFFFA000),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
