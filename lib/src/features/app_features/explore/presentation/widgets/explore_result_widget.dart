import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:core_kit/list_loader/smart_tab_list_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/explore/riverpod/explore_notifire.dart';
import 'package:riverpod_tamplates/src/features/app_features/library/presentation/widgets/no_books_found.dart';

class ExploreResultWidget extends ConsumerWidget {
  const ExploreResultWidget({super.key, this.itemCount, this.selectedGenre});

  final int? itemCount;
  final String? selectedGenre;

  static const _tags = [
    '#Enemies to Lovers',
    '#Mafia Romance',
    '#Revenge',
    '#Love',
    '#Novels',
    '#Seduction',
    '#Angry',
  ];
  static const _genres = [
    _GenreItem('All', Color(0xFF151515)),
    _GenreItem('Romance', Colors.red),
    _GenreItem('CEO', Color(0xFF5D4037)),
    _GenreItem('Fantasy', Colors.orange),
    _GenreItem('Werewolf', Color(0xFF444444)),
    _GenreItem('Mystery', Color(0xFF8AA7CB)),
    _GenreItem('Sci-Fi', Color(0xFFFF5A00)),
    _GenreItem('Historical', Color(0xFFC58A42)),
    _GenreItem('Adventure', Color(0xFF795F5F)),
    _GenreItem('Billionaire', Color(0xFFC319C9)),
    _GenreItem('Contemporary', Color(0xFF5364DA)),
    _GenreItem('Revenge', Color(0xFF19B313)),
    _GenreItem('Mafia', Color(0xFFA0A210)),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exploreNotifireProvider);
    final activeGenre = selectedGenre ?? state.selectedGenre;
    final hasBooks =
        state.searchText.trim().isEmpty && activeGenre != 'Mystery';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CommonText(
            text: AppString.popular_tags,
            fontSize: AppFontSizes.extraLarge,
            fontWeight: FontWeight.w700,
            textColor: context.color.headingBoldText,
          ),
        ),
        const _TagRow(tags: _tags),
        10.height,
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _GenreRail(genres: _genres),
              Expanded(
                child: hasBooks
                    ? _BookResultsList(itemCount: itemCount ?? 6)
                    : const _ExploreEmptyState(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TagRow extends ConsumerWidget {
  const _TagRow({required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exploreNotifireProvider);
    final notifier = ref.read(exploreNotifireProvider.notifier);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tags.map((tag) {
          final isSelected = state.selectedTag == tag;
          return GestureDetector(
            onTap: () => notifier.selectTag(tag),
            child: Container(
              height: 36.h,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? null : context.color.bgColor,
                gradient: isSelected
                    ? context.color.ctaGradientBackgroundAccent
                    : null,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.14),
                    blurRadius: 18,
                    offset: const Offset(0, 9),
                  ),
                ],
              ),
              child: CommonText(
                text: tag,
                fontSize: AppFontSizes.small,
                fontWeight: .w400,
                textColor: isSelected
                    ? context.color.buttonTextWhite
                    : const Color(0xFF364153),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _GenreRail extends ConsumerWidget {
  const _GenreRail({required this.genres});

  final List<_GenreItem> genres;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGenre = ref.watch(exploreNotifireProvider).selectedGenre;
    final notifier = ref.read(exploreNotifireProvider.notifier);

    return SizedBox(
      width: 85.w,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          final isSelected = selectedGenre == genre.label;
          return GestureDetector(
            onTap: () => notifier.selectGenre(genre.label),
            child: Container(
              height: 31.h,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? null : context.color.bgColor,
                gradient: isSelected
                    ? context.color.ctaGradientBackgroundAccent
                    : null,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.13),
                    blurRadius: 18,
                    offset: const Offset(0, 9),
                  ),
                ],
              ),
              child: CommonText(
                text: genre.label,
                fontSize: AppFontSizes.small.sp,
                fontWeight: .w400,
                textColor: isSelected
                    ? context.color.buttonTextWhite
                    : genre.color,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BookResultsList extends StatelessWidget {
  const _BookResultsList({required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SmartListLoader(
      padding: const EdgeInsets.only(right: 16, left: 4),
      itemCount: 50,
      emptyWidget: const NoBooksFoundWidget(),
      onRefresh: () {},
      onLoadMore: (page) {},

      limit: 10,
      itemBuilder: (_, index) {
        return _ExploreBookCard(isCompleted: index.isEven);
      },
    );
  }
}

class _ExploreBookCard extends StatelessWidget {
  const _ExploreBookCard({required this.isCompleted});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final statusColor = isCompleted
        ? const Color(0xFF00C920)
        : const Color(0xFFFF8700);

    return GestureDetector(
      onTap: () => context.router.navigate(const BookDetailsRoute()),
      child: Container(
        height: 100,
        margin: .only(bottom: 6),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: context.color.bgColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: const CommonImage(
                src: Constants.sampleImage,
                width: 92,
                height: 100,
                fill: BoxFit.cover,
              ),
            ),
            6.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 135.w,
                    child: const CommonText(
                      text: 'Echoes of Tomorrow',
                      fontSize: AppFontSizes.medium,
                      fontWeight: .bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textColor: Color(0xFF111111),
                    ),
                  ),
                  const CommonText(
                    text: 'Dr. Sarah Chen',
                    fontSize: AppFontSizes.small,
                    maxLines: 1,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    textColor: Colors.black,
                  ),
                  const CommonText(
                    text:
                        'She was his assistant. He was his teacher. She was his mentor. He was his friend.',
                    fontSize: AppFontSizes.small,
                    maxLines: 2,
                    textAlign: .left,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    textColor: Color(0xFF6B7280),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      ...List.generate(4, (_) {
                        return const Icon(
                          Icons.star,
                          color: Color(0xFFFFCC00),
                          size: 12,
                        );
                      }),
                      const Icon(
                        Icons.star,
                        color: Color(0xFFC8C8C8),
                        size: 12,
                      ),
                      6.width,
                      const CommonText(
                        text: '4 / 5',
                        fontSize: AppFontSizes.small,
                        fontWeight: FontWeight.w400,
                        textColor: Color(0xFF111111),
                      ),
                      const Spacer(),
                      CommonText(
                        text: isCompleted ? 'Completed' : 'Ongoing',
                        fontSize: AppFontSizes.caption,
                        fontWeight: FontWeight.bold,
                        textColor: statusColor,
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

class _ExploreEmptyState extends StatelessWidget {
  const _ExploreEmptyState();

  @override
  Widget build(BuildContext context) {
    return const NoBooksFoundWidget();
  }
}

class _GenreItem {
  const _GenreItem(this.label, this.color);

  final String label;
  final Color color;
}
