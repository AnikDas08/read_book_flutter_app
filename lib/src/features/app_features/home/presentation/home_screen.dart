import 'package:auto_route/auto_route.dart';
import 'package:core_kit/text/common_text.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/constance/constants.dart';
import 'package:unkutdrama_kpnovel/config/constance/headline_widget.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/presentation/widgets/power_stones_button_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/home/presentation/widget/books_feed_card_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/home/application/home_book_provider.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/home/data/model/home_book_model.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/library/presentation/widgets/book_widget.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemSizeInrow = (CoreScreenUtils.deviceSize.width - 32) / 2.0;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.height,
          Row(
            children: [
              Expanded(
                child: topMenu(
                  context: context,
                  icon: Icons.emoji_events_outlined,
                  title: AppString.Rankings,
                  subTitle: AppString.Daily_Weekly_Monthly,
                  onTap: () {
                    context.router.push(const RankingRoute());
                  },
                  color: Colors.amber,
                  background: const Color(0xFFfffcee),
                ),
              ),
              16.width,
              Expanded(
                child: topMenu(
                  context: context,
                  icon: Icons.menu_book_outlined,
                  title: AppString.Short_Stories,
                  subTitle: AppString.Quick_reads,
                  onTap: () {
                    context.router.push(const StoryRoute());
                  },
                  color: Colors.green,
                  background: const Color(0xFFe9fffc),
                ),
              ),
            ],
          ),

          10.height,

          const PowerStonesButtonWidget(),

          10.height,

          _headline('🔥 ${AppString.trending_now}', () {
            context.router.push(
              ShowMoreBooksRoute(
                title: AppString.trending_now,
                isNew: false,
                isTrending: true,
                isListType: false,
              ),
            );
          }, context),
          _trendingBooks(ref),

          _headline('💜 ${AppString.recommended_for_you}', () {
            context.router.push(
              ShowMoreBooksRoute(
                title: AppString.recommended_for_you,
                isNew: true,
                isTrending: false,
                isListType: false,
              ),
            );
          }, context),
          _recommendedBooks(ref),
          _headline('✨ ${AppString.new_releases}', () {
            context.router.push(
              ShowMoreBooksRoute(
                title: AppString.new_releases,
                isNew: true,
                isTrending: false,
                isListType: true,
              ),
            );
          }, context),
          10.height,
          _newReleases(ref),
          10.height,
        ],
      ),
    );
  }

  Widget _newReleases(WidgetRef ref) {
    final newReleasesAsync = ref.watch(newReleasesProvider);

    return newReleasesAsync.when(
      data: (books) => Column(
        children: books.map((book) => BookFeedCardWidget(book: book)).toList(),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text(err.toString())),
    );
  }

  Widget _recommendedBooks(WidgetRef ref) {
    final recommendedAsync = ref.watch(recommendedBooksProvider);

    return recommendedAsync.when(
      data: (books) => SizedBox(
        height: 200,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: books
                .map(
                  (book) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: BookWidget(book: book, isNew: true),
              ),
            )
                .toList(),
          ),
        ),
      ),
      loading: () => const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) =>
          SizedBox(height: 200, child: Center(child: Text(err.toString()))),
    );
  }

  Widget _trendingBooks(WidgetRef ref) {
    final trendingAsync = ref.watch(trendingBooksProvider);

    return trendingAsync.when(
      data: (books) => SizedBox(
        height: 200,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: books
                .map(
                  (book) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: BookWidget(book: book, isTrending: true),
              ),
            )
                .toList(),
          ),
        ),
      ),
      loading: () => const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) =>
          SizedBox(height: 200, child: Center(child: Text(err.toString()))),
    );
  }

  Widget _headline(String title, VoidCallback onTap, BuildContext context) {
    return Row(
      children: [
        HeadlineWidget(title: title),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: CommonText(
            text: AppString.show_more,
            suffix: Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: context.color.ctaButtonsText,
            ),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            textColor: context.color.ctaButtonsText,
          ),
        ),
      ],
    );
  }

  Widget topMenu({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subTitle,
    required VoidCallback onTap,
    required Color color,
    required Color background,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            16.width,
            CommonText(
              text: title,
              textColor: context.color.bodyText,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            CommonText(
              text: subTitle,
              textColor: context.color.subtext,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}