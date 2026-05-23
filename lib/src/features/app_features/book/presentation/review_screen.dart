import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/corekit/back_button.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';
import 'package:unkutdrama_kpnovel/src/common/share_icon_button.dart';
import 'package:unkutdrama_kpnovel/src/constants/app_font_sizes.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/presentation/widgets/user_review_card_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/presentation/widgets/write_review_modal_widget.dart';

@RoutePage()
class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Review",
        leading: const BackButtonWidget(isDark: false,),

        appbarConfig:  AppbarConfig(
            actions: [
             const ShareIconButton(isDark: false,)
            ],
            titleAlignment: .center,
            decoration: () => const  BoxDecoration(
                color: Colors.white
            )
        ),
      ),
      backgroundColor: context.color.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              22.height,
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(22.w, 20.h, 22.w, 22.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C1D95), Color(0xFFB449D2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFD11A),
                          size: 25,
                        ),
                        10.width,
                        const CommonText(
                          text: '4.0',
                          fontSize: AppFontSizes.display,
                          fontWeight: FontWeight.w700,
                          textColor: Colors.white,
                        ),
                        CommonText(
                          text: '/ 5.0',
                          fontSize: AppFontSizes.extraLarge,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.white.withValues(alpha: 0.7),
                        ),
                      ],
                    ),
                    12.height,
                    const CommonText(
                      text: 'Overall Rating',
                      fontSize: AppFontSizes.medium,
                      fontWeight: FontWeight.w400,
                      textColor: Colors.white,
                    ),
                    4.height,
                    CommonText(
                      text: '${AppString.based_on} 1,247 ${AppString.reviews}',
                      fontSize: AppFontSizes.medium,
                      fontWeight: FontWeight.w400,
                      textColor: Colors.white.withValues(alpha: 0.8),
                    ),
                    18.height,
                    ...const [
                      _RatingBarRow(rank: '5', percent: 0.75, label: '75%'),
                      _RatingBarRow(rank: '4', percent: 0.17, label: '17%'),
                      _RatingBarRow(rank: '3', percent: 0.05, label: '5%'),
                      _RatingBarRow(rank: '2', percent: 0.02, label: '2%'),
                      _RatingBarRow(rank: '1', percent: 0.01, label: '1%'),
                    ],
                    24.height,
                    GestureDetector(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (_) => const Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.symmetric(horizontal: 20),
                            child: WriteReviewModalWidget(),
                          ),
                        );
                      },
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Icon(
                              Icons.star_border_rounded,
                              color: Color(0xFF4C35FF),
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            CommonText(
                              text: 'Write a Review',
                              fontSize: AppFontSizes.large,
                              fontWeight: FontWeight.w700,
                              textColor: Color(0xFF4C35FF),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              18.height,
              const Row(
                children: [
                   CommonText(
                    text: 'Reader Reviews',
                    fontSize: AppFontSizes.extraLarge,
                    fontWeight: FontWeight(500),
                    textColor: Color(0xFF111111),
                  ),
                   Spacer(),
                   CommonText(
                    text: '3 of 112',
                    fontSize: AppFontSizes.medium,
                    fontWeight: FontWeight.w400,
                    textColor: Color(0xFF2E49FF),
                  ),
                ],
              ),
              14.height,
              const UserReviewCardWidget(),
              const UserReviewCardWidget(),
              const UserReviewCardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RatingBarRow extends StatelessWidget {
  const _RatingBarRow({
    required this.rank,
    required this.percent,
    required this.label,
  });

  final String rank;
  final double percent;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        children: [
          SizedBox(
            width: 54.w,
            child: Row(
              children: [
                CommonText(
                  text: rank,
                  fontSize: AppFontSizes.medium,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.white,
                ),
                6.width,
                const Icon(Icons.star, color: Color(0xFFFFD11A), size: 16),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: percent,
                minHeight: 8.h,
                backgroundColor: Colors.white.withValues(alpha: 0.24),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFFFD11A),
                ),
              ),
            ),
          ),
          12.width,
          SizedBox(
            width: 56.w,
            child: CommonText(
              text: label,
              fontSize: AppFontSizes.medium,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.end,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
