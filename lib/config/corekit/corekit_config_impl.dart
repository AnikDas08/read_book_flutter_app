import 'package:core_kit/app_bar/common_app_bar.dart';
import 'package:core_kit/initializer.dart';
import 'package:core_kit/network/dio_service.dart';
import 'package:core_kit/network/dio_service_config.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/corekit/back_button.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/config/theme/extension/app_colors.dart';

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
      DioServiceConfig(baseUrl: '', refreshTokenEndpoint: '');

  @override
  String get imageBaseUrl => '';

  @override
  TokenProvider get tokenProvider => TokenProvider(
    accessToken: () async => '',
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
