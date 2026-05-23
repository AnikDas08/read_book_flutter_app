import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/presentation/widgets/write_review_modal_widget.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF8A32B6), // Deep purple background
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.yellow, size: 40),
              8.width,
              const CommonText(
                text: '4.0',
                textColor: Colors.white,
                fontSize: 48,
                fontWeight: .bold,
              ),
              8.width,
              CommonText(text: '/ 5.0', textColor: Colors.white.withOpacity(0.7), fontSize: 24),
            ],
          ),
          CommonText(text: AppString.overall_rating, textColor: Colors.white, fontSize: 18),
          CommonText(
            text: '${AppString.based_on} 1,247 ${AppString.reviews}',
            textColor: Colors.white.withOpacity(0.6),
            fontSize: 14,
          ),

          10.height,

          // 2. Rating Breakdown Bars
          _buildRatingRow('5', 0.75, '75%'),
          _buildRatingRow('4', 0.17, '17%'),
          _buildRatingRow('3', 0.05, '5%'),
          _buildRatingRow('2', 0.02, '2%'),
          _buildRatingRow('1', 0.01, '1%'),

          32.height,

          CommonButton(
            titleText: AppString.write_a_review,
            buttonColor: context.color.bgColor,
            borderColor: Colors.white,
            titleColor: context.color.blue400,
            prefix: Icon(Icons.star_border, color: context.color.blue400, size: 30),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const Dialog(child: WriteReviewModalWidget()),
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper widget to build the individual rating rows
  Widget _buildRatingRow(String starNumber, double percent, String trailingText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          CommonText(text: starNumber, textColor: Colors.white, fontSize: 16, fontWeight: .bold),
          4.width,
          const Icon(Icons.star, color: Colors.yellow, size: 16),
          12.width,
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: percent,
                minHeight: 8,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.yellow),
              ),
            ),
          ),
          12.width,
          SizedBox(
            width: 35,
            child: CommonText(
              text: trailingText,
              textColor: Colors.white,
              fontSize: 14,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
