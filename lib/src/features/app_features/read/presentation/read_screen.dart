import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/action_bar_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/book_audio_reader_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/book_reading_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/chapters_drawer.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/no_book_selected_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_state.dart';

@RoutePage()
class ReadScreen extends ConsumerWidget {
  const ReadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readState = ref.watch(readProvider);
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                mainAxisSize: .min,
                children: [
                  10.height,
                  if (readState.slectedBook == null)
                  const Expanded(child: NoBookSelectedWidget()),
                  if (readState.slectedBook != null) const Expanded(child: BookReadingWidget()),
              
                  10.height,
                  _buttons(context, readState, ref),
                  16.height,
                  _actionBar(readState, context),
                  5.height,
                ],
              ),
            ),
            if (readState.isAudioPlaying)
              Positioned(
                bottom: 100.h,
                left: 16,
                right: 16,
                child: const SizedBox(height: 300, child: BookAudioReaderWidget()),
              ),
          ],
        ),
      ),
    );
  }

  ActionBarWidget _actionBar(ReadState readState, BuildContext context) {
    final isBookSelected = readState.slectedBook != null;
    final backgroundColor = isBookSelected
        ? context.color.inputBorderFocus.withValues(alpha: 0.1)
        : context.color.lightGray.withValues(alpha: 0.35);
    final iconColor = isBookSelected
        ? context.color.inputBorderFocus
        : context.color.subtext.withValues(alpha: 0.6);

    return ActionBarWidget(
      backgroundColor: backgroundColor,
      iconColor: iconColor,
      textColor: iconColor,
      isBookSelected: isBookSelected,
    );
  }

  Row _buttons(BuildContext context, ReadState readState, WidgetRef ref) {
    const inactiveGradient = LinearGradient(
      colors: [Color(0xff8f8eff), Color(0xffc2a0ff)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    final previousActionOpacity =
        readState.slectedBook == null || readState.slectedBook?.selectedChapter == 0
        ? inactiveGradient
        : context.color.ctaGradientBackgroundAccent;
    final nextActionOpacity =
        readState.slectedBook == null ||
            readState.slectedBook?.selectedChapter ==
                (readState.slectedBook?.chapters.length ?? 0) - 1
        ? inactiveGradient
        : context.color.ctaGradientBackgroundAccent;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: CommonButton(
            titleText: 'Previous',
            borderColor: context.color.bgColor,
            onTap: readState.slectedBook != null && readState.slectedBook!.selectedChapter > 0
                ? () => ref.read(readProvider.notifier).selectChapter(readState.slectedBook!.selectedChapter - 1)
                : null,
            buttonWidth: 130,
            prefix: Icon(Icons.arrow_back_ios_new, color: context.color.buttonTextWhite),
            gradient: previousActionOpacity,
          ),
        ),
        Flexible(
          child: CommonButton(
            titleText: 'Next',
            borderColor: context.color.bgColor,
            onTap: readState.slectedBook != null && readState.slectedBook!.selectedChapter < (readState.slectedBook!.chapters.length - 1)
                ? () => ref.read(readProvider.notifier).selectChapter(readState.slectedBook!.selectedChapter + 1)
                : null,
            buttonWidth: 130,
            suffix: Icon(Icons.arrow_forward_ios, color: context.color.buttonTextWhite),
            gradient: nextActionOpacity,
          ),
        ),
      ],
    );
  }

}
