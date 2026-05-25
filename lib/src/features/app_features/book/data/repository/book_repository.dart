import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/src/constants/api_endpoints.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/data/model/book_details_model.dart';

final bookRepositoryProvider = Provider.autoDispose<BookRepository>(
  (ref) => BookRepository(),
);

class BookRepository {
  Future<ResponseState<BookDetailsModel?>> getBookDetails(String bookId) async {
    final response = await DioService.instance.request<BookDetailsModel>(
      input: RequestInput(
        endpoint: ApiEndpoints.bookDetails,
        method: RequestMethod.GET,
        pathParams: [bookId],
      ),
      responseBuilder: (data) {
        return BookDetailsModel.fromJson(data as Map<String, dynamic>);
      },
    );
    return response;
  }

  Future<ResponseState<dynamic>> voteBook(String bookId) async {
    final response = await DioService.instance.request<dynamic>(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndpoints.voteBook,
        method: RequestMethod.POST,

        jsonBody: {'bookId': bookId},
      ),
      responseBuilder: (data) {
        return data;
      },
    );
    return response;
  }
}
