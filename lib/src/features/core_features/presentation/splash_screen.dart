import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/constance/constants.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';
import 'package:unkutdrama_kpnovel/gen/assets.gen.dart';
import 'package:unkutdrama_kpnovel/src/common/language_selector_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/authentication/data/auth_repository.dart';

@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late AuthRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = ref.read(authRepositoryProvider);
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {




    final isAuthenticated = await _repository.isAuthenticated();

    if (isAuthenticated) {
      print("😊 Authenticated");
      appRouter.replaceAll([
      const  NavigationRoute()],
      );
    }
     else {
      appRouter.replace(const OnboardingRoute());
    } await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: context.color.ctaGradientBackgroundAccent,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.padding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top + 20),
                  const Spacer(),
                  CommonImage(
                    src: Assets.images.spalshIcon.path,
                    width: 207,
                    height: 232,
                    enableAspectRatio: true,
                  ).center,
                  32.height,
                  CommonText(
                    left: 10,
                    right: 10,
                    text: AppString
                        .discover_thousands_of_stories_Read_anywhere_anytime,
                    style: context.textStyle.subTitle,
                    textColor: context.color.bgColor.withValues(alpha: 0.8),
                    isDescription: true,
                  ),
                  const Spacer(),
                  CommonButton(
                    titleText: AppString.get_started,
                    buttonColor: context.color.bgColor,
                    titleGradient: context.color.ctaGradientLogo,
                    onTap: () {
                      appRouter.push(const OnboardingRoute());
                    },
                  ),
                  16.height,
                  CommonButton(
                    titleText: AppString.i_already_have_an_account,
                    buttonColor: context.color.buttonTextWhite.withValues(
                      alpha: 0.1,
                    ),
                    borderColor: context.color.buttonTextWhite.withValues(
                      alpha: 0.4,
                    ),
                    borderWidth: 2,
                    onTap: () {
                      appRouter.push(const LoginRoute());
                    },
                  ),
                  24.height,
                  CommonText(
                    text: AppString.join_1M_readers_worldwide,
                    style: context.textStyle.subTitle,
                    fontSize: 14,
                    textColor: context.color.bgColor.withValues(alpha: 0.8),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              right: 20,
              child: const LanguageSelectorWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
