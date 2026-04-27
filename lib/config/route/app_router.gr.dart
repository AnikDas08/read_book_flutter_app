// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AboutUsScreen]
class AboutUsRoute extends PageRouteInfo<void> {
  const AboutUsRoute({List<PageRouteInfo>? children})
    : super(AboutUsRoute.name, initialChildren: children);

  static const String name = 'AboutUsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AboutUsScreen();
    },
  );
}

/// generated route for
/// [BookDetailsScreen]
class BookDetailsRoute extends PageRouteInfo<void> {
  const BookDetailsRoute({List<PageRouteInfo>? children})
    : super(BookDetailsRoute.name, initialChildren: children);

  static const String name = 'BookDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BookDetailsScreen();
    },
  );
}

/// generated route for
/// [ChangePasswordScreen]
class ChangePasswordRoute extends PageRouteInfo<void> {
  const ChangePasswordRoute({List<PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [ContestScreen]
class ContestRoute extends PageRouteInfo<void> {
  const ContestRoute({List<PageRouteInfo>? children})
    : super(ContestRoute.name, initialChildren: children);

  static const String name = 'ContestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ContestScreen();
    },
  );
}

/// generated route for
/// [EditProfileScreen]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EditProfileScreen();
    },
  );
}

/// generated route for
/// [ExploreResultScreen]
class ExploreResultRoute extends PageRouteInfo<ExploreResultRouteArgs> {
  ExploreResultRoute({
    Key? key,
    required String genre,
    List<PageRouteInfo>? children,
  }) : super(
         ExploreResultRoute.name,
         args: ExploreResultRouteArgs(key: key, genre: genre),
         initialChildren: children,
       );

  static const String name = 'ExploreResultRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExploreResultRouteArgs>();
      return ExploreResultScreen(key: args.key, genre: args.genre);
    },
  );
}

class ExploreResultRouteArgs {
  const ExploreResultRouteArgs({this.key, required this.genre});

  final Key? key;

  final String genre;

  @override
  String toString() {
    return 'ExploreResultRouteArgs{key: $key, genre: $genre}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ExploreResultRouteArgs) return false;
    return key == other.key && genre == other.genre;
  }

  @override
  int get hashCode => key.hashCode ^ genre.hashCode;
}

/// generated route for
/// [ExploreScreen]
class ExploreRoute extends PageRouteInfo<void> {
  const ExploreRoute({List<PageRouteInfo>? children})
    : super(ExploreRoute.name, initialChildren: children);

  static const String name = 'ExploreRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ExploreScreen();
    },
  );
}

/// generated route for
/// [FaqScreen]
class FaqRoute extends PageRouteInfo<void> {
  const FaqRoute({List<PageRouteInfo>? children})
    : super(FaqRoute.name, initialChildren: children);

  static const String name = 'FaqRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FaqScreen();
    },
  );
}

/// generated route for
/// [ForgotPasswordScreen]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute({List<PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [LanguageScreen]
class LanguageRoute extends PageRouteInfo<void> {
  const LanguageRoute({List<PageRouteInfo>? children})
    : super(LanguageRoute.name, initialChildren: children);

  static const String name = 'LanguageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LanguageScreen();
    },
  );
}

/// generated route for
/// [LibraryScreen]
class LibraryRoute extends PageRouteInfo<void> {
  const LibraryRoute({List<PageRouteInfo>? children})
    : super(LibraryRoute.name, initialChildren: children);

  static const String name = 'LibraryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LibraryScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [NavigationScreen]
class NavigationRoute extends PageRouteInfo<void> {
  const NavigationRoute({List<PageRouteInfo>? children})
    : super(NavigationRoute.name, initialChildren: children);

  static const String name = 'NavigationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NavigationScreen();
    },
  );
}

/// generated route for
/// [NotificationScreen]
class NotificationRoute extends PageRouteInfo<void> {
  const NotificationRoute({List<PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotificationScreen();
    },
  );
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingScreen();
    },
  );
}

/// generated route for
/// [OtpScreen]
class OtpRoute extends PageRouteInfo<void> {
  const OtpRoute({List<PageRouteInfo>? children})
    : super(OtpRoute.name, initialChildren: children);

  static const String name = 'OtpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OtpScreen();
    },
  );
}

/// generated route for
/// [PowerStonesScreen]
class PowerStonesRoute extends PageRouteInfo<void> {
  const PowerStonesRoute({List<PageRouteInfo>? children})
    : super(PowerStonesRoute.name, initialChildren: children);

  static const String name = 'PowerStonesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PowerStonesScreen();
    },
  );
}

/// generated route for
/// [PrivacyScreen]
class PrivacyRoute extends PageRouteInfo<void> {
  const PrivacyRoute({List<PageRouteInfo>? children})
    : super(PrivacyRoute.name, initialChildren: children);

  static const String name = 'PrivacyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PrivacyScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [RankingScreen]
class RankingRoute extends PageRouteInfo<void> {
  const RankingRoute({List<PageRouteInfo>? children})
    : super(RankingRoute.name, initialChildren: children);

  static const String name = 'RankingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RankingScreen();
    },
  );
}

/// generated route for
/// [ReadScreen]
class ReadRoute extends PageRouteInfo<void> {
  const ReadRoute({List<PageRouteInfo>? children})
    : super(ReadRoute.name, initialChildren: children);

  static const String name = 'ReadRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReadScreen();
    },
  );
}

/// generated route for
/// [ReviewScreen]
class ReviewRoute extends PageRouteInfo<void> {
  const ReviewRoute({List<PageRouteInfo>? children})
    : super(ReviewRoute.name, initialChildren: children);

  static const String name = 'ReviewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReviewScreen();
    },
  );
}

/// generated route for
/// [ShowMoreBooksScreen]
class ShowMoreBooksRoute extends PageRouteInfo<ShowMoreBooksRouteArgs> {
  ShowMoreBooksRoute({
    Key? key,
    required String title,
    bool isNew = false,
    bool isTrending = false,
    required bool isListType,
    List<PageRouteInfo>? children,
  }) : super(
         ShowMoreBooksRoute.name,
         args: ShowMoreBooksRouteArgs(
           key: key,
           title: title,
           isNew: isNew,
           isTrending: isTrending,
           isListType: isListType,
         ),
         initialChildren: children,
       );

  static const String name = 'ShowMoreBooksRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShowMoreBooksRouteArgs>();
      return ShowMoreBooksScreen(
        key: args.key,
        title: args.title,
        isNew: args.isNew,
        isTrending: args.isTrending,
        isListType: args.isListType,
      );
    },
  );
}

class ShowMoreBooksRouteArgs {
  const ShowMoreBooksRouteArgs({
    this.key,
    required this.title,
    this.isNew = false,
    this.isTrending = false,
    required this.isListType,
  });

  final Key? key;

  final String title;

  final bool isNew;

  final bool isTrending;

  final bool isListType;

  @override
  String toString() {
    return 'ShowMoreBooksRouteArgs{key: $key, title: $title, isNew: $isNew, isTrending: $isTrending, isListType: $isListType}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ShowMoreBooksRouteArgs) return false;
    return key == other.key &&
        title == other.title &&
        isNew == other.isNew &&
        isTrending == other.isTrending &&
        isListType == other.isListType;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      title.hashCode ^
      isNew.hashCode ^
      isTrending.hashCode ^
      isListType.hashCode;
}

/// generated route for
/// [SignupScreen]
class SignupRoute extends PageRouteInfo<void> {
  const SignupRoute({List<PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignupScreen();
    },
  );
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}

/// generated route for
/// [StoryScreen]
class StoryRoute extends PageRouteInfo<void> {
  const StoryRoute({List<PageRouteInfo>? children})
    : super(StoryRoute.name, initialChildren: children);

  static const String name = 'StoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StoryScreen();
    },
  );
}

/// generated route for
/// [TermsScreen]
class TermsRoute extends PageRouteInfo<void> {
  const TermsRoute({List<PageRouteInfo>? children})
    : super(TermsRoute.name, initialChildren: children);

  static const String name = 'TermsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TermsScreen();
    },
  );
}

/// generated route for
/// [UsedPowerStonesHistoryScreen]
class UsedPowerStonesHistoryRoute extends PageRouteInfo<void> {
  const UsedPowerStonesHistoryRoute({List<PageRouteInfo>? children})
    : super(UsedPowerStonesHistoryRoute.name, initialChildren: children);

  static const String name = 'UsedPowerStonesHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UsedPowerStonesHistoryScreen();
    },
  );
}
