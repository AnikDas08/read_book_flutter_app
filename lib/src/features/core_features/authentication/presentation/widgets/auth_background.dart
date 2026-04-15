import 'package:core_kit/app_bar/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/corekit/back_button.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child, this.hideBack = false});
  final Widget child;
  final bool hideBack;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        hideBack: hideBack,
        disableBack: hideBack,

        appbarConfig: AppbarConfig(
          backButton: const BackButtonWidget(isDark: false),
          decoration: () => const BoxDecoration(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(flex: 2, child: Container(color: context.color.bgColor)),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(gradient: context.color.ctaGradientBackgroundAccent),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(child: SafeArea(child: child)),
        ],
      ),
    );
  }
}
