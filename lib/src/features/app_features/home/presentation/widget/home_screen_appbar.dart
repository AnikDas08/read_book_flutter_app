import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/constance/constants.dart';
import 'package:unkutdrama_kpnovel/gen/assets.gen.dart';
import 'package:unkutdrama_kpnovel/src/common/notification_button_widget.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonImage(
                    src: Assets.images.appName,
                    width: 111,
                    fill: .contain,
                    height: 28,
                    enableAspectRatio: true,
                  ),
                  CommonText(
                    text: AppString.discover_your_next_story,
                    fontSize: 14,
                    textColor: Colors.white.withValues(alpha: 0.9),
                  ),
                ],
              ),
              const NotificationButtonWidget(),
            ],
          ),
          6.height,
          SizedBox(
            height: 90.h,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    padding: EdgeInsets.only(top: 4.h, left: 16.w, right: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(
                        0.15,
                      ), // Semi-transparent glass effect
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CommonText(
                          text: AppString.continue_reading,
                          textColor: Colors.white70,
                          fontSize: 12,
                        ).start,
                        2.height,
                        Row(
                          children: [
                            // Book Cover
                            const CommonImage(
                              src: Constants.sampleImage,
                              size: 48,
                              borderRadius: 8,
                            ),
                            8.width,
                            // Book Progress Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CommonText(
                                    text: 'Shadow of the Moon',
                                    textColor: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  CommonText(
                                    text: AppString.chapter(20, 87),
                                    textColor: Colors.white60,
                                    fontSize: 12,
                                  ),
                                  const SizedBox(height: 8),
                                  // Custom Progress Bar
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: const LinearProgressIndicator(
                                      value: 0.4, // Progress percentage
                                      minHeight: 6,
                                      backgroundColor: Colors.white24,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFFFFD700),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
