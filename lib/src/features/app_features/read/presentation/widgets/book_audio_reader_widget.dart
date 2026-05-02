import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';

class BookAudioReaderWidget extends ConsumerWidget {
  const BookAudioReaderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readState = ref.watch(readProvider);
    final book = readState.slectedBook;
    final chapter = book == null ? null : book.chapters[book.selectedChapter];
    final baseFontSize = readState.fontSize;
    final smallFontSize = (baseFontSize - 1).clamp(12.0, 14.0);

    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.50,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 30,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2A26FF), Color(0xFF863BFF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: const Icon(
                        Icons.volume_up_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    12.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: AppString.Audio_Narration,
                            fontSize: AppFontSizes.small,
                            textColor: Colors.white70,
                          ),
                          4.height,
                          CommonText(
                            text: chapter?.title ?? 'Chapter 1: The Beginning',
                            fontSize: AppFontSizes.medium,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.white,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: .start,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          ref.read(readProvider.notifier).toggleAudioPlaying(),
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        width: 32.w,
                        height: 22.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: const Color(0xFF2A26FF),
                      inactiveTrackColor: const Color(0xFFE4E7EE),
                      thumbColor: const Color(0xFF2A26FF),
                      trackHeight: 4.h,
                      padding: .only(
                        left: 16.w,
                        right: 16.h,
                        top: 30.h,
                        bottom: 12.h,
                      ),
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 5,
                      ),
                    ),
                    child: Slider(value: 0.04, onChanged: (_) {}),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0:00',
                          style: TextStyle(
                            fontSize: smallFontSize,
                            color: const Color(0xFF667085),
                          ),
                        ),
                        Text(
                          '14:05',
                          style: TextStyle(
                            fontSize: smallFontSize,
                            color: const Color(0xFF667085),
                          ),
                        ),
                      ],
                    ),
                  ),
                  14.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.volume_up_outlined,
                          size: 20,
                          color: Color(0xFF667085),
                        ),
                        20.width,

                        SizedBox(
                          width: 70.w,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: const Color(0xFF2A26FF),
                              inactiveTrackColor: const Color(0xFFE4E7EE),
                              thumbColor: const Color(0xFF2A26FF),
                              padding: .symmetric(horizontal: 0.w),
                              trackHeight: 4.h,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 5,
                              ),
                            ),
                            child: Slider(value: 0.15, onChanged: (_) {}),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.skip_previous_rounded,
                          size: 20,
                          color: Color(0xFF667085),
                        ),
                        8.width,
                        Container(
                          width: 56.w,
                          height: 56.w,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2A26FF), Color(0xFF8A42FF)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.14),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        8.width,
                        const Icon(
                          Icons.skip_next_rounded,
                          size: 20,
                          color: Color(0xFF667085),
                        ),
                        10.width,
                        const CommonText(
                          text: '1.0x',
                          fontSize: AppFontSizes.medium,
                          fontWeight: FontWeight.w700,
                          textColor: Color(0xFF667085),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              16.height,
              const Divider(height: 1, color: Color(0xFFE4E7EE)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: CommonText(
                  text: AppString.narrated_by_ai_voice_english,
                  fontSize: AppFontSizes.small,
                  textColor: const Color(0xFF667085),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
