import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/data/model/comment_model.dart';

class CommentSection extends StatelessWidget {
  CommentSection({super.key, required this.scrollController});

  final ScrollController scrollController;

  final List<Comment> comments = [
    Comment(
      author: 'Sarah Chen',
      content:
          'OMG! That plot twist at the end! I did not see it coming at all! The author is absolutely brilliant!',
      timeAgo: '2 hours ago',
      likes: 234,
    ),
    Comment(
      author: 'Mike Johnson',
      content: 'I know right! The foreshadowing was there all along!',
      timeAgo: '2 hours ago',
      likes: 234,
      isReply: true,
    ),
    Comment(
      author: 'Sarah Chen',
      content:
          'OMG! That plot twist at the end! I did not see it coming at all! The author is absolutely brilliant!',
      timeAgo: '2 hours ago',
      likes: 234,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Container(
            width: 84.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: const Color(0xFFD4D9E2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          22.height,
          Row(
            children: [
              const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 30,
                color: Color(0xFF111111),
              ),
              10.width,
              const CommonText(
                text: 'Comments',
                fontSize: AppFontSizes.display,
                fontWeight: FontWeight.w700,
                textColor: Color(0xFF111111),
              ),
            ],
          ),
          4.height,
          const CommonText(
            text: '3 discussions',
            left: 40,
            fontSize: AppFontSizes.heading,
            fontWeight: FontWeight.w400,
            textColor: Color(0xFF758195),
          ).start,
          16.height,
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: comments.length,
              itemBuilder: (context, index) =>
                  _CommentCard(comment: comments[index]),
            ),
          ),
          4.height,
          const CommonText(
            text: 'Load More Comments',
            fontSize: AppFontSizes.heading,
            fontWeight: FontWeight.w400,
            textColor: Color(0xFF4D8DFF),
          ),
          16.height,
          TextField(
            decoration: InputDecoration(
              hintText: 'Share your thoughts about this chapter...',
              hintStyle: const TextStyle(
                fontSize: AppFontSizes.heading,
                color: Color(0xFFB1B8C7),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 18.h,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 54.w,
                  height: 54.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA98EF7),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.send_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(
                  color: Color(0xFF352CFF),
                  width: 1.6,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(
                  color: Color(0xFF352CFF),
                  width: 1.6,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(
                  color: Color(0xFF352CFF),
                  width: 1.8,
                ),
              ),
            ),
          ),
          10.height,
          Row(
            children: const [
              Icon(Icons.access_time, size: 20, color: Color(0xFF758195)),
              SizedBox(width: 8),
              Expanded(
                child: CommonText(
                  text: 'Comments require admin approval',
                  fontSize: AppFontSizes.title,
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF758195),
                ),
              ),
              CommonText(
                text: '0/500',
                fontSize: AppFontSizes.title,
                fontWeight: FontWeight.w400,
                textColor: Color(0xFF8B8B8B),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommentCard extends StatelessWidget {
  const _CommentCard({required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: comment.isReply ? 28.w : 0, bottom: 16.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: comment.isReply ? const Color(0xFFF0F6FF) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: comment.isReply
                ? const Color(0xFFD9E8FF)
                : const Color(0xFFEEEEEE),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: const Color(0xFFA6B0C0),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.16),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                color: Colors.white,
                size: 34,
              ),
            ),
            14.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CommonText(
                          text: comment.author,
                          fontSize: AppFontSizes.extraLarge,
                          fontWeight: FontWeight.w700,
                          textColor: const Color(0xFF111111),
                        ),
                      ),
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Color(0xFF98A2B3),
                      ),
                      4.width,
                      CommonText(
                        text: comment.timeAgo,
                        fontSize: AppFontSizes.medium,
                        fontWeight: FontWeight.w400,
                        textColor: const Color(0xFF758195),
                      ),
                    ],
                  ),
                  10.height,
                  CommonText(
                    text: comment.content,
                    fontSize: AppFontSizes.heading,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    textAlign: TextAlign.left,
                    textColor: const Color(0xFF333333),
                  ),
                  14.height,
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F7FB),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite_border_rounded,
                              size: 22,
                              color: Color(0xFFA7B0C0),
                            ),
                            8.width,
                            CommonText(
                              text: '${comment.likes}',
                              fontSize: AppFontSizes.heading,
                              fontWeight: FontWeight.w400,
                              textColor: const Color(0xFF758195),
                            ),
                          ],
                        ),
                      ),
                      16.width,
                      const CommonText(
                        text: 'Reply',
                        fontSize: AppFontSizes.heading,
                        fontWeight: FontWeight.w400,
                        textColor: Color(0xFF4D8DFF),
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
