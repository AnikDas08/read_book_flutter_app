import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/gen/assets.gen.dart';
import 'package:riverpod_tamplates/src/common/notification_button_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/explore/presentation/widgets/explore_screen_appbar.dart';
import 'package:riverpod_tamplates/src/features/app_features/home/presentation/widget/home_screen_appbar.dart';
import 'package:riverpod_tamplates/src/features/app_features/library/presentation/widgets/library_profile_header.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/chapters_drawer.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/read_screen_appbar.dart';

@RoutePage()
class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      endDrawerEnableOpenDragGesture: false,
      endDrawer: const ChaptersDrawer(),
      routes: const [
        ReadRoute(),
        HomeRoute(),
        ExploreRoute(),
        ContestRoute(),
        LibraryRoute(),
      ],
      lazyLoad: false,
      appBarBuilder: (context, tabsRouter) {
        if (tabsRouter.activeIndex == 0) {
          return CommonAppBar(
            disableBack: true,
            hideBack: true,
            appbarConfig: AppbarConfig(
              titleSpacing: 16,
              height: 58,
              decoration: () => BoxDecoration(
                gradient: context.color.ctaGradientBackgroundAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Constants.appbarRadious.r),
                  bottomRight: Radius.circular(Constants.appbarRadious.r),
                ),
              ),
            ),
            titleWidget: const ReadScreenAppBar(),
          );
        } else if (tabsRouter.activeIndex == 1) {
          return CommonAppBar(
            disableBack: true,
            hideBack: true,
            appbarConfig: AppbarConfig(height: 190),
            titleWidget: const HomeScreenAppBar(),
          );
        } else if (tabsRouter.activeIndex == 2) {
          return CommonAppBar(
            disableBack: true,
            hideBack: true,
            appbarConfig: AppbarConfig(
              height: 190,
              decoration: () => BoxDecoration(
                gradient: context.color.ctaGradientBackgroundAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
            ),
            titleWidget: const ExploreScreenAppbar(),
          );
        } else if (tabsRouter.activeIndex == 3) {
          return CommonAppBar(
            disableBack: true,
            hideBack: true,
            title: AppString.contest,
            appbarConfig: AppbarConfig(
              titleSpacing: 16,
              actions: [const NotificationButtonWidget()],
            ),
          );
        } else if (tabsRouter.activeIndex == 4) {
          return CommonAppBar(
            disableBack: true,
            hideBack: true,
            titleWidget: const LibraryProfileHeader(),
            appbarConfig: AppbarConfig(height: 150),
          );
        }
        return null;
      },
      bottomNavigationBuilder: (_, tabsRouter) {
        return MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              _navBuilder(context, tabsRouter, Assets.nav.navRead, 'Read', 0),
              _navBuilder(context, tabsRouter, Assets.nav.navHome, 'Home', 1),
              _navBuilder(
                context,
                tabsRouter,
                Assets.nav.navExplore,
                'Explore',
                2,
              ),
              _navBuilder(
                context,
                tabsRouter,
                Assets.nav.navContest,
                'Contest',
                3,
              ),
              _navBuilder(
                context,
                tabsRouter,
                Assets.nav.navLibrary,
                'Library',
                4,
              ),
            ],
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _navBuilder(
    BuildContext context,
    TabsRouter tabsRouter,
    String src,
    String label,
    int index,
  ) {
    final isActive = tabsRouter.activeIndex == index;

    return BottomNavigationBarItem(
      label: '',
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getIcon(isActive, context, src),
          CommonText(
            text: label,
            textColor: isActive ? null : context.color.navbarIconsUnselected,
            fontSize: isActive ? 14 : 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            gradient: isActive
                ? context.color.ctaGradientBackgroundAccent
                : null,
          ),
        ],
      ),
    );
  }

  StatelessWidget _getIcon(bool isActive, BuildContext context, String image) {
    final icon = CommonImage(
      src: image,
      size: 24 * (isActive ? 1.1 : 1),
      imageColor: isActive
          ? context.color.buttonTextWhite
          : context.color.navbarIconsUnselected,
    );
    return isActive
        ? Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: context.color.ctaGradientBackgroundAccent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: context.color.purple400,
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: icon,
          )
        : icon;
  }
}
