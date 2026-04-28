import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/corekit/back_button.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/common/share_icon_button.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/book/presentation/widgets/success_vote_dailog_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/book_mark_modal_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/comment_widget.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';

@RoutePage()
class BookDetailsScreen extends ConsumerWidget {
  const BookDetailsScreen({super.key});

  static const List<String> _storyParagraphs = [
    'The night was darker than usual. Violet stepped out of her apartment, unaware that her life was about to change forever.',
    'The city lights flickered in the distance, casting long shadows across the empty streets. She pulled her coat tighter around her shoulders, feeling a chill that had nothing to do with the weather.',
    '"You\'re late," a voice said from the shadows.',
    'Violet froze. She knew that voice. It had haunted her dreams for years.',
    '"I didn\'t think you\'d come," she replied, her voice steadier than she felt.',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Book Details",
        leading: const BackButtonWidget(isDark: false),

        appbarConfig: AppbarConfig(
          actions: [ShareIconButton(isDark: false)],
          titleAlignment: .center,
          decoration: () => BoxDecoration(color: Colors.white),
        ),
      ),
      backgroundColor: context.color.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 28.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              22.height,
              Row(
                spacing: 5,
                children: [
                  const Expanded(
                    child: _StatCard(
                      icon: Icons.menu_book_outlined,
                      iconColor: Color(0xFF6B21A8),
                      title: '87',
                      subtitle: 'Chapters',
                    ),
                  ),

                  const Expanded(
                    child: _StatCard(
                      icon: Icons.access_time_outlined,
                      iconColor: Color(0xFF6B21A8),
                      title: 'Completed',
                      subtitle: 'Status',
                    ),
                  ),

                  const Expanded(
                    child: _StatCard(
                      icon: Icons.electric_bolt_outlined,
                      iconColor: Color(0xFFFFC107),
                      title: '7',
                      subtitle: 'Power Stones',
                    ),
                  ),

                  Expanded(
                    child: _VoteCard(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (_) => const Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.symmetric(horizontal: 20),
                            child: SuccessVoteDialogWidget(
                              earnedAmount: 2,
                              totalAmount: 5,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              22.height,
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
                    child: const CommonImage(
                      src: Constants.sampleImage,
                      fill: BoxFit.fill,
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: AppString.shadow_of_the_violet_moon,
                          fontSize: AppFontSizes.extraLarge,
                          fontWeight: FontWeight.w500,
                          textColor: context.color.headingBoldText,
                        ),
                        6.height,
                        const CommonText(
                          text: '• Elena Nightshade',
                          fontSize: AppFontSizes.small,
                          fontWeight: FontWeight.w400,
                          textColor: Color(0xFF333333),
                        ),
                        10.height,
                        const SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _InfoChip(
                                icon: Icons.star,
                                iconColor: Color(0xFFFFC107),
                                text: '4.8',
                              ),
                              SizedBox(width: 8),
                              _InfoChip(
                                icon: Icons.people_outline,
                                text: '1.2M reviews',
                              ),
                              SizedBox(width: 8),
                              _InfoChip(text: 'Age Demand: 18+'),
                            ],
                          ),
                        ),
                        10.height,
                        const Row(
                          children: [
                            Expanded(child: _GenreChip(label: 'Fantasy')),
                            SizedBox(width: 8),
                            Expanded(child: _GenreChip(label: 'Romance')),
                            SizedBox(width: 8),
                            Expanded(child: _GenreChip(label: 'Magic')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              20.height,

              const CommonText(
                text:
                    '''<p>The night was darker than usual. Violet stepped out of her apartment, unaware that her life was about to change forever.</p>

<p>The city lights flickered in the distance, casting long shadows across the empty streets. She pulled her coat tighter around her shoulders, feeling a chill that had nothing to do with the weather.</p>

<p>"You're late," a voice said from the shadows.</p>

<p>Violet froze. She knew that voice. It had haunted her dreams for years.</p>

<p>"I didn't think you'd come," she replied, her voice steadier than she felt.</p>''',
                // isDescription: true,
                fontSize: AppFontSizes.small,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.left,
                textColor: const Color(0xFF1F2937),
              ),

              8.height,
              GestureDetector(
                onTap: () {
                  ref.read(readProvider.notifier).selectBook();
                  context.router.push(const ReadRoute());
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
              22.height,
              Row(
                children: [
                  Expanded(
                    child: _ActionCard(
                      icon: Icons.star_border_rounded,
                      label: 'Review',
                      onTap: () => context.router.push(const ReviewRoute()),
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
                                return const BookmarkModalWidget();
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
      height: 75.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
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
  const _VoteCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 75.h,
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.electric_bolt_outlined, color: Colors.white, size: 12),
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
