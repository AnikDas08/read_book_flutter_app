import 'package:unkutdrama_kpnovel/src/features/app_features/library/model/library_book_model.dart';

class LibraryState {
  final List<LibraryBookModel> libraryBooks;
  final bool isLoading;
  final bool hasError;
  final String errorMessage;

  const LibraryState({
    this.libraryBooks = const [],
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage = '',
  });

  LibraryState copyWith({
    List<LibraryBookModel>? libraryBooks,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return LibraryState(
      libraryBooks: libraryBooks ?? this.libraryBooks,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
