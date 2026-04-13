import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/constance/headline_widget.dart';
import 'package:riverpod_tamplates/config/corekit/back_button.dart';
import 'package:riverpod_tamplates/src/features/app_features/story/presentation/widget/story_card_widget.dart';

@RoutePage()
class StoryScreen extends ConsumerWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CommonAppBar(
        disableBack: true,
        hideBack: true,
        titleWidget: _appbarBuilder(context, ref),
        appbarConfig: AppbarConfig(height: 130),
      ),
      body: SmartListLoader(
        itemCount: 30,
        topWidget: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: HeadlineWidget(title: AppString.Short_Stories),
        ),
        itemBuilder: (context, index) {
          return const StoryCardWidget();
        },
      ),
    );
  }

  Widget _appbarBuilder(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
      child: Column(
        children: [
          Row(
            children: [
              const BackButtonWidget(),
              8.width,
              CommonText(
                text: AppString.Short_Stories,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ],
          ),
          8.height,
          CommonText(
            text: AppString.Quick_reads_for_your_busy_day,
            style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: .8)),
          ).start,
          8.height,
          Row(
            children: [
              Expanded(child: _menu(context, title: AppString.top_short_stories, value: 20)),
              10.width,
              Expanded(child: _menu(context, title: AppString.trending_short_stories, value: 30)),
            ],
          ),
        ],
      ),
    );
  }

  Container _menu(BuildContext context, {required String title, required int value}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: .center,
      child: CommonText(
        text: title,
        left: 8, right: 8,
        style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: .8)),
      ),
    );
  }
}
