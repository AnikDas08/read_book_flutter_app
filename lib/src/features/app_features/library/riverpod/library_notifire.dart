import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unkutdrama_kpnovel/config/constance/enums.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/library/riverpod/libarary_state.dart';

part 'library_notifire.g.dart';

@Riverpod()
class LibraryNotifier extends _$LibraryNotifier {
  @override
  LibraryState build(LibrayType librayType) {
    return LibraryState();
  }
}

@riverpod
class SelectedLibrary extends _$SelectedLibrary {
  @override
  LibrayType build() {
    return LibrayType.Reading;
  }

  void setLibrary(LibrayType value) {
    state = value;
  }
}
