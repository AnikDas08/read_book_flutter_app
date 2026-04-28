import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';

class RewardedAdDialogWidget extends ConsumerWidget {
  const RewardedAdDialogWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = totalSteps == 0 ? 0.0 : currentStep / totalSteps;

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 18.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                minHeight: 8.h,
                color: const Color(0xFF2A26FF),
                backgroundColor: const Color(0xFFD6DAE2),
              ),
            ),
            18.height,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26.r),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 210.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF1D4ED8),
                          Color(0xFF0F766E),
                          Color(0xFFEA580C),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_fill_rounded,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 14.h),
                    child: CommonText(
                      text:
                          '${AppString.sponsored} $currentStep of $totalSteps - 0:29',
                      fontSize: AppFontSizes.title,
                      textColor: const Color(0xFF5F6C80),
                    ),
                  ),
                ],
              ),
            ),
            20.height,
            CommonButton(
              titleText: currentStep == totalSteps
                  ? AppString.Done
                  : 'Finish Ad',
              gradient: const LinearGradient(
                colors: [Color(0xFF2A26FF), Color(0xFF8A42FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              onTap: () {
                ref.read(readProvider.notifier).watchAdForCurrentChapter();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
