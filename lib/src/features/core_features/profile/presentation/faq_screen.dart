import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/corekit/back_button.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';

@RoutePage()
class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  static const _question = 'How Share Charge works?';
  static const _answer =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,";

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final _expandedIndexController = ValueNotifier<int?>(-1);

  @override
  void dispose() {
    _expandedIndexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        leading: const BackButtonWidget(isDark: false),

        appbarConfig: AppbarConfig(
          decoration: () => const BoxDecoration(color: Colors.white),
        ),
      ),
      backgroundColor: context.color.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.height,
              CommonText(
                text: "FAQ's",
                fontSize: AppFontSizes.extraLarge,
                fontWeight: FontWeight.w500,
                textColor: context.color.headingBoldText,
              ),
              24.height,
              ValueListenableBuilder<int?>(
                valueListenable: _expandedIndexController,
                builder: (context, expandedIndex, _) {
                  return Column(
                    children: List.generate(
                      7,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _FaqTile(
                          isOpen: expandedIndex == index,
                          onToggle: () {
                            _expandedIndexController.value =
                                expandedIndex == index ? -1 : index;
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.isOpen, required this.onToggle});

  final bool isOpen;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: EdgeInsets.fromLTRB(12, isOpen ? 20 : 0, 12, isOpen ? 18 : 0),
        constraints: BoxConstraints(minHeight: isOpen ? 210 : 68),
        decoration: BoxDecoration(
          color: context.color.bgColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Expanded(
                  child: CommonText(
                    text: FaqScreen._question,
                    fontSize: AppFontSizes.medium,
                    fontWeight: FontWeight.w500,
                    textColor: Color(0xFF333333),
                  ),
                ),
                Icon(
                  isOpen ? Icons.remove : Icons.add,
                  size: 24,
                  color: isOpen ? Colors.black : const Color(0xFF9CA3AF),
                ),
              ],
            ),
            if (isOpen) ...[
              14.height,
              const Divider(height: 1, color: Color(0xFFE5E7EB)),
              18.height,
              const CommonText(
                text: FaqScreen._answer,
                fontSize: AppFontSizes.medium,
                textColor: Color(0xFF6B7280),
                textAlign: TextAlign.left,
                isDescription: true,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PlainBackButton extends StatelessWidget {
  const _PlainBackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pop(),
      child: const SizedBox(
        width: 48,
        height: 48,
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFF1C1CFF),
          size: 24,
        ),
      ),
    );
  }
}
