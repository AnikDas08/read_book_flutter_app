// ignore_for_file: constant_identifier_names

import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';

enum ContestType {
  Writers('Writers'),
  Books('Books');

  final String title;

  String get displayName => title == 'Writers' ? AppString.writers : AppString.books;

  const ContestType(this.title);
}

enum LibrayType {
  Reading('Reading'),
  Completed('Completed'),
  WantToRead('Want to Read'),
  Paused('Paused');

  final String title;

  String get displayName => title == 'Want to Read'
      ? AppString.wantToRead
      : title == 'Reading'
      ? AppString.reading
      : AppString.completed;

  const LibrayType(this.title);
}
