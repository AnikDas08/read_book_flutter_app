import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/constance/enums.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/library/library_repository/library_repository.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/library/model/library_book_model.dart';

final libraryBooksProvider = FutureProvider.autoDispose
    .family<List<LibraryBookModel>, LibrayType>((ref, type) async {
      final repository = ref.watch(libraryRepositoryProvider);
      final response = await repository.getLibrary(status: type.apiStatus);
      if (response.isSuccess) {
        return response.data ?? [];
      } else {
        throw response.message ?? 'Failed to fetch library books';
      }
    });
