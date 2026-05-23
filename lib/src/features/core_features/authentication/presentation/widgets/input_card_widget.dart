import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';

class InputCardWidget extends StatelessWidget {
  const InputCardWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
      decoration: BoxDecoration(
        color: context.color.bgColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border(
          top: BorderSide(color: context.color.blue300, width: 2.h),
        ),
      ),
      child: child,
    );
  }
}
