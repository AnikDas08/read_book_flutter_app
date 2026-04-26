import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/gen/assets.gen.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';

class NoBooksFoundWidget extends StatelessWidget {
  const NoBooksFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Transform.translate(
        offset: const Offset(0, -70),
        child: SingleChildScrollView(
          padding: const .all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.menu_book_outlined,
                size: 42,
                color: context.color.iconClr,
              ),
              20.height,
              CommonText(
                text: AppString.no_books_found,
                fontSize: AppFontSizes.extraLarge,
                fontWeight: .bold,
                textColor: context.color.headingBoldText,
              ),
              12.height,
              CommonText(
                text: AppString.try_adjusting_your_search_or_filters,
                fontSize: AppFontSizes.medium,
                fontWeight: FontWeight.w400,
                textColor: context.color.subtext,
                textAlign: .center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
