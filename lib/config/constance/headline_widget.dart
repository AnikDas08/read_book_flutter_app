import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';

class HeadlineWidget extends StatelessWidget {
  final String title;
  const HeadlineWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CommonText(
      text: title,
      fontSize: 18,
      fontWeight: .bold,
      textColor: context.color.headingBoldText,
    );
  }
}
