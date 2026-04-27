import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({super.key, this.isTrending = false, this.isNew = true});

  final bool isTrending;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.navigate(const BookDetailsRoute());
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;
          final tagMaxWidth = (maxWidth - 20.w) / 2;

          return Container(
            width: maxWidth,
            height: maxHeight,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                Expanded(
                  child: Stack(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: CommonImage(src: Constants.sampleImage),
                        ),
                      ),
                      if (isNew || isTrending)
                        Positioned(top: 8, left: 8, child: _buildNewBadge(context)),
                    ],
                  ),
                ),

                // Content Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonText(
                        text: 'Shadow of the Moon',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        textColor: Color(0xFF333333),
                      ),
                      CommonText(
                        text: 'M. M. KAYE',
                        fontSize: 10,
                        textColor: context.color.subtext,
                      ),
                      4.height,
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const Icon(Icons.star_half, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          const Text(
                            '4.0 / 5',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isNew ? const Color(0xFFFFD700) : null,
        gradient: isTrending ? context.color.ctaGradientBackgroundAccent : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isNew ? Icons.auto_awesome : Icons.trending_up_outlined,
            size: 10,
            color: isNew ? const Color(0xFF5E35B1) : Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            isNew ? AppString.New : AppString.Trending,
            style: TextStyle(
              color: isNew ? const Color(0xFF5E35B1) : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, {double? maxWidth}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth ?? 80, minHeight: 40, maxHeight: 40),
      child: CommonText(
        text: label,
        borderColor: Colors.transparent,
        left: 10,
        right: 10,
        top: 5,
        bottom: 5,
        backgroundColor: const Color(0xFFF3E5F5),
        borderRadious: 25,
        autoResize: false,
        style: const TextStyle(color: Color(0xFF7B1FA2), fontWeight: FontWeight.w500, fontSize: 12),
      ),
    );
  }
}
