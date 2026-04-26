import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_tamplates/src/features/app_features/explore/riverpod/explore_state.dart';

part 'explore_notifire.g.dart';

@Riverpod()
class ExploreNotifire extends _$ExploreNotifire {
  @override
  ExploreState build() {
    return ExploreState();
  }

  void onSearchChanged(String value) {
    state = state.copyWith(searchText: value);
  }

  void selectTag(String value) {
    state = state.copyWith(selectedTag: value);
  }

  void selectGenre(String value) {
    state = state.copyWith(selectedGenre: value);
  }
}
