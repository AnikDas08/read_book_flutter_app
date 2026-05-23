import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/constance/constants.dart';
import 'package:unkutdrama_kpnovel/config/constance/headline_widget.dart';
import 'package:unkutdrama_kpnovel/config/corekit/back_button.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/rankings/presentation/widgets/general_rank_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/rankings/presentation/widgets/ranking_filter_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/rankings/presentation/widgets/top_voted_books.dart';

@RoutePage()
class RankingScreen extends ConsumerWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CommonAppBar(
        hideBack: true,
        disableBack: false,
        titleWidget: _appbarBuilder(context, ref),
        appbarConfig: AppbarConfig(height: 130,titleAlignment: .center),
        leading: const BackButtonWidget(isDark: false,),
      ),
      body: SmartListLoader(
        itemCount: 30,
        padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
        topWidget: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xfffaf5ff),
                borderRadius: BorderRadius.all(Radius.circular(24.r)),
              ),
              child: const TopVotedBooks(),
            ),
            10.height,
            HeadlineWidget(title: AppString.Book_List).start,
          ],
        ),
        itemBuilder: (context, index) {
          return GeneralRankWidget(
            rank: index + 1,
            title: 'Book Title',
            author: 'Author Name',
            rating: 4.5,
            views: '1.2M',
            tags: const ['Fantasy', 'Romance'],
            imageUrl: Constants.sampleImage,
          );
        },
      ),
    );
  }

  Widget _appbarBuilder(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
      child: Column(
        children: [
          12.height,
          Row(
            children: [
              const BackButtonWidget(isDark: true,iconColor: Colors.white,),
              70.width,
              CommonText(
                text: AppString.Rankings,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ],
          ),
          10.height,
          const RankingFilterWidget(),
        ],
      ),
    );
  }
}
