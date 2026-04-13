import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/constance/headline_widget.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/features/app_features/book/presentation/widgets/book_details_appbar_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/book/presentation/widgets/power_stones_button_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/book/presentation/widgets/ratting_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/book/presentation/widgets/success_vote_dailog_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/book/presentation/widgets/user_review_card_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';

@RoutePage()
class BookDetailsScreen extends ConsumerWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CommonAppBar(
        disableBack: true,
        hideBack: true,
        titleWidget: const BookDetailsAppbarWidget(),
        appbarConfig: AppbarConfig(height: 150.h),
      ),
      body: SmartListLoader(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 30,
        topWidget: _topWidget(context, ref),
        itemBuilder: (context, index) {
          return const UserReviewCardWidget();
        },
      ),
    );
  }

  Widget _topWidget(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        10.height,
        Row(
          children: [
            topMenu(
              icon: Icons.menu_book_outlined,
              title: '87',
              subtile: AppString.chapters,
              context: context,
            ),
            topMenu(
              icon: Icons.access_time,
              title: AppString.completed,
              subtile: AppString.status,
              context: context,
            ),
            topMenu(
              icon: Icons.electric_bolt_outlined,
              title: '70',
              subtile: AppString.power_stones,
              context: context,
            ),
          ],
        ),
        10.height,

        const PowerStonesButtonWidget(),
        15.height,
        CommonButton(
          titleText: AppString.start_reading,
          gradient: context.color.ctaGradientBackgroundAccent,
          prefix: const Icon(Icons.play_arrow_outlined, color: Colors.white, size: 30),
          onTap: () {
            ref.read(readProvider.notifier).selectBook();
            context.router.popUntil((route) => route.settings.name == NavigationRoute.name);
            context.router.navigate(const ReadRoute());
          },
        ),
        20.height,
        CommonButton(
          titleText: AppString.vote,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const Dialog(child: SuccessVoteDialogWidget()),
            );
          },
          gradient: const LinearGradient(
            transform: GradientRotation(3.141592653589793),
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0, 1],
            colors: [Color(0xFF6f1f9d), Color(0xFF8E44FF)],
          ),
          prefix: const Icon(Icons.electric_bolt_outlined, color: Colors.white, size: 20),
        ),
        10.height,
        HeadlineWidget(title: AppString.description).start,
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: context.color.bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.color.subtleOverlaysShadows),
          ),
          child: const CommonText(
            text:
                'She was his assistant. He was her boss. But the lines between business and pleasure blur in this steamy romance. She was his assistant. He was her boss. But the lines between business and pleasure blur in this steamy romance. She was his assistant. He was her boss. But the lines between business and pleasure blur in this steamy romance. She was his assistant. He was her boss. But the lines between business and pleasure blur in this steamy romance.',
            textAlign: .left,
            isDescription: true,
            fontSize: 12,
          ),
        ),

        20.height,
        const RatingWidget(),
        10.height,
      ],
    );
  }

  Widget topMenu({
    required IconData icon,
    required String title,
    required String subtile,
    required BuildContext context,
  }) {
    return Expanded(
      child: Card(
        color: context.color.bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            10.height,
            Icon(icon, color: context.color.purple400, size: 34),
            CommonText(text: title, textColor: context.color.headingBoldText, fontSize: 18),
            CommonText(text: subtile, textColor: context.color.subtext, fontSize: 14),
            10.height,
          ],
        ),
      ),
    );
  }
}
