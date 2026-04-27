import 'package:auto_route/auto_route.dart';
import 'package:core_kit/app_bar/common_app_bar.dart';
import 'package:core_kit/text/common_text.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/corekit/back_button.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/power_stones/presentation/widgets/daily_reward_claim_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/power_stones/presentation/widgets/how_to_use_step_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/power_stones/presentation/widgets/power_stone_card.dart';
import 'package:riverpod_tamplates/src/features/app_features/power_stones/presentation/widgets/watch_ad_card_widget.dart';

@RoutePage()
class PowerStonesScreen extends StatelessWidget {
  const PowerStonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        leading: const BackButtonWidget(isDark: true),

        appbarConfig: AppbarConfig(
          leadingAlignment: .bottomStart,
          decoration: () => const BoxDecoration(color: Colors.white),
        ),
      ),
      backgroundColor: context.color.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    CommonText(
                      text: AppString.power_stones,
                      fontSize: AppFontSizes.extraLarge,
                      fontWeight: FontWeight.w500,
                      textColor: context.color.headingBoldText,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => context.router.push(
                        const UsedPowerStonesHistoryRoute(),
                      ),
                      child: const CommonText(
                        text: 'View History',
                        fontSize: AppFontSizes.medium,
                        textColor: Color(0xFF1C1CFF),
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              34.height,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: PowerStonesCard(),
              ),
              20.height,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(height: 108, child: DailyBonusBanner()),
              ),
              20.height,
              const WatchAdsCardWidget(),
              20.height,
              const HowToUseStepWidget(),
              50.height,
            ],
          ),
        ),
      ),
    );
  }
}
