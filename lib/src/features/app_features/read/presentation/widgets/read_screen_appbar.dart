import 'package:core_kit/text/common_text.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/presentation/widgets/reading_setting_modal.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';

class ReadScreenAppBar extends StatelessWidget {
  const ReadScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final readState = ref.watch(readProvider);
        final isBookSelected = readState.slectedBook != null;
        return Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    CommonText(
                      text: AppString.no_book_selected,
                      fontSize: 14,
                      fontWeight: .w600,
                      textColor: context.color.buttonTextWhite,
                    ),
                    CommonText(
                      text: AppString.no_chapter_available_yet,
                      fontSize: 12,
                      fontWeight: .w400,
                      textColor: context.color.buttonTextWhite,
                    ),
                  ],
                ),

                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (isBookSelected) {
                      Scaffold.of(context).openEndDrawer();
                    }
                  },
                  child: Icon(
                    Icons.list_outlined,
                    size: 30,
                    color: isBookSelected ? context.color.buttonTextWhite : context.color.iconClr,
                  ),
                ),
                10.width,
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      isScrollControlled: true,
                      builder: (context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 0.6,
                          minChildSize: 0.4,
                          maxChildSize: .95,
                          expand: false,
                          builder: (context, scrollController) {
                            return ReadingSettingsModal(controller: scrollController);
                          },
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.tune_sharp,
                    size: 20,
                    color: isBookSelected ? context.color.buttonTextWhite : context.color.iconClr,
                  ),
                ),
                16.width,
              ],
            ),
            6.height,
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: LinearProgressIndicator(
                value: .5, color: Colors.amber,
              ),
            ),
          ],
        );
      },
    );
  }
}
