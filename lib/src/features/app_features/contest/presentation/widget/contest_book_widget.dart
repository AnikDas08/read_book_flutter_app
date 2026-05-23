import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';

class ContestBookWidget extends StatelessWidget {
  final String bookTitle;
  final String authorName;
  final String voteCount;
  final String imageUrl;

  const ContestBookWidget({
    super.key,
    required this.bookTitle,
    required this.authorName,
    required this.voteCount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Book Cover Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CommonImage(src: imageUrl, height: 60, width: 60),
          ),
          const SizedBox(width: 16),
          // Title and Author
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  text: bookTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                CommonText(
                  text: authorName,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF7E899D),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Vote Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB), // Light grey badge
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.flash_on, size: 18, color: Colors.black),
                const SizedBox(width: 4),
                CommonText(
                  text: "$voteCount ${AppString.votes}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
