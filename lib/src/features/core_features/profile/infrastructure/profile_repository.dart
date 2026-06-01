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
    String? photoPath,
  }) async {
    final data = <String, dynamic>{};
    if (name != null) data['fullName'] = name;
    if (phone != null) data['phone'] = phone;
    if (photoPath != null) data['profile'] = photoPath;

    return DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndpoints.updateProfile,
        method: .PATCH,
        formFields: data,
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
        method: .POST,
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
