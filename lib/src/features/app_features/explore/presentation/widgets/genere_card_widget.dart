// Custom widget for the Genre Cards
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';

class GenreCard extends StatelessWidget {
  final String genere;
  final Color color;
  final bool isChip;
  final String? selectedGenre;

  const GenreCard({
    super.key,
    required this.genere,
    required this.color,
    this.isChip = false,
    this.selectedGenre,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.router.current.route.name == NavigationRoute.name) {
          context.router.push(ExploreResultRoute(genre: genere));
        } else {
          context.router.replace(ExploreResultRoute(genre: genere));
        }
      },
      child: isChip ? _chip(context) : _normal(),
    );
  }

  Widget _chip(BuildContext context) {
    return Card(
      color: selectedGenre == genere ? context.color.ctaButtonsText : context.color.bgColor,
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: CommonText(
        text: genere,
        fontSize: 14,
        left: 10,
        textColor: selectedGenre == genere ? context.color.buttonTextWhite : context.color.subtext,
        right: 10,
        top: 5,
        borderColor: Colors.white,
        bottom: 5,
        fontWeight: .w500,
      ),
    );
  }

  Container _normal() {
    return Container(
      alignment: .center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child:  CommonText(
        text:  genere,
        alignment:  .center,
        textAlign: .center,
        style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }
}
