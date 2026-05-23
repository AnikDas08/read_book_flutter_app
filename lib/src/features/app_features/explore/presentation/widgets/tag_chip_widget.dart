import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';

class TagChip extends StatelessWidget {
  final String label;

  const TagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.color.bgColor,
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: CommonText(
        text: label,
        fontSize: 14,
        left: 10,
        right: 10,
        top: 5,
        borderColor: Colors.white,
        bottom: 5,
        fontWeight: .w500,
        textColor: const Color(0xff364153),
      ),
    );
  }
}
