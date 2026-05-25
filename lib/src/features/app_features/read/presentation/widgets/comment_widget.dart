import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/src/constants/app_font_sizes.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/data/model/book_comment_model.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/data/repository/comment_repository.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/riverpod/comment_provider.dart';

class CommentSection extends ConsumerWidget {
  const CommentSection({super.key, required this.scrollController, required this.bookId});
  final String bookId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsAsync = ref.watch(bookCommentsProvider(bookId));

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Container(
            width: 48.w,
            height: 4.h,
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
                size: 20,
                color: Color(0xFF111111),
              ),
              10.width,
              const CommonText(
                text: 'Comments',
                fontSize: AppFontSizes.extraLarge,
                fontWeight: FontWeight.w700,
                textColor: Color(0xFF111111),
              ),
            ],
          ),
          4.height,
          commentsAsync.when(
            data: (comments) => CommonText(
              text: '${comments.length} discussions',
              left: 40,
              fontSize: AppFontSizes.medium,
              fontWeight: FontWeight.w400,
              textColor: const Color(0xFF758195),
            ).start,
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          16.height,
          Expanded(
            child: commentsAsync.when(
              data: (comments) {
                final flattenedComments = _flattenComments(comments);
                return ListView.builder(
                  controller: scrollController,
                  itemCount: flattenedComments.length,
                  itemBuilder: (context, index) {
                    final item = flattenedComments[index];
                    return _CommentCard(
                      comment: item.comment,
                      isReply: item.isReply,
                      bookId: bookId,
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text(err.toString())),
            ),
          ),
          4.height,
          const CommonText(
            text: 'Load More Comments',
            fontSize: AppFontSizes.medium,
            fontWeight: FontWeight.w400,
            textColor: Color(0xFF4D8DFF),
          ),
          16.height,
          TextField(
            decoration: InputDecoration(
              hintText: 'Share your thoughts about this chapter...',
              hintStyle: const TextStyle(
                fontSize: AppFontSizes.small,
                color: Color(0xFFB1B8C7),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA98EF7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.send_outlined,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
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
          const Row(
            children: [
              Icon(Icons.access_time, size: 12, color: Color(0xFF758195)),
              SizedBox(width: 8),
              Expanded(
                child: CommonText(
                  text: 'Comments require admin approval',
                  fontSize: AppFontSizes.small,
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF758195),
                ),
              ),
              CommonText(
                text: '0/500',
                fontSize: AppFontSizes.small,
                fontWeight: FontWeight.w400,
                textColor: Color(0xFF8B8B8B),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<_FlattenedComment> _flattenComments(List<BookComment> comments, {bool isReply = false}) {
    List<_FlattenedComment> flat = [];
    for (var comment in comments) {
      flat.add(_FlattenedComment(comment: comment, isReply: isReply));
      if (comment.replies.isNotEmpty) {
        flat.addAll(_flattenComments(comment.replies, isReply: true));
      }
    }
    return flat;
  }
}

class _FlattenedComment {
  final BookComment comment;
  final bool isReply;

  _FlattenedComment({required this.comment, required this.isReply});
}

class _CommentCard extends ConsumerWidget {
  const _CommentCard({required this.comment, this.isReply = false, required this.bookId});

  final BookComment comment;
  final bool isReply;
  final String bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(left: isReply ? 24.w : 0, bottom: 16.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isReply ? const Color(0xFFF0F6FF) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isReply
                ? const Color(0xFFD9E8FF)
                : const Color(0xFFEEEEEE),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: const Color(0xFFA6B0C0),
                shape: BoxShape.circle,
                image: comment.userId.profile.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(comment.userId.profile),
                        fit: BoxFit.cover,
                      )
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.16),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: comment.userId.profile.isEmpty
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CommonText(
                          text: comment.userId.fullName,
                          fontSize: AppFontSizes.large,
                          fontWeight: FontWeight.w700,
                          textColor: const Color(0xFF111111),
                        ),
                      ),
                      const Icon(
                        Icons.access_time,
                        size: 12,
                        color: Color(0xFF98A2B3),
                      ),
                      4.width,
                      Flexible(
                        child: CommonText(
                          text: _formatDate(comment.createdAt),
                          fontSize: AppFontSizes.small,
                          fontWeight: FontWeight.w400,
                          textColor: const Color(0xFF758195),
                        ),
                      ),
                    ],
                  ),
                  10.height,
                  CommonText(
                    text: comment.message,
                    fontSize: AppFontSizes.medium,
                    fontWeight: FontWeight.w400,
                    isDescription: true,
                    height: 1.5,
                    textAlign: TextAlign.left,
                    textColor: const Color(0xFF333333),
                  ),
                  14.height,
                  Wrap(
                    spacing: 16.w,
                    runSpacing: 8.h,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final response = await ref
                              .read(commentRepositoryProvider)
                              .likeComment(commentId: comment.id);
                          if (response.isSuccess) {
                            ref.invalidate(bookCommentsProvider(bookId));
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6F7FB),
                            borderRadius: BorderRadius.circular(216),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.favorite_border_rounded,
                                size: 14,
                                color: Color(0xFFA7B0C0),
                              ),
                              8.width,
                              CommonText(
                                text: '${comment.likes.length}',
                                fontSize: AppFontSizes.medium,
                                fontWeight: FontWeight.w400,
                                textColor: const Color(0xFF758195),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const CommonText(
                        text: 'Reply',
                        fontSize: AppFontSizes.medium,
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

  String _formatDate(DateTime? date) {
    if (date == null) return '';
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
