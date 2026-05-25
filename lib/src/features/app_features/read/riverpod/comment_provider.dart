import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/data/model/book_comment_model.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/data/repository/comment_repository.dart';

final bookCommentsProvider = FutureProvider.autoDispose.family<List<BookComment>, String>((ref, bookId) async {
  final repository = ref.watch(commentRepositoryProvider);
  final response = await repository.getComments(bookId: bookId);
  if (response.isSuccess) {
    return response.data ?? [];
  } else {
    throw response.message ?? 'Failed to fetch comments';
  }
});
