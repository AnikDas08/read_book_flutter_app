import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:riverpod_tamplates/src/features/core_features/profile/application/language_notifier.dart';

class LanguageSelectorWidget extends ConsumerWidget {
  const LanguageSelectorWidget({super.key});

  final List<String> _languages = const [
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

    return PopupMenuButton<String>(
      onSelected: (String language) {
        ref.read(languageProvider.notifier).changeLanguage(language);
      },
      offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      itemBuilder: (BuildContext context) {
        return _languages.map((String language) {
          final isSelected = selectedLanguage == language;
          return PopupMenuItem<String>(
            value: language,
            child: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF1C1CFF),
                      width: 2,
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
                const SizedBox(width: 12),
                Text(
                  language,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: const Color(0xFF333333),
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              selectedLanguage,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}
