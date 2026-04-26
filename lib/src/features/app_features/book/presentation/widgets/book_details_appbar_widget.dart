import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/corekit/back_button.dart';
import 'package:riverpod_tamplates/src/common/share_icon_button.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';

class BookDetailsAppbarWidget extends StatelessWidget {
  const BookDetailsAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16),

      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              CommonText(
                textAlign: .center,
                overflow: .ellipsis,
                text: 'Shadow of the Violet',
                autoResize: false,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppFontSizes.heading,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ShareIconButton(),
            ],
          ),
          10.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonImage(
                src: Constants.sampleImage,
                height: 82,
                width: 60,
                borderRadius: 8,
                borderWidth: 1,
                borderOffset: 1,
                enableAspectRatio: true,
                borderColor: Colors.white,
              ),
              16.width,

              // 2. Book Info Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• Elena Nightshade',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14.sp,
                      ),
                    ),
                    6.height,

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildStatChip(
                            Icons.star,
                            '4.8',
                            const Color(0xFF3B1E99),
                          ),
                          8.width,
                          _buildStatChip(
                            Icons.people_outline,
                            '1.2M reviews',
                            const Color(0xFF3B1E99),
                          ),
                          8.width,
                          _buildStatChip(
                            null,
                            'Age Demand: 18+',
                            const Color(0xFF3B1E99),
                          ),
                        ],
                      ),
                    ),
                    10.height,

                    // 4. Genre Tags
                    Row(
                      children: [
                        _buildGenreTag('Fantasy'),
                        8.width,
                        _buildGenreTag('Romance'),
                        8.width,
                        _buildGenreTag('Magic'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper for the dark stat chips
  Widget _buildStatChip(IconData? icon, String label, Color bgColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: icon == Icons.star ? Colors.amber : Colors.white,
              size: 16.w,
            ),
            4.width,
          ],
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  // Helper for the light genre tags
  Widget _buildGenreTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.deepPurple,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
