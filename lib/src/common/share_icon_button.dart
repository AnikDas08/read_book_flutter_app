import 'package:core_kit/list_loader/smart_tab_list_loader.dart';
import 'package:flutter/material.dart';

class ShareIconButton extends StatelessWidget {
  const ShareIconButton({super.key, this.isDark = true});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: (){
       },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xff563fff).withValues(alpha: 0.3)
              : Colors.black.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.share, color: isDark ? Colors.white : Colors.white),
      ),
    );
  }
}
