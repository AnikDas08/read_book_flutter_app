import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/storage/storage_service.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/home/data/model/home_book_model.dart';

import 'package:unkutdrama_kpnovel/src/constants/api_endpoints.dart';

final homeRepositoryProvider = Provider.autoDispose<HomeRepository>(
  (ref) => HomeRepository(),
);

class HomeRepository {
  Future<ResponseState<List<HomeBookModel>?>> getBooks({required String type}) async {
    final response = await DioService.instance.request<List<HomeBookModel>>(
      input: RequestInput(
        endpoint: "${ApiEndpoints.getBooks}?book=$type",
        method: RequestMethod.GET,
        headers: {'Authorization': 'Bearer ${await StorageService.instance.get('auth_token') ?? ''}'},
      ),
      responseBuilder: (data) {
        if (data is Map && data['data'] is List) {
          return (data['data'] as List)
              .map((e) => HomeBookModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      },
    );
    return response;
  }
}
