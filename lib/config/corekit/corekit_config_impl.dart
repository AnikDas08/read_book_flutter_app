import 'package:core_kit/app_bar/common_app_bar.dart';
import 'package:core_kit/initializer.dart';
import 'package:core_kit/network/dio_service.dart';
import 'package:core_kit/network/dio_service_config.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:unkutdrama_kpnovel/config/constance/constants.dart';
import 'package:unkutdrama_kpnovel/config/corekit/back_button.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';
import 'package:unkutdrama_kpnovel/config/theme/extension/app_colors.dart';
import 'package:unkutdrama_kpnovel/src/constants/api_endpoints.dart';

import 'package:unkutdrama_kpnovel/config/storage/storage_service.dart';

class CorekitConfigImpl extends CoreKitConfig with CoreKitConfigDefaults {
  @override
  Widget get preInitChild {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.light().ctaGradientBackgroundAccent,
      ),
    );
  }

  @override
  Size get designSize => const Size(393, 852);

  @override
  DioServiceConfig get dioConfig =>
      DioServiceConfig(
         enableDebugLogs: true,
          baseUrl: ApiEndpoints.baseUrl,
          refreshTokenEndpoint: '');

  @override
  String get imageBaseUrl => ApiEndpoints.imageBaseUrl;


  @override
  TokenProvider get tokenProvider => TokenProvider(
    accessToken: () async => await StorageService.instance.get('auth_token') ?? '',
    refreshToken: () async => '',
    updateTokens: (data) async {},
  );

  @override
  AppbarConfig? get appbarConfig => AppbarConfig(
    titleAlignment: .centerStart,
    backButton: const BackButtonWidget(),
    leadingPadding: const EdgeInsets.only(left: 16, right: 0),

    decoration: () => BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(Constants.appbarRadious.r),
        bottomRight: Radius.circular(Constants.appbarRadious.r),
      ),
      gradient: context.color.ctaGradientBackgroundAccent,
    ),
    titleSpacing: 10,
  );
}
