import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';

Widget inputLabel(String title, BuildContext context) {
  return CommonText(text: title, fontSize: 14, textColor: context.color.bodyText, bottom: 4);
}
