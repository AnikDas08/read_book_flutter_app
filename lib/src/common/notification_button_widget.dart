import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';
import 'package:unkutdrama_kpnovel/gen/assets.gen.dart';

class NotificationButtonWidget extends StatelessWidget {
  const NotificationButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(const NotificationRoute());
      },
      child: Badge(
        label: const Text('1'),
        child: CommonImage(
          src: Assets.images.notificaiton,
          imageColor: context.color.buttonTextWhite,
        ),
      ),
    );
  }
}
