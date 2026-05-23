import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';

class HowToUseStepWidget extends StatelessWidget {
  const HowToUseStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FE), // Very light purple/grey background
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonText(
            text: AppString.how_to_use_power_stones,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),
          10.height,
          _steps(
            context,
            '1',
            AppString.vote_for_books,
            AppString.support_your_favorite_books_and_authors,
          ),
          const Divider(),
          _steps(
            context,
            '2',
            AppString.unlock_chapters,
            AppString.use_power_stones_to_unlock_premium_chapters_and_support_authors,
          ),
        ],
      ),
    );
  }

  Row _steps(BuildContext context, String step, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: context.color.ctaGradientBackgroundAccent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: context.color.bgColor),
          ),
          alignment: Alignment.center,
          child: Text(
            step,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        10.width,

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B263B),
                ),
              ),
              4.height,
              CommonText(
                text: description,
                textAlign: .start,
                isDescription: true,
                style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
