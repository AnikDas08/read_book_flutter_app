import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({
    super.key,
    this.isCompleted = false,
    this.showProgress = false,
    this.isTrending = false,
    this.isNew = false,
  });

  final bool isCompleted;
  final bool showProgress;
  final bool isTrending;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.navigate(const BookDetailsRoute());
      },
      child: Container(
        margin: .zero,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
                      child: const CommonImage(src: Constants.sampleImage),
                    ),
                  ),
                  if (showProgress) ...[
                    // Library Status Badge
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(

                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: CommonText(
                          text: isCompleted ? 'Completed' : 'Ongoing',
                          fontSize: 10.sp,
                          fontWeight: const FontWeight(400),
                          textColor: isCompleted ? const Color(0xFF00D121) : const Color(0xFFF59E0B),
                        ),
                      ),
                    ),
                    // Library Progress Section
                    Positioned(
                      bottom: 6,
                      left: 6,
                      right: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: isCompleted ? '10' : '5',
                                  style: TextStyle(
                                    fontSize: AppFontSizes.small,
                                    fontWeight: FontWeight.bold,
                                    color: isCompleted ? const Color(0xFF352CFF) : const Color(0xFFFFD600),
                                  ),
                                ),
                               const TextSpan(
                                  text: '/10',
                                  style: TextStyle(
                                    fontSize: AppFontSizes.small,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                              style: const TextStyle(
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 4,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          6.height,
                          Container(
                            height: 4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: isCompleted ? 1.0 : 0.5,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isCompleted ? const Color(0xFF352CFF) : const Color(0xFFFFD600),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else if (isNew || isTrending) ...[
                    // Home Badges
                    Positioned(top: 8, left: 8, child: _buildHomeBadge(context)),
                  ],
                ],
              ),
            ),
            // Content Section
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    textAlign: .start,
                    text: 'Echoes of Tomorrow',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFontSizes.small,
                    fontWeight: FontWeight(400),
                    textColor:  Color(0xFF111111),
                  ),
                  if (!showProgress) ...[
                    4.height,
                    CommonText(
                      text: 'Dr. Sarah Chen',
                      fontSize: AppFontSizes.small,
                      textColor: context.color.subtext,
                    ),
                    8.height,
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        Icon(Icons.star, color: Colors.grey.withOpacity(0.4), size: 16),
                        8.width,
                       const CommonText(
                          text: '4.0 / 5',
                          fontSize: AppFontSizes.small,
                          fontWeight: FontWeight.bold,
                          textColor:  Color(0xFF333333),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isNew ? const Color(0xFFFFD700) : null,
        gradient: isTrending ? context.color.ctaGradientBackgroundAccent : null,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isNew ? Icons.auto_awesome : Icons.trending_up_outlined,
            size: 10,
            color: isNew ? const Color(0xFF5E35B1) : Colors.white,
          ),
          4.width,
          CommonText(
            text: isNew ? AppString.New : AppString.Trending,
            fontSize: AppFontSizes.caption,
            fontWeight: FontWeight.bold,
            textColor: isNew ? const Color(0xFF5E35B1) : Colors.white,
          ),
        ],
      ),
    );
  }
}
