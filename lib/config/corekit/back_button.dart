import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, this.isDark = true});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.pop();
      },
      child: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.4),
          shape: .circle
        ),
        child:   Icon(Icons.arrow_back_ios, color: isDark? Colors.white : Colors.white,size: 24,),
      ),
    );
  }
}
