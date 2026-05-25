import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/src/constants/api_endpoints.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/library/model/library_book_model.dart';

final libraryRepositoryProvider = Provider.autoDispose<LibararyRepository>(
  (ref) => LibararyRepository(),
);

class LibararyRepository {
  Future<ResponseState<List<LibraryBookModel>?>> getLibrary({required String status}) async {
    final response = await DioService.instance.request<List<LibraryBookModel>>(
      input: RequestInput(
        endpoint: ApiEndpoints.getLibrary,
        method: RequestMethod.GET,
        queryParams: {
          'status':status
        }
      ),
      responseBuilder: (data) {
        return List<LibraryBookModel>.from(
          data.map((x) => LibraryBookModel.fromJson(x)),
        );
      },
    );
    return response;
  }
}
