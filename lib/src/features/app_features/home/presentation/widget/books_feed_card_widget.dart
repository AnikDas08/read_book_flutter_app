import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/constance/constants.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';
import 'package:unkutdrama_kpnovel/src/constants/api_endpoints.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/home/data/model/home_book_model.dart';

class BookFeedCardWidget extends StatelessWidget {
  final HomeBookModel? book;
  const BookFeedCardWidget({super.key, this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(const BookDetailsRoute());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: context.color.bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonImage(
              src: book?.coverImage != null
                  ? '${ApiEndpoints.imageBaseUrl}/${book!.coverImage.replaceAll('\\', '/')}'
                  : Constants.sampleImage,
              width: 85,
              height: 120,
              borderRadius: 12,
            ),
            12.width,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: book?.title ?? 'Love in the Boardroom',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      textColor: const Color(0xFF333333),
                    ),
                    2.height,
                    CommonText(
                      text: book?.author?.fullName ?? 'Victoria Sterling',
                      fontSize: 12,
                      textColor: context.color.subtext,
                    ),
                    6.height,
                    CommonText(
                      text: book?.description ??
                          'She was his assistant. He was her boss. But the lines between business and pleasure blur in this steamy romance.',
                      maxLines: 2,
                      textAlign: .left,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 11,
                      textColor: const Color(0xFF6B7280),
                    ),
                    10.height,
                    Row(
                      children: [
                        _buildActionItem(
                          Icons.star,
                          (book?.ratingCount ?? 4.8).toStringAsFixed(1),
                          color: Colors.amber,
                        ),
                        20.width,
                        _buildActionItem(
                          Icons.chat_bubble_outline_rounded,
                          (book?.commentCount ?? 0).toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            8.width,
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, {Color? color}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color ?? const Color(0xFF9EA7B5)),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF4B5563),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
