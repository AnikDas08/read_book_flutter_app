import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/src/constants/api_endpoints.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/data/model/book_comment_model.dart';

final commentRepositoryProvider = Provider.autoDispose<CommentRepository>(
  (ref) => CommentRepository(),
);

class CommentRepository {
  Future<ResponseState<List<BookComment>?>> getComments({required String bookId}) async {
    final response = await DioService.instance.request<List<BookComment>>(
      input: RequestInput(
        endpoint: "${ApiEndpoints.baseUrl}/comments/book/chapter/$bookId?type=book",
        method: RequestMethod.GET,
      ),
      responseBuilder: (data) {
        return (data as List).map((x) => BookComment.fromJson(x)).toList();
      },
    );
    return response;
  }

  Future<ResponseState<dynamic>> likeComment({required String commentId}) async {
    final response = await DioService.instance.request<dynamic>(
      input: RequestInput(
        endpoint: ApiEndpoints.likeComment,
        method: RequestMethod.POST,
        jsonBody: {"commentId": commentId},
      ),
      responseBuilder: (data) => data,
    );
    return response;
  }

  Future<ResponseState<dynamic>> createCommentOrReply({
    required String bookId,
    required String message,
    String? parentId,
  }) async {
    final response = await DioService.instance.request<dynamic>(
      input: RequestInput(
        endpoint: ApiEndpoints.createCommentOrReply,
        method: RequestMethod.POST,
        jsonBody: {
          "bookId": bookId,
          "message": message,
          if (parentId != null) "parentId": parentId,
        },
      ),
      responseBuilder: (data) => data,
    );
    return response;
  }
}
