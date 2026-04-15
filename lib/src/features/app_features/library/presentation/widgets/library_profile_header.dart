import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/common/setting_icon_widget.dart';

class LibraryProfileHeader extends StatelessWidget {
  const LibraryProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.width,
            const CommonImage(src: Constants.sampleImage, size: 80, borderRadius: 80),
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    text: 'Alex Morgan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  CommonText(
                    text: 'alex.morgan@email.com',
                    style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8)),
                  ),
                  8.height,
                  CommonButton(
                    onTap: (){
                      appRouter.push(const EditProfileRoute());
                    },
                    buttonColor: context.color.blue300.withValues(alpha: 0.5),
                    titleText: AppString.edit_profile,
                    borderColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    buttonWidth: 10,
                    buttonHeight: 30,
                    titleSize: 12,
                    prefix: const Icon(Icons.edit_outlined, size: 18, color: Colors.white),
                  ),
                ],
              ),
            ),

            const SettingButtonWidget(),
            16.width,
          ],
        ),
        8.height,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: AppString.books_read,
                style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
              ),
              const CommonText(
                text: '127',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
