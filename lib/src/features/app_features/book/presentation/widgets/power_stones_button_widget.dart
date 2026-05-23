import 'package:auto_route/auto_route.dart';
import 'package:core_kit/text/common_text.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';

class PowerStonesButtonWidget extends StatelessWidget {
  const PowerStonesButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _powerStones(context);
  }

  Widget _powerStones(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(const PowerStonesRoute());
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xffe89100),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xffeda733),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(Icons.electric_bolt_outlined, color: Colors.white),
            ),
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  CommonText(
                    text: AppString.power_stones,
                    fontSize: 18,
                    textColor: context.color.buttonTextWhite,
                    fontWeight: .bold,
                  ),
                  CommonText(
                    text: AppString.earn_rewards,
                    fontSize: 14,
                    fontWeight: .w500,
                    textColor: context.color.buttonTextWhite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
