import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/src/constants/app_font_sizes.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/data/model/book_review_model.dart';

class UserReviewCardWidget extends StatelessWidget {
  const UserReviewCardWidget({super.key, required this.review});
  final ReviewResult review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFA6B0C0),
                  shape: BoxShape.circle,
                  image: review.userId.profile.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(review.userId.profile),
                          fit: BoxFit.cover,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.16),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: review.userId.profile.isEmpty
                    ? const Icon(
                        Icons.person_outline_rounded,
                        color: Colors.white,
                        size: 24,
                      )
                    : null,
              ),
              14.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CommonText(
                            text: review.userId.fullName,
                            fontSize: AppFontSizes.large,
                            fontWeight: FontWeight.w500,
                            textColor: const Color(0xFF111111),
                          ),
                        ),
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Color(0xFF98A2B3),
                        ),
                        4.width,
                        CommonText(
                          text: _formatDate(review.createdAt),
                          fontSize: AppFontSizes.small,
                          fontWeight: FontWeight.w400,
                          textColor: const Color(0xFF667085),
                        ),
                      ],
                    ),
                    8.height,
                    Row(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: Icon(
                            Icons.star,
                            size: 14,
                            color: index < review.rating
                                ? const Color(0xFFFFC700)
                                : const Color(0xFFE4E7EC),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          14.height,
          CommonText(
            text: review.review,
            fontSize: AppFontSizes.medium,
            fontWeight: FontWeight.w400,
            isDescription: true,
            textColor: const Color(0xFF344054),
            height: 1.55,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'just now';
    }
  }
}
