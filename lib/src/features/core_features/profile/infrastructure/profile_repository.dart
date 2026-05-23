import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/src/constants/api_endpoints.dart';

final profileRepositoryProvider = Provider.autoDispose<ProfileRepository>(
  (ref) => ProfileRepository._(),
);

class ProfileRepository {
  ProfileRepository._();
  Future<ResponseState<dynamic>> updateProfile({
    String? name,
    String? phone,
    String? email,
    String? photoPath,
  }) async {
    final data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (phone != null) data['phone'] = phone;
    if (email != null) data['email'] = email;
    if (photoPath != null) data['photoPath'] = photoPath;

    return DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndpoints.updateProfile,
        method: .PUT,
        jsonBody: data,
      ),
      responseBuilder: (data) => data,
    );
  }

  Future<ResponseState<dynamic>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    return DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndpoints.changePassword,
        method: .PUT,
        jsonBody: {'oldPassword': oldPassword, 'newPassword': newPassword},
      ),
      responseBuilder: (data) => data,
    );
  }

  Future<ResponseState<dynamic>> getProfile() async {
    return DioService.instance.request(
      input: RequestInput(endpoint: ApiEndpoints.getProfile, method: .GET),
      responseBuilder: (data) => data,
    );
  }
}
