import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/gen/assets.gen.dart';

class NoBookSelectedWidget extends StatelessWidget {
  const NoBookSelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        CommonText(
          text: AppString.no_chapter_selected,
          fontSize: 24,
          fontWeight: .w700,
          textColor: context.color.bodyText,
        ),
        8.height,
        CommonText(
          text: '0 ${AppString.words}',
          textColor: context.color.iconClr,
          fontSize: 14,
        ),
        Expanded(child: contentWidget(context)),
        CommonText(
          text: '0 of 0',
          textColor: context.color.iconClr,
          fontSize: 14,
        ).end,
      ],
    );
  }

  Widget contentWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.color.subtleOverlaysShadows,
          width: 1.2.w,
        ),
      ),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          CommonImage(src: Assets.images.openBook).center,
          16.height,
          CommonText(
            text: AppString.oops_no_content_here,
            fontSize: 18,
            fontWeight: .w600,
          ),
          CommonText(
            text: AppString
                .looks_like_this_chapter_is_empty_for_now_lets_find_something_interesting_to_redad,
            isDescription: true,
            fontSize: 14,
            textColor: context.color.subtext,
            fontWeight: .w400,
          ),
          20.height,
          CommonButton(
            titleText: AppString.explore_books,
            buttonWidth: 10,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gradient: context.color.ctaGradientBackgroundAccent,
            onTap: () {
              context.router.navigate(const ExploreRoute());
            },
          ),
        ],
      ),
    );
  }
}
