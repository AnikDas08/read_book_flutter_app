import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/src/constants/api_endpoints.dart';

final readRepositoryProvider = Provider.autoDispose<ReadRepository>(
  (ref) => ReadRepository(),
);

class ReadRepository {
  Future<ResponseState<List<dynamic>?>> getChapters(String bookId) async {
    final response = await DioService.instance.request<List<dynamic>>(
      input: RequestInput(
        endpoint: ApiEndpoints.chapters,
        method: RequestMethod.GET,
        pathParams: [bookId],
      ),
      responseBuilder: (data) {
        return data as List<dynamic>?;
      },
    );
    return response;
  }
}
