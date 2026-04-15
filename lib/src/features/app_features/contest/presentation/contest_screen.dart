import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:core_kit/list_loader/smart_tab_list_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/constance/enums.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/common/app_sigmented_control.dart';
import 'package:riverpod_tamplates/src/features/app_features/contest/presentation/widget/contest_book_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/contest/presentation/widget/contest_writer_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/contest/riverpod/contest_notifier.dart';

@RoutePage()
class ContestScreen extends StatelessWidget {
  const ContestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Consumer(
        builder: (context, ref, _) {
          final selctedContest = ref.watch(selectedContestProvider);


          return SmartTabListLoader(
            padding: const .symmetric(horizontal: Constants.padding),
            appbar: _header(context, selctedContest, ref),
            value: selctedContest,
            onColapsAppbar: _onColupse(context, selctedContest, ref),

            tabs: const [
              SmartTabConfig(tab: ContestType.Writers, itemCount: 10),
              SmartTabConfig(tab: ContestType.Books, itemCount: 50),
            ],
            itemBuilder: (SmartTabContext<ContestType> ctx, int itemIndex) {
              if (ctx.tab == ContestType.Writers) {
                return const ContestWriterWidget(name: 'James Wilson', votes: '1234');
              } else {
                return const ContestBookWidget(
                  bookTitle: 'The Last Stand',
                  authorName: 'James Wilson',
                  voteCount: '1234',
                  imageUrl: Constants.sampleImage,
                );
              }
            },
          );

          // return SmartListLoader(
          //   scrollController: selctedContest.contestType == ContestType.Writers
          //       ? selctedContest.writersScrollController
          //       : selctedContest.booksScrollController,
          //   padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
          //   appbar: _header(context, selctedContest.contestType, ref),
          //   onColapsAppbar: _onColupse(context, selctedContest.contestType, ref),
          //   itemCount: selctedContest.contestType == ContestType.Writers ? 10 : 50,
          //   itemBuilder: (context, index) {
          //     if (selctedContest.contestType == ContestType.Writers) {
          //       return const ContestWriterWidget(name: 'James Wilson', votes: '1234');
          //     } else {
          //       return const ContestBookWidget(
          //         bookTitle: 'The Last Stand',
          //         authorName: 'James Wilson',
          //         voteCount: '1234',
          //         imageUrl: Constants.sampleImage,
          //       );
          //     }
          //   },
          // );
        },
      ),
    );
  }

  Widget _onColupse(BuildContext context, ContestType state, WidgetRef ref) {
    return Container(
      color: context.color.bgColor,
      padding: const .only(left: 16, right: 16, top: 4),
      child: Column(
        children: [_sigmentedButton(state, ref, context), 4.height, _search(context), 5.height],
      ),
    );
  }

  Widget _header(BuildContext context, ContestType state, WidgetRef ref) {
    return Padding(
      padding: const .symmetric(horizontal: Constants.padding),
      child: Column(
        children: [
          4.height,
          _sigmentedButton(state, ref, context),
          // 10.height,
          // RichText(
          //   text: TextSpan(
          //     children: [
          //       TextSpan(
          //         text: 'Rankings based on ',
          //         style: TextStyle(color: context.color.subtext, fontSize: 12),
          //       ),
          //       TextSpan(
          //         text: 'Power Stone Votes',
          //         style: TextStyle(
          //           color: context.color.ctaButtonsText,
          //           fontSize: 12,
          //           fontWeight: .bold,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          4.height,
          _search(context),
          10.height,
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              CommonText(
                text: state == ContestType.Writers ? AppString.top_writers : AppString.top_books,
                fontSize: 18,
                fontWeight: .bold,
                textColor: context.color.headingBoldText,
              ),
              CommonText(text: '50', fontSize: 14, textColor: context.color.subtext),
            ],
          ),
          10.height,
        ],
      ),
    );
  }

  CommonTextField _search(BuildContext context) {
    return CommonTextField(
      borderRadius: 40,
      prefixIcon: Icon(Icons.search, color: context.color.subtext),
      validationType: .notRequired,
      hintText: '${AppString.search}...',
    );
  }

  Widget _sigmentedButton(ContestType state, WidgetRef ref, BuildContext context) {
    return AppSegmentedControl(
      items: ContestType.values,
      selected: state,
      onChanged: (value) {
        ref.read(selectedContestProvider.notifier).setContest(value);
      },
      labelBuilder: (value) {
        return value.displayName;
      },
      backgroundColor: context.color.bgColor,
      borderColor: context.color.blue300.withValues(alpha: 0.2),
      selectedItemColor: context.color.ctaButtonsText,
      selectedTextColor: context.color.buttonTextWhite,
      unselectedTextColor: context.color.subtext,
    );
  }


}
