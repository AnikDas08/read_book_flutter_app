import 'package:core_kit/text/common_text.dart';
import 'package:core_kit/text_field/common_text_field.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/common/notification_button_widget.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/explore/riverpod/explore_notifire.dart';

class ExploreScreenAppbar extends StatelessWidget {
  const ExploreScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final notifier = ref.read(exploreNotifireProvider.notifier);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Spacer(),
            18.height,
            Row(
              children: [
                16.width,
                CommonText(
                  text: AppString.Explore,
                  fontSize: AppFontSizes.heading,
                  fontWeight: .bold,
                  textColor: context.color.buttonTextWhite,
                ),
                const Spacer(),
                const NotificationButtonWidget(),
                16.width,
              ],
            ),
            12.height,
            Row(
              children: [
                16.width,
                Expanded(
                  child: SizedBox(
                    height: 36,
                    child: CommonTextField(
                      onChanged: (value) {
                        notifier.onSearchChanged(value);
                      },
                      validationType: .notRequired,
                      backgroundColor: context.color.blue300.withValues(
                        alpha: 0.4,
                      ),
                      borderWidth: 1.2,
                      borderColor: context.color.cardsInputFields.withValues(
                        alpha: 0.5,
                      ),
                      hintText: AppString.search_by_title_author_or_genre,
                      borderRadius: 40,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: AppFontSizes.small,
                      ),
                      hintStyle: TextStyle(
                        fontSize: AppFontSizes.small,
                        color: context.color.buttonTextWhite.withValues(
                          alpha: 0.6,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: context.color.buttonTextWhite.withValues(
                          alpha: 0.6,
                        ),
                        size: 30,
                      ),
                    ),
                  ),
                ),
                16.width,
              ],
            ),
           const Spacer()
          ],
        );
      },
    );
  }
}
