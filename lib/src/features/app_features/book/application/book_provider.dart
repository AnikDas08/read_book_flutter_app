import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/data/model/book_details_model.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/data/repository/book_repository.dart';

final bookDetailsProvider = FutureProvider.autoDispose
    .family<BookDetailsModel, String>((ref, bookId) async {
      final repository = ref.watch(bookRepositoryProvider);
      final response = await repository.getBookDetails(bookId);
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw response.message ?? 'Failed to fetch book details';
      }
    });
