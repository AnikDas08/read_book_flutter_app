import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/corekit/corekit_config_impl.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/route/app_router_observer.dart';
import 'package:riverpod_tamplates/config/route/provider_observer.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(); // or ClampingScrollPhysics, etc.
  }

  @override
  ScrollViewKeyboardDismissBehavior getKeyboardDismissBehavior(BuildContext context) {
    return ScrollViewKeyboardDismissBehavior.onDrag;
  }
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(observers: [AppProviderObserver()], child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    appRouter.init(ref);
    return CoreKit.router(
      scrollBehavior: CustomScrollBehavior(),
      title: '',
      navigatorKey: appRouter.navigatorKey,
      config: CorekitConfigImpl(),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(
        navigatorObservers: () => [AppRouterObserver()],
      ),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: .light,
    );
  }
}
