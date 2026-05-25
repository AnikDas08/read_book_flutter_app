import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/constance/constants.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';

class StoryCardWidget extends StatelessWidget {
  final String title;
  final String author;
  final String summary;
  final String? imageUrl;
  final double rating;
  final int chapters;
  final String views;

  const StoryCardWidget({
    super.key,
    this.title = 'Love in the Boardroom',
    this.author = 'Victoria Sterling',
    this.summary =
        'She was his assistant. He was her boss. But the lines between business and pleasure blur in this steamy romance.',
    this.imageUrl,
    this.rating = 4.8,
    this.chapters = 5,
    this.views = '45K',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push( BookDetailsRoute(bookId: ''));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonImage(
              src: imageUrl ?? Constants.sampleImage,
              width: 85,
              height: 110,
              enableAspectRatio: true,
              borderRadius: 16,
            ),
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CommonText(
                          text: title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1C1E),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  CommonText(
                    text: author,
                    style: const TextStyle(fontSize: 14, color: Color(0xFF9EA7B5)),
                  ),
                  8.height,

                  // Story Summary
                  CommonText(
                    text: summary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, height: 1.3, color: Color(0xFF424242)),
                  ),
                  8.height,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 18),
                          const SizedBox(width: 4),
                          CommonText(
                            text: rating.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          // const SizedBox(width: 12),
                          // const Icon(Icons.menu_book_rounded, color: Color(0xFF9EA7B5), size: 16),
                          // const SizedBox(width: 4),
                          // CommonText(
                          //   text: '$chapters ${AppString.chapters}',
                          //   style: const TextStyle(color: Color(0xFF9EA7B5), fontSize: 12),
                          // ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.visibility_outlined, color: Color(0xFF9EA7B5), size: 16),
                          const SizedBox(width: 4),
                          CommonText(
                            text: views,
                            style: const TextStyle(color: Color(0xFF9EA7B5), fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
