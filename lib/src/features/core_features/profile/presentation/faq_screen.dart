import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';

@RoutePage()
class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  static const _question = 'How Share Charge works?';
  static const _answer =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.bgColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 92, 20, 30),
          children: [
            const _PlainBackButton(),
            92.height,
            CommonText(
              text: "FAQ's",
              fontSize: AppFontSizes.heading,
              fontWeight: .bold,
              textColor: context.color.headingBoldText,
            ),
            34.height,
            const _FaqTile(isOpen: true),
            16.height,
            ...List.generate(
              6,
              (_) => const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: _FaqTile(isOpen: false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.isOpen});

  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, isOpen ? 20 : 0, 12, isOpen ? 18 : 0),
      constraints: BoxConstraints(minHeight: isOpen ? 210 : 68),
      decoration: BoxDecoration(
        color: context.color.bgColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Expanded(
                child: CommonText(
                  text: FaqScreen._question,
                  fontSize: AppFontSizes.heading,
                  textColor: Color(0xFF333333),
                ),
              ),
              Icon(
                isOpen ? Icons.remove : Icons.add,
                size: 32,
                color: isOpen ? Colors.black : const Color(0xFF9CA3AF),
              ),
            ],
          ),
          if (isOpen) ...[
            14.height,
            const Divider(height: 1, color: Color(0xFFE5E7EB)),
            18.height,
            const CommonText(
              text: FaqScreen._answer,
              fontSize: AppFontSizes.extraLarge,
              textColor: Color(0xFF6B7280),
              textAlign: TextAlign.left,
              isDescription: true,
            ),
          ],
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
        width: 48,
        height: 48,
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFF1C1CFF),
          size: 24,
        ),
      ),
    );
  }
}
