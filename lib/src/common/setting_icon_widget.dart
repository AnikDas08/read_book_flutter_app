import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';

class SettingButtonWidget extends StatelessWidget {
  const SettingButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(const ProfileRoute());
      },
      child: Icon(
        Icons.settings_outlined,
        color: context.color.buttonTextWhite,
      ),
    );
  }
}
