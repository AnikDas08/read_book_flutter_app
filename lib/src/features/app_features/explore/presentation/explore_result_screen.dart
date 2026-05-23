import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/constance/constants.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/explore/presentation/widgets/explore_result_widget.dart';

@RoutePage()
class ExploreResultScreen extends StatelessWidget {
  const ExploreResultScreen({super.key, required this.genre});
  final String genre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: genre),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
        child: Column(
          children: [Expanded(child: ExploreResultWidget(itemCount: 30, selectedGenre: genre))],
        ),
      ),
    );
  }
}
