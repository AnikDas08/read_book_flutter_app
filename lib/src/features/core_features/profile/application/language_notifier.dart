import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_notifier.g.dart';

@riverpod
class LanguageNotifier extends _$LanguageNotifier {
  @override
  String build() {
    return 'English';
  }

  void changeLanguage(String language) {
    state = language;
  }
}
