import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/gen/assets.gen.dart';

@RoutePage()
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final images = [Assets.images.onboarding1, Assets.images.onboarding2, Assets.images.onboarding3];
  List<String> get titles => [
    AppString.immersive_reading_experience,
    AppString.unlock_premium_content,
    AppString.join_the_community,
    AppString.personalized_for_you,
  ];

  final descriptions = [
    AppString
        .customize_your_reading_with_multiple_themes_fonts_and_settings_Read_your_way_anywhere_anytime,
    AppString
        .access_thousands_of_exclusive_novels_earn_power_stones_unlock_chapters_and_support_your_favorite_authors,
    AppString
        .connect_with_fellow_readers_share_reviews_bookmark_favorites_and_engage_with_authors_directly,
    AppString
        .get_recommendations_based_on_your_taste_trending_books_new_releases_and_curated_collections_just_for_you,
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: images.length,
              controller: _pageController,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Column(
                        children: [
                          CommonImage(
                            height: CoreScreenUtils.deviceSize.height * 0.50,
                            width: .infinity,
                            fill: BoxFit.cover,
                            src: images[index].path,
                            borderRadiusCustom: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          25.height,
                          CommonText(
                            text: titles[index],
                            fontSize: 32,
                            left: Constants.padding,
                            right: Constants.padding,
                            fontWeight: .w600,
                            textColor: context.color.bodyText,
                          ),
                          16.height,
                          CommonText(
                            left: Constants.padding,
                            right: Constants.padding,
                            isDescription: true,
                            fontWeight: .w400,
                            fontSize: 18,
                            text: descriptions[index],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: CommonAppBar(
                        disableBack: true,
                        hideBack: true,
                        appbarConfig: AppbarConfig(
                          decoration: () => const BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          _buildPageIndicator(),
          25.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
            child: CommonButton(
              titleText: AppString.next,
              suffix: const Icon(Icons.arrow_forward_ios),
              gradient: context.color.ctaGradientBackgroundAccent,
              onTap: () {
                if (_currentPage == images.length - 1) {
                  appRouter.replace(const LoginRoute());
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
            ),
          ),
          100.height
        ],
      ),
    );
  }

  //page indicator
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(images.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index ? context.color.blue300 : context.color.blue100,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
