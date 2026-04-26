import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';

class BookmarkModalWidget extends StatefulWidget {
  const BookmarkModalWidget({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<BookmarkModalWidget> createState() => _BookmarkModalWidgetState();
}

class _BookmarkModalWidgetState extends State<BookmarkModalWidget> {
  int selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 18.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: ListView(
        controller: widget.scrollController,
        children: [
          Center(
            child: Container(
              width: 84.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: const Color(0xFFD4D9E2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          24.height,
          Row(
            children: [
              const Icon(
                Icons.bookmark_add_outlined,
                size: 28,
                color: Color(0xFF111111),
              ),
              10.width,
              const CommonText(
                text: 'Bookmark',
                fontSize: AppFontSizes.display,
                fontWeight: FontWeight.w700,
                textColor: Color(0xFF111111),
              ),
            ],
          ),
          10.height,
          const CommonText(
            text: 'Chapter 2: Awakening Powers',
            fontSize: AppFontSizes.heading,
            fontWeight: FontWeight.w400,
            textColor: Color(0xFF444444),
          ),
          22.height,
          _BookmarkOption(
            emoji: '⭐',
            title: 'Favorites',
            subtitle: '12 chapters',
            iconBackground: const LinearGradient(
              colors: [Color(0xFFFFC400), Color(0xFFF59E0B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            isSelected: selectedOption == 0,
            onTap: () => setState(() => selectedOption = 0),
          ),
          14.height,
          _BookmarkOption(
            emoji: '📚',
            title: 'Want to Read',
            subtitle: '8 chapters',
            iconBackground: const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF4C35FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            isSelected: selectedOption == 1,
            onTap: () => setState(() => selectedOption = 1),
          ),
          24.height,
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              height: 74.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2B26FF), Color(0xFF7A3FFF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              alignment: Alignment.center,
              child: const CommonText(
                text: 'Done',
                fontSize: AppFontSizes.heading,
                fontWeight: FontWeight.w700,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookmarkOption extends StatelessWidget {
  const _BookmarkOption({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.iconBackground,
    required this.isSelected,
    required this.onTap,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final Gradient iconBackground;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE9ECF2), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 78.w,
              height: 78.w,
              decoration: BoxDecoration(
                gradient: iconBackground,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(emoji, style: const TextStyle(fontSize: 36)),
            ),
            16.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title,
                    fontSize: AppFontSizes.heading,
                    fontWeight: FontWeight.w400,
                    textColor: const Color(0xFF111111),
                  ),
                  4.height,
                  CommonText(
                    text: subtitle,
                    fontSize: AppFontSizes.extraLarge,
                    fontWeight: FontWeight.w400,
                    textColor: const Color(0xFF758195),
                  ),
                ],
              ),
            ),
            Container(
              width: 54.w,
              height: 54.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF5B34FF)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF5B34FF)
                      : const Color(0xFFD0D5DD),
                  width: 1.6,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 28,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
