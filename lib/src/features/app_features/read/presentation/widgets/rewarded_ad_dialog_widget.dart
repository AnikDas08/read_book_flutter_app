import 'dart:async';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';

class RewardedAdDialogWidget extends ConsumerStatefulWidget {
  const RewardedAdDialogWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  ConsumerState<RewardedAdDialogWidget> createState() =>
      _RewardedAdDialogWidgetState();
}

class _RewardedAdDialogWidgetState extends ConsumerState<RewardedAdDialogWidget> {
  int _secondsRemaining = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        if (mounted) {
          setState(() {
            _secondsRemaining--;
          });
        }
      } else {
        _timer?.cancel();
        if (mounted) {
          _onAdFinished();
        }
      }
    });
  }

  void _onAdFinished() {
    ref.read(readProvider.notifier).watchAdForCurrentChapter();
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Smooth progress bar across all ads
    final adProgress = 1 - (_secondsRemaining / 5);
    final overallProgress = widget.totalSteps == 0
        ? 0.0
        : (widget.currentStep - 1 + adProgress) / widget.totalSteps;

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 18.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: List.generate(widget.totalSteps, (index) {
                double segmentProgress = 0.0;
                if (index < widget.currentStep - 1) {
                  segmentProgress = 1.0;
                } else if (index == widget.currentStep - 1) {
                  segmentProgress = 1 - (_secondsRemaining / 5);
                }

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index == widget.totalSteps - 1 ? 0 : 6.w,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: LinearProgressIndicator(
                        value: segmentProgress.clamp(0.0, 1.0),
                        minHeight: 5.h,
                        color: const Color(0xFF2A26FF),
                        backgroundColor: const Color(0xFFD6DAE2),
                      ),
                    ),
                  ),
                );
              }),
            ),
            18.height,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200.h,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: CommonText(
                      text:
                          '${AppString.sponsored} ${widget.currentStep} of ${widget.totalSteps} - 0:${_secondsRemaining.toString().padLeft(2, '0')}',
                      fontSize: AppFontSizes.small,
                      textColor: const Color(0xFF5F6C80),
                    ),
                  ),
                ],
              ),
            ),
            12.height,
          ],
        ),
      ),
    );
  }
}
