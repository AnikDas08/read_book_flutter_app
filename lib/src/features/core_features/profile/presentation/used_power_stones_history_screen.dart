import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';

@RoutePage()
class UsedPowerStonesHistoryScreen extends StatelessWidget {
  const UsedPowerStonesHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.height,
              const _PlainBackButton(),
              12.height,
              CommonText(
                text: 'Used Power Stones History',
                fontSize: AppFontSizes.extraLarge,
                fontWeight: FontWeight.w500,
                textColor: context.color.headingBoldText,
              ),
              24.height,
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: 6,
                  separatorBuilder: (_, _) => 12.height,
                  itemBuilder: (_, _) => const _HistoryTile(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: context.color.bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFD7BAFF),
            child: Icon(Icons.history, color: Colors.white, size: 22),
          ),
          16.width,
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: 'Shadow of the Moon',
                fontSize: AppFontSizes.medium,
                fontWeight: FontWeight.w500,
                textColor: Color(0xFF333333),
              ),
              CommonText(
                text: 'You used 2 stones',
                fontSize: AppFontSizes.small,
                textColor: Color(0xFF4B5563),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlainBackButton extends StatelessWidget {
  const _PlainBackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pop(),
      child: const SizedBox(
        width: 40,
        height: 40,
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFF1C1CFF),
          size: 24,
        ),
      ),
    );
  }
}
