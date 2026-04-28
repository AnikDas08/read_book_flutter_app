import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/corekit/back_button.dart';
import 'package:riverpod_tamplates/src/features/app_features/home/presentation/widget/books_feed_card_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/library/presentation/widgets/book_widget.dart';

@RoutePage()
class ShowMoreBooksScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: title,
        appbarConfig: AppbarConfig(height: 70, titleAlignment: .center),
        leading: const BackButtonWidget(isDark: true, iconColor: Colors.white),
      ),
      body: isListType
          ? SmartListLoader(
              padding: const EdgeInsets.only(
                left: Constants.padding,
                right: Constants.padding,
                top: Constants.padding,
              ),
              itemCount: 30,
              itemBuilder: (context, index) {
                return const BookFeedCardWidget();
              },
            )
          : SmartStaggeredLoader(
              padding: const EdgeInsets.only(
                left: Constants.padding,
                right: Constants.padding,
                top: Constants.padding,
              ),
              itemCount: 50,
              gridConfig: GridConfig(itemInRow: 2, aspectRatio: .68),
              itemBuilder: (context, index) {
                return BookWidget(
                  isNew: isNew,
                  isTrending: isTrending,
                );
              },
            ),
    );
  }
}
