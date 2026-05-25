import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/data/model/book_review_model.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/data/repository/book_repository.dart';

final bookReviewProvider = FutureProvider.autoDispose.family<BookReviewResponse, String>((ref, bookId) async {
  final repository = ref.watch(bookRepositoryProvider);
  final response = await repository.getBookReviews(bookId);
  if (response.isSuccess) {
    return response.data!;
  } else {
    throw response.message ?? 'Failed to fetch reviews';
  }
});
