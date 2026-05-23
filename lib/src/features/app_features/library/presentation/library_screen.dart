import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:core_kit/list_loader/smart_tab_list_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/constance/enums.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';
import 'package:unkutdrama_kpnovel/src/constants/app_font_sizes.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/library/presentation/widgets/book_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/library/presentation/widgets/no_books_found.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/library/riverpod/library_notifire.dart';

@RoutePage()
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final selectedLibrary = ref.watch(selectedLibraryProvider);
          final selectedLibraryNotifier = ref.read(
            selectedLibraryProvider.notifier,
          );
          return Column(
            children: [
              _header(context, selectedLibraryNotifier, selectedLibrary),
              Expanded(
                child: SmartTabListLoader(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  tabs: const [
                    SmartTabConfig(tab: LibrayType.Reading, itemCount: 20),
                    SmartTabConfig(tab: LibrayType.Completed, itemCount: 0),
                    SmartTabConfig(tab: LibrayType.WantToRead, itemCount: 40),
                    SmartTabConfig(tab: LibrayType.Paused, itemCount: 40),
                  ],
                  itemBuilder: (ctx, index) {
                    return BookWidget(
                      isCompleted: selectedLibrary == LibrayType.Completed,
                      showProgress: true,
                    );
                  },
                  value: selectedLibrary,
                  gridConfig: GridConfig(
                    itemInRow: 3,
                    aspectRatio: .70,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 6,
                  ),
                  emptyWidget: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 4),
                      const NoBooksFoundWidget(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _header(
    BuildContext context,
    SelectedLibrary selectedLibraryNotifire,
    LibrayType selectedLibray,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (MediaQuery.of(context).padding.top + 10).height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: AppString.my_library,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CommonText(
                text: AppString.hide_profile,
                fontSize: 14,
                textColor: context.color.ctaButtonsText,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          16.height,
          _tabBuilder(selectedLibraryNotifire, selectedLibray, context),
          12.height,
        ],
      ),
    );
  }

  Widget _tabBuilder(
    SelectedLibrary selectedLibraryNotifire,
    LibrayType selectedLibray,
    BuildContext context,
  ) {
    final tabs = LibrayType.values.map((e) {
      IconData icon;
      switch (e) {
        case LibrayType.Reading:
          icon = Icons.menu_book_outlined;
          break;
        case LibrayType.Completed:
          icon = Icons.check_circle_outline;
          break;
        case LibrayType.WantToRead:
          icon = Icons.star_outline;
          break;
        case LibrayType.Paused:
          icon = Icons.access_time_outlined;
          break;
      }
      return _tabItem(
        type: e,
        count: e == LibrayType.Reading ? 4 : 0,
        context: context,
        prefixIcon: icon,
        onTap: () {
          selectedLibraryNotifire.setLibrary(e);
        },
        selectedType: selectedLibray,
      );
    }).toList();

    return SizedBox(
      key: const ValueKey('tab_builder'),
      height: 48,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(children: [...tabs]),
      ),
    );
  }

  Widget _tabItem({
    required LibrayType type,
    required int count,
    required LibrayType selectedType,
    Function()? onTap,
    required BuildContext context,
    required IconData prefixIcon,
  }) {
    final isSelected = selectedType == type;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          border: isSelected
              ? null
              : Border.all(width: 1, color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(100),
          color: isSelected ? null : Colors.white,
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF5B34FF), Color(0xFF8E44FF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF5B34FF).withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              prefixIcon,
              size: 16,
              color: isSelected ? Colors.white : const Color(0xFF9BA3AF),
            ),
            6.width,
            CommonText(
              text: type.title,
              fontSize: AppFontSizes.large,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              textColor: isSelected ? Colors.white : const Color(0xFF6B7280),
            ),
            6.width,
            Container(
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.3)
                    : const Color(0xFFF3F4F6),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: AppFontSizes.small,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
