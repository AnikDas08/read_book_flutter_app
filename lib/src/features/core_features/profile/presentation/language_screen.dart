import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';

@RoutePage()
class LanguageScreen extends ConsumerStatefulWidget {
  const LanguageScreen({super.key});

  @override
  ConsumerState<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen> {
  final _languageController = ValueNotifier<String>('English');

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
  void dispose() {
    _languageController.dispose();
    super.dispose();
  }

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
              48.height,
              const _PlainBackButton(),
              24.height,
              CommonText(
                text: 'Language',
                fontSize: AppFontSizes.extraLarge,
                fontWeight: FontWeight.w700,
                textColor: context.color.headingBoldText,
              ),
              34.height,
              Expanded(
                child: ValueListenableBuilder<String>(
                  valueListenable: _languageController,
                  builder: (context, selectedLanguage, _) {
                    return ListView.builder(
                      itemCount: _languages.length,
                      itemBuilder: (context, index) {
                        final language = _languages[index];
                        final isSelected = selectedLanguage == language;
                        return GestureDetector(
                          onTap: () => _languageController.value = language,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
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
