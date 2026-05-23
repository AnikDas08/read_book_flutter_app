import 'dart:async';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/src/constants/app_font_sizes.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/power_stones/riverpod/power_stone_notifier.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/power_stones/presentation/widgets/success_reward_dailog_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/riverpod/read_notifier.dart';

enum RewardType { reading, powerStone }

class RewardedAdDialogWidget extends ConsumerStatefulWidget {
  const RewardedAdDialogWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.rewardType = RewardType.reading,
  });

  final int currentStep;
  final int totalSteps;
  final RewardType rewardType;

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
    if (widget.rewardType == RewardType.reading) {
      ref.read(readProvider.notifier).watchAdForCurrentChapter();
      
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      final book = ref.read(readProvider).slectedBook;
      final currentChapter = book?.chapters[book.selectedChapter];
      
      if (currentChapter != null && currentChapter.isLocked) {
        // Still locked, maybe need another ad? 
        // We can show another dialog or just let the user click "Watch" again.
        // For a smoother flow, we could auto-trigger the next one, but 
        // usually users prefer a break between ads.
      } else {
        // Unlocked!
        showDialog(
          context: context,
          builder: (context) => const Dialog(
            child: SuccessRewardDialogWidget(
              earnedAmount: 0,
              totalAmount: 0, // Not applicable for chapter unlock
            ),
          ),
        );
      }
    } else {
      ref.read(powerStoneProvider.notifier).incrementAdsWatched();
      final stoneState = ref.read(powerStoneProvider);
      
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: SuccessRewardDialogWidget(
            earnedAmount: 2,
            totalAmount: stoneState.availableStones,
          ),
        ),
      );
    }
  }

  Future<bool> _showExitConfirmation() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit Ad?'),
            content: const Text('If you exit now, you won\'t get any rewards.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Exit'),
              ),
            ],
          ),
        ) ??
        false;
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

    return WillPopScope(
      onWillPop: _showExitConfirmation,
      child: Dialog(
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
      ),
    );
  }
}
