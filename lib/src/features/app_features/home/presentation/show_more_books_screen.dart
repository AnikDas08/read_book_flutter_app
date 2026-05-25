import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/constance/constants.dart';
import 'package:unkutdrama_kpnovel/config/corekit/back_button.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/home/application/home_book_provider.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/home/data/model/home_book_model.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/home/presentation/widget/books_feed_card_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/library/presentation/widgets/book_widget.dart';

@RoutePage()
class ShowMoreBooksScreen extends ConsumerWidget {
  const ShowMoreBooksScreen({
    super.key,
    required this.title,
    this.isNew = false,
    this.isTrending = false,
    required this.isListType,
  });
  final String title;
  final bool isNew;
  final bool isTrending;
  final bool isListType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<HomeBookModel>> booksAsync;

    if (isTrending) {
      booksAsync = ref.watch(trendingBooksProvider);
    } else if (isListType) {
      booksAsync = ref.watch(newReleasesProvider);
    } else {
      booksAsync = ref.watch(recommendedBooksProvider);
    }

    return Scaffold(
      appBar: CommonAppBar(
        title: title,
        appbarConfig: AppbarConfig(height: 70, titleAlignment: .center),
        leading: const BackButtonWidget(isDark: true, iconColor: Colors.white),
      ),
      body: booksAsync.when(
        data: (books) => isListType
            ? ListView.builder(
                padding: const EdgeInsets.only(
                  left: Constants.padding,
                  right: Constants.padding,
                  top: Constants.padding,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return BookFeedCardWidget(book: books[index]);
                },
              )
            : GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return BookWidget(
                    book: books[index],
                    isNew: isNew,
                    isTrending: isTrending,
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  childAspectRatio: .70,
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }
}
