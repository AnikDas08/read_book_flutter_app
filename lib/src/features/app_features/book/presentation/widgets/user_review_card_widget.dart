import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';

class UserReviewCardWidget extends StatelessWidget {
  const UserReviewCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFA6B0C0),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.16),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              14.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: CommonText(
                            text: 'Sarah Chen',
                            fontSize: AppFontSizes.large,
                            fontWeight: FontWeight.w500,
                            textColor: Color(0xFF111111),
                          ),
                        ),
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Color(0xFF98A2B3),
                        ),
                        4.width,
                        const CommonText(
                          text: '2 weeks',
                          fontSize: AppFontSizes.small,
                          fontWeight: FontWeight.w400,
                          textColor: Color(0xFF667085),
                        ),
                      ],
                    ),
                    8.height,
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Padding(
                          padding: EdgeInsets.only(right: 3),
                          child: Icon(
                            Icons.star,
                            size: 14,
                            color: Color(0xFFFFC700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          14.height,
          const CommonText(
            text:
                'This is now in my top 5 favorite novels of all time! The emotional depth and world-building are incredible. Every chapter left me wanting more. A must-read!',
            fontSize: AppFontSizes.medium,
            fontWeight: FontWeight.w400,
            isDescription: true,
            textColor: Color(0xFF344054),
            height: 1.55,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
