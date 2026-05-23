import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/explore/presentation/widgets/explore_result_widget.dart';

@RoutePage()
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: ExploreResultWidget(),
    );
  }
}
