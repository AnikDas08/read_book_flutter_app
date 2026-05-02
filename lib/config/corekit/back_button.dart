import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, this.iconColor, this.isDark});
  final bool? isDark;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.pop();
      },
      child: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: (isDark != null && isDark == true)
              ? Colors.white.withValues(alpha: 0.2)
              : Colors.black.withValues(alpha: 0.4),
          shape: .circle,
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios,
            color: iconColor ?? Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
