import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/src/constants/api_endpoints.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/data/model/book_review_model.dart';

final bookRepositoryProvider = Provider.autoDispose<BookRepository>(
  (ref) => BookRepository(),
);

class BookRepository {
  Future<ResponseState<BookReviewResponse?>> getBookReviews(String bookId) async {
    final response = await DioService.instance.request<BookReviewResponse>(
      input: RequestInput(
        endpoint: "${ApiEndpoints.getReviews}/$bookId",
        method: RequestMethod.GET,
      ),
      responseBuilder: (data) {
        return BookReviewResponse.fromJson(data);
      },
    );
    return response;
  }

  Future<ResponseState<dynamic>> createReview({
    required String bookId,
    required double rating,
    required String review,
  }) async {
    final response = await DioService.instance.request<dynamic>(
      input: RequestInput(
        endpoint: ApiEndpoints.createReview,
        method: RequestMethod.POST,
        jsonBody: {
          "bookId": bookId,
          "rating": rating,
          "review": review,
        },
      ),
      responseBuilder: (data) => data,
      showMessage: true,
    );
    return response;
  }
}
