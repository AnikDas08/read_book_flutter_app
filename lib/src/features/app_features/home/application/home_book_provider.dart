import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/home/data/model/home_book_model.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/home/data/repository/home_repository.dart';

final trendingBooksProvider = FutureProvider.autoDispose<List<HomeBookModel>>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  final response = await repository.getBooks(type: 'trending');
  if (response.isSuccess) {
    return response.data ?? [];
  } else {
    throw response.message ?? 'Failed to fetch trending books';
  }
});

final recommendedBooksProvider = FutureProvider.autoDispose<List<HomeBookModel>>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  final response = await repository.getBooks(type: 'recommended');
  if (response.isSuccess) {
    return response.data ?? [];
  } else {
    throw response.message ?? 'Failed to fetch recommended books';
  }
});

final newReleasesProvider = FutureProvider.autoDispose<List<HomeBookModel>>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  final response = await repository.getBooks(type: 'new_release');
  if (response.isSuccess) {
    return response.data ?? [];
  } else {
    throw response.message ?? 'Failed to fetch new releases';
  }
});
