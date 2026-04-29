import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/corekit/back_button.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';

import 'package:riverpod_tamplates/src/features/core_features/profile/application/language_notifier.dart';

@RoutePage()
class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  static const _languages = [
    'English',
    'Spanish',
    'Mandarin Chinese',
    'Hindi',
    'French',
    'Arabic',
    'Portuguese',
    'Korean',
    'Igbo',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.watch(languageProvider);

    return Scaffold(
      appBar: CommonAppBar(
        leading: const BackButtonWidget(isDark: true),
        appbarConfig: AppbarConfig(
          leadingAlignment: .bottomStart,
          leadingPadding: .zero,
          decoration: () => const BoxDecoration(color: Colors.white),
        ),
      ),
      backgroundColor: context.color.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.height,
              CommonText(
                text: 'Language',
                fontSize: AppFontSizes.extraLarge,
                fontWeight: FontWeight.w700,
                textColor: context.color.headingBoldText,
              ),
              34.height,
              Expanded(
                child: ListView.builder(
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final language = _languages[index];
                    final isSelected = selectedLanguage == language;
                    return GestureDetector(
                      onTap: () => ref
                          .read(languageProvider.notifier)
                          .changeLanguage(language),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF1C1CFF),
                                  width: 2.5,
                                ),
                              ),
                              child: isSelected
                                  ? const DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1C1CFF),
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                  : null,
                            ),
                            20.width,
                            CommonText(
                              text: language,
                              fontSize: AppFontSizes.medium,
                              fontWeight: FontWeight.w600,
                              textColor: const Color(0xFF333333),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
