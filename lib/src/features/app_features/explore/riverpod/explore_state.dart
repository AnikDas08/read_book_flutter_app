import 'package:unkutdrama_kpnovel/src/features/app_features/read/data/model/book_model.dart';

class ExploreState {
  final List<BookModel> books;
  final String searchText;
  final String selectedTag;
  final String selectedGenre;

  ExploreState({
    this.books = const [],
    this.searchText = '',
    this.selectedTag = '#Enemies to Lovers',
    this.selectedGenre = 'All',
  });

  ExploreState copyWith({
    List<BookModel>? books,
    String? searchText,
    String? selectedTag,
    String? selectedGenre,
  }) {
    return ExploreState(
      books: books ?? this.books,
      searchText: searchText ?? this.searchText,
      selectedTag: selectedTag ?? this.selectedTag,
      selectedGenre: selectedGenre ?? this.selectedGenre,
    );
  }
}
