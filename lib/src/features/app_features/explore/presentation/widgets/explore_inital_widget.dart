import 'package:core_kit/text/common_text.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/features/app_features/explore/presentation/widgets/genere_card_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/explore/presentation/widgets/tag_chip_widget.dart';

class ExploreInitalWidget extends StatelessWidget {
  const ExploreInitalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  SingleChildScrollView _content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.height,
          CommonText(
            text: AppString.browse_by_genre,
            fontSize: 18,
            fontWeight: .bold,
            textColor: context.color.headingBoldText,
          ),
          10.height,
          // 1. Genre Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            childAspectRatio: 1.6,
            children: const [
              GenreCard( genere: 'Romance', color: Colors.red),
              GenreCard(genere: 'Fantasy', color: Colors.orange),
              GenreCard(genere: 'CEO', color: Colors.brown),
              GenreCard(genere: 'Werewolf', color: Colors.grey),
              GenreCard(genere: 'Mystery', color: Colors.blue),
              GenreCard(genere: 'Sci-Fi', color: Colors.deepOrange),
              GenreCard(genere: 'Historical', color: Colors.brown),
              GenreCard( genere: 'Adventure', color: Colors.blueGrey),
            ],
          ),

          const SizedBox(height: 32),

          // 2. Popular Tags Section
          CommonText(
            text: AppString.popular_tags,
            fontSize: 18,
            fontWeight: .bold,
            textColor: context.color.headingBoldText,
          ),
          16.height,
          const Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              TagChip(label: '#Enemies to Lovers'),
              TagChip(label: '#Mafia Romance'),
              TagChip(label: '#Second Chance'),
              TagChip(label: '#Alpha Male'),
              TagChip(label: '#Fated Mates'),
              TagChip(label: '#Billionaire'),
              TagChip(label: '#Magic Academy'),
              TagChip(label: '#Revenge'),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
