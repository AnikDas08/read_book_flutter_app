import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unkutdrama_kpnovel/config/constance/enums.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/library/application/library_book_provider.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/library/riverpod/libarary_state.dart';

part 'library_notifire.g.dart';

@Riverpod()
class LibraryNotifier extends _$LibraryNotifier {
  @override
  LibraryState build(LibrayType librayType) {
    ref.listen(libraryBooksProvider(librayType), (previous, next) {
      next.when(
        data: (books) {
          state = state.copyWith(
            libraryBooks: books,
            isLoading: false,
            hasError: false,
          );
        },
        loading: () {
          state = state.copyWith(isLoading: true);
        },
        error: (error, stack) {
          state = state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage: error.toString(),
          );
        },
      );
    });

    // Initialize state based on current provider state
    final asyncValue = ref.watch(libraryBooksProvider(librayType));
    return LibraryState(
      libraryBooks: asyncValue.asData?.value ?? [],
      isLoading: asyncValue.isLoading,
      hasError: asyncValue.hasError,
      errorMessage: asyncValue.error?.toString() ?? '',
    );
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
