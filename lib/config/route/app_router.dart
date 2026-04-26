import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/route/auth_guard.dart';
import 'package:riverpod_tamplates/src/features/app_features/book/presentation/book_details_screen.dart';
import 'package:riverpod_tamplates/src/features/app_features/contest/presentation/contest_screen.dart';
import 'package:riverpod_tamplates/src/features/app_features/explore/presentation/explore_result_screen.dart';
import 'package:riverpod_tamplates/src/features/app_features/explore/presentation/explore_screen.dart';
import 'package:riverpod_tamplates/src/features/app_features/home/presentation/home_screen.dart';
import 'package:riverpod_tamplates/src/features/app_features/home/presentation/show_more_books_screen.dart';
import 'package:riverpod_tamplates/src/features/app_features/library/presentation/library_screen.dart';
import 'package:riverpod_tamplates/src/features/app_features/power_stones/presentation/power_stones_screen.dart';
import 'package:riverpod_tamplates/src/features/app_features/rankings/presentation/ranking_screen.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/read_screen.dart';
import 'package:riverpod_tamplates/src/features/app_features/story/presentation/story_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/authentication/presentation/forgot_password_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/authentication/presentation/login_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/authentication/presentation/otp_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/authentication/presentation/signup_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/navigation/presentation/navigation_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/onboarding/presentation/onboarding_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/presentation/splash_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/profile/presentation/change_password_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/profile/presentation/edit_profile_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/profile/presentation/faq_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/profile/presentation/about_us_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/profile/presentation/language_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/profile/presentation/notification_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/profile/presentation/privacy_screen.dart';
import 'package:riverpod_tamplates/src/features/app_features/profile/presentation/screen/profile_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/profile/presentation/terms_screen.dart';
import 'package:riverpod_tamplates/src/features/core_features/profile/presentation/used_power_stones_history_screen.dart';

part 'app_router.gr.dart';

AppRouter appRouter = AppRouter();

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  late WidgetRef ref;

  void init(WidgetRef ref) {
    this.ref = ref;
  }

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SignupRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: OtpRoute.page),
    CustomRoute(
      page: NavigationRoute.page,
      guards: [AuthGuard(ref)],
      transitionsBuilder: TransitionsBuilders.noTransition,
      duration: const Duration(milliseconds: 0),
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: ReadRoute.page),
        AutoRoute(page: ContestRoute.page),
        AutoRoute(page: LibraryRoute.page),
        AutoRoute(page: ExploreRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
    AutoRoute(page: EditProfileRoute.page, guards: [AuthGuard(ref)]),
    AutoRoute(page: ChangePasswordRoute.page, guards: [AuthGuard(ref)]),
    AutoRoute(page: TermsRoute.page),
    AutoRoute(page: PrivacyRoute.page),
    AutoRoute(page: FaqRoute.page),
    AutoRoute(page: AboutUsRoute.page),
    AutoRoute(page: LanguageRoute.page),
    AutoRoute(page: UsedPowerStonesHistoryRoute.page),
    AutoRoute(page: NotificationRoute.page, guards: [AuthGuard(ref)]),
    AutoRoute(page: ProfileRoute.page, guards: [AuthGuard(ref)]),
    AutoRoute(page: ExploreResultRoute.page, guards: [AuthGuard(ref)]),
    AutoRoute(page: BookDetailsRoute.page, guards: [AuthGuard(ref)]),
    AutoRoute(page: RankingRoute.page, guards: [AuthGuard(ref)]),
    AutoRoute(page: PowerStonesRoute.page, guards: [AuthGuard(ref)]),
    AutoRoute(page: ShowMoreBooksRoute.page, guards: [AuthGuard(ref)]),
    AutoRoute(page: StoryRoute.page, guards: [AuthGuard(ref)]),
  ];
}
