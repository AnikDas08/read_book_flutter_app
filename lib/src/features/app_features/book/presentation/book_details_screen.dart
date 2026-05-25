import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/constance/constants.dart';
import 'package:unkutdrama_kpnovel/config/corekit/back_button.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';
import 'package:unkutdrama_kpnovel/src/common/share_icon_button.dart';
import 'package:unkutdrama_kpnovel/src/constants/api_endpoints.dart';
import 'package:unkutdrama_kpnovel/src/constants/app_font_sizes.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/application/book_provider.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/presentation/widgets/success_vote_dailog_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/presentation/widgets/book_mark_modal_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/presentation/widgets/comment_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/riverpod/read_notifier.dart';

@RoutePage()
class BookDetailsScreen extends ConsumerWidget {
  const BookDetailsScreen({super.key, required this.bookId});
  final String bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookDetailsAsync = ref.watch(bookDetailsProvider(bookId));
    final voteState = ref.watch(bookVoteProvider);

    ref.listen<BookVoteState>(bookVoteProvider, (previous, next) {
      if (next.isSuccess) {
        showDialog<void>(
          context: context,
          builder: (_) => const Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(horizontal: 20),
            child: SuccessVoteDialogWidget(earnedAmount: 2, totalAmount: 5),
          ),
        );
      }
    });

    return Scaffold(
      appBar: CommonAppBar(
        title: "Book Details",
        leading: const BackButtonWidget(isDark: false),

        appbarConfig: AppbarConfig(
          actions: [const ShareIconButton(isDark: false)],
          titleAlignment: .center,
          decoration: () => const BoxDecoration(color: Colors.white),
        ),
      ),
      backgroundColor: context.color.bgColor,
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: bookDetailsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                          text: 'Error loading book details: $error',
                          fontSize: AppFontSizes.medium,
                          textColor: Colors.red,
                          textAlign: TextAlign.center,
                        ),
                        16.height,
                        ElevatedButton(
                          onPressed: () =>
                              ref.invalidate(bookDetailsProvider(bookId)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6B21A8),
                          ),
                          child: const Text(
                            'Retry',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  data: (bookDetails) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            spacing: 5,
                            children: [
                              Expanded(
                                child: _StatCard(
                                  icon: Icons.menu_book_outlined,
                                  iconColor: const Color(0xFF6B21A8),
                                  title: '${bookDetails.chapterCount ?? 0}',
                                  subtitle: 'Chapters',
                                ),
                              ),

                              Expanded(
                                child: _StatCard(
                                  icon: Icons.access_time_outlined,
                                  iconColor: const Color(0xFF6B21A8),
                                  title:
                                      bookDetails.status != null &&
                                          bookDetails.status!.isNotEmpty
                                      ? '${bookDetails.status![0].toUpperCase()}${bookDetails.status!.substring(1)}'
                                      : 'Unknown',
                                  subtitle: 'Status',
                                ),
                              ),

                              Expanded(
                                child: _StatCard(
                                  icon: Icons.electric_bolt_outlined,
                                  iconColor: const Color(0xFFFFC107),
                                  title: '${bookDetails.voteCount ?? 0}',
                                  subtitle: 'Power Stones',
                                ),
                              ),

                              Expanded(
                                child: _VoteCard(
                                  isLoading: voteState.isLoading,
                                  onTap: () {
                                    ref
                                        .read(bookVoteProvider.notifier)
                                        .vote(bookId);
                                  },
                                ),
                              ),
                            ],
                          ),
                          10.height,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 94.w,
                                height: 140.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFF1F2937),
                                    width: 1.1,
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: CommonImage(
                                  src: bookDetails.coverImage != null
                                      ? '${ApiEndpoints.imageBaseUrl}/${bookDetails.coverImage!.replaceAll(r'\', '/')}'
                                      : Constants.sampleImage,
                                  fill: BoxFit.fill,
                                ),
                              ),
                              10.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: bookDetails.title ?? '',
                                      fontSize: AppFontSizes.extraLarge,
                                      fontWeight: FontWeight.w500,
                                      textColor: context.color.headingBoldText,
                                    ),
                                    6.height,
                                    CommonText(
                                      text:
                                          '• ${bookDetails.type ?? 'Fantasy'}',
                                      fontSize: AppFontSizes.small,
                                      fontWeight: FontWeight.w400,
                                      textColor: const Color(0xFF333333),
                                    ),
                                    10.height,
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          _InfoChip(
                                            icon: Icons.star,
                                            iconColor: const Color(0xFFFFC107),
                                            text:
                                                bookDetails.ratingCount != null
                                                ? bookDetails.ratingCount!
                                                      .toStringAsFixed(1)
                                                : '0.0',
                                          ),
                                          const SizedBox(width: 8),
                                          _InfoChip(
                                            icon: Icons.visibility,
                                            text: bookDetails.readCount != null
                                                ? (bookDetails.readCount! >=
                                                          1000000
                                                      ? '${(bookDetails.readCount! / 1000000).toStringAsFixed(1)}M'
                                                      : bookDetails
                                                                .readCount! >=
                                                            1000
                                                      ? '${(bookDetails.readCount! / 1000).toStringAsFixed(1)}k'
                                                      : '${bookDetails.readCount}')
                                                : '0',
                                          ),
                                          const SizedBox(width: 8),
                                          _InfoChip(
                                            text:
                                                'Age: ${bookDetails.age ?? 'All'}',
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.height,
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          if (bookDetails.genre != null) ...[
                                            _GenreChip(
                                              label: bookDetails.genre!,
                                            ),
                                            const SizedBox(width: 8),
                                          ],
                                          // if (bookDetails.tags != null)
                                          //   ...bookDetails.tags!.map(
                                          //     (tag) => Padding(
                                          //       padding: const EdgeInsets.only(
                                          //         right: 8.0,
                                          //       ),
                                          //       child: _GenreChip(label: tag),
                                          //     ),
                                          //   ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          10.height,

                          _ExpandableDescription(
                            text: bookDetails.description ?? '',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              GestureDetector(
                onTap: () {
                  ref.read(readProvider.notifier).selectBook(bookId);
                  context.router.push(ReadRoute(bookId: bookId));
                },
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: context.color.ctaGradientBackgroundAccent,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.16),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_arrow_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      CommonText(
                        text: 'Start Reading',
                        fontSize: AppFontSizes.large,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              10.height,
              Row(
                children: [
                  Expanded(
                    child: _ActionCard(
                      icon: Icons.star_border_rounded,
                      label: 'Review',
                      onTap: () =>
                          context.router.push(ReviewRoute(bookId: bookId)),
                    ),
                  ),
                  8.width,
                  Expanded(
                    child: _ActionCard(
                      icon: Icons.bookmark_border_rounded,
                      label: 'Bookmark',
                      onTap: () {
                        showModalBottomSheet<void>(
                          useSafeArea: true,
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (sheetContext) {
                            return DraggableScrollableSheet(
                              initialChildSize: 0.46,
                              minChildSize: 0.35,
                              maxChildSize: 0.82,
                              expand: false,
                              builder: (_, scrollController) {
                                return BookmarkModalWidget(bookId: bookId);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  8.width,
                  Expanded(
                    child: _ActionCard(
                      icon: Icons.chat_bubble_outline_rounded,
                      label: 'Comment',
                      onTap: () {
                        showModalBottomSheet<void>(
                          useSafeArea: true,
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (_) {
                            return DraggableScrollableSheet(
                              initialChildSize: 0.72,
                              minChildSize: 0.5,
                              maxChildSize: 0.92,
                              expand: false,
                              builder: (_, scrollController) {
                                return CommentSection(
                                  bookId: bookId,
                                  scrollController: scrollController,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookHeaderRow extends StatelessWidget {
  const _BookHeaderRow({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        GestureDetector(
          onTap: onBack,
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        CommonText(
          text: title,
          fontSize: AppFontSizes.heading,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
          textColor: context.color.headingBoldText,
        ),
        const ShareIconButton(isDark: false),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF0DEFF), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 12),

          CommonText(
            text: title,
            fontSize: AppFontSizes.small,
            fontWeight: FontWeight.w400,
            textColor: const Color(0xFF111111),
            textAlign: TextAlign.center,
          ),

          CommonText(
            text: subtitle,
            fontSize: AppFontSizes.small,
            fontWeight: FontWeight.w400,
            textColor: const Color(0xFF758195),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _VoteCard extends StatelessWidget {
  const _VoteCard({required this.onTap, this.isLoading = false});

  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF6C1D95), Color(0xFFB24BD8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.electric_bolt_outlined,
                    color: Colors.white,
                    size: 12,
                  ),
                  SizedBox(width: 8),
                  CommonText(
                    text: 'Vote',
                    fontSize: AppFontSizes.small,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.white,
                  ),
                ],
              ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    this.icon,
    this.iconColor = Colors.white,
    required this.text,
  });

  final IconData? icon;
  final Color iconColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFA8A8AE),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor, size: 10),
            6.width,
          ],
          CommonText(
            text: text,
            fontSize: AppFontSizes.small,
            fontWeight: FontWeight.w400,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  const _GenreChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF3E8FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE9D5FF)),
      ),
      child: CommonText(
        text: label,
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w400,
        textColor: const Color(0xFF7E22CE),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const .only(bottom: 5),
        height: 60.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF4C35FF), size: 20),
            4.width,
            CommonText(
              text: label,
              fontSize: AppFontSizes.medium,
              fontWeight: FontWeight.w400,
              textColor: const Color(0xFF4C35FF),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandableDescription extends StatefulWidget {
  final String text;

  const _ExpandableDescription({required this.text});

  @override
  State<_ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<_ExpandableDescription> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: CommonText(
            text: widget.text,
            fontSize: AppFontSizes.medium,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.left,
            textColor: const Color(0xFF1F2937),
            maxLines: 18,
            isDescription: true,
          ),
          secondChild: CommonText(
            text: widget.text,
            fontSize: AppFontSizes.medium,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.left,
            textColor: const Color(0xFF1F2937),
            maxLines: 18,
            isDescription: false,
          ),
        ),
        4.height,
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CommonText(
              text: _isExpanded ? AppString.show_less : AppString.show_more,
              fontSize: AppFontSizes.medium,
              fontWeight: FontWeight.w600,
              textColor: const Color(0xFF6B21A8),
            ),
          ),
        ).end,
      ],
    );
  }
}
