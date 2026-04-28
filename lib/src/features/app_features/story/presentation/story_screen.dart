import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/constance/headline_widget.dart';
import 'package:riverpod_tamplates/config/corekit/back_button.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/app_features/story/presentation/widget/story_card_widget.dart';

@RoutePage()
class StoryScreen extends ConsumerStatefulWidget {
  const StoryScreen({super.key});

  @override
  ConsumerState<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends ConsumerState<StoryScreen> {
  final ValueNotifier<int> _selectedTab = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Short Stories",
        leading: const BackButtonWidget(isDark: true,iconColor: Colors.white,),
        appbarConfig:  AppbarConfig(height: 90, titleAlignment: .center),
      ),
      body: SmartListLoader(
        itemCount: 30,
        topWidget: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 20.h),
          child: ValueListenableBuilder<int>(
            valueListenable: _selectedTab,
            builder: (context, selectedIndex, _) {
              return Row(
                children: [
                  Expanded(
                    child: _TabButton(
                      title: 'Top Short Stories',
                      isSelected: selectedIndex == 0,
                      onTap: () => _selectedTab.value = 0,
                    ),
                  ),
                  12.width,
                  Expanded(
                    child: _TabButton(
                      title: 'Trending Short Stories',
                      isSelected: selectedIndex == 1,
                      onTap: () => _selectedTab.value = 1,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        itemBuilder: (context, index) {
          return const StoryCardWidget();
        },
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? null : const Color(0xFFE5E7EB),
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF5B34FF), Color(0xFF8E44FF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          borderRadius: BorderRadius.circular(14),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF5B34FF).withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: CommonText(
          text: title,
          fontSize: AppFontSizes.small,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          textColor: isSelected ? Colors.white : const Color(0xFF9BA3AF),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
