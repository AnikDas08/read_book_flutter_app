import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/constance/headline_widget.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/features/app_features/explore/presentation/widgets/genere_card_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/library/presentation/widgets/book_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/library/presentation/widgets/no_books_found.dart';

class ExploreResultWidget extends StatelessWidget {
  const ExploreResultWidget({super.key, this.itemCount = 0, this.selectedGenre});
  final int itemCount;
  final String? selectedGenre;

  @override
  Widget build(BuildContext context) {
    return SmartStaggeredLoader(
      topWidget: _appbar(context),
      onColapsAppbar: context.router.current.route.name != NavigationRoute.name
          ? Container(color: context.color.bgColor, child: _search(context))
          : null,
      appbar: context.router.current.route.name != NavigationRoute.name
          ? Column(children: [10.height, _search(context), 10.height])
          : null,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const BookWidget();
      },
      gridConfig: GridConfig(aspectRatio: .68, itemInRow: 2),
      emptyWidget: const NoBooksFoundWidget(),
    );
  }

  Column _appbar(BuildContext context) {
    return Column(
      children: [
        HeadlineWidget(title: AppString.genre).start,
        Wrap(
          spacing: 5.0,
          runSpacing: 1.0,
          children: [
            GenreCard(
              genere: 'Romance',
              color: Colors.red,
              isChip: true,
              selectedGenre: selectedGenre,
            ),
            GenreCard(
              genere: 'Fantasy',
              color: Colors.orange,
              isChip: true,
              selectedGenre: selectedGenre,
            ),
            GenreCard(
              genere: 'CEO',
              color: Colors.brown,
              isChip: true,
              selectedGenre: selectedGenre,
            ),
            GenreCard(
              genere: 'Werewolf',
              color: Colors.grey,
              isChip: true,
              selectedGenre: selectedGenre,
            ),
            GenreCard(
              genere: 'Mystery',
              color: Colors.blue,
              isChip: true,
              selectedGenre: selectedGenre,
            ),
            GenreCard(
              genere: 'Sci-Fi',
              color: Colors.deepOrange,
              isChip: true,
              selectedGenre: selectedGenre,
            ),
            GenreCard(
              genere: 'Historical',
              color: Colors.brown,
              isChip: true,
              selectedGenre: selectedGenre,
            ),
            GenreCard(
              genere: 'Adventure',
              color: Colors.blueGrey,
              isChip: true,
              selectedGenre: selectedGenre,
            ),
          ],
        ).start,
        10.height,
      ],
    );
  }

  Widget _search(BuildContext context) {
    return CommonTextField(
      borderRadius: 40,
      validationType: .notRequired,
      hintText: AppString.search_by_title_author_or_genre,
      prefixIcon: Icon(Icons.search, color: context.color.subtext),
    );
  }
}
