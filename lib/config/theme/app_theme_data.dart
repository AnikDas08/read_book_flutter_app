 

import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/theme/extension/app_colors.dart';
import 'package:unkutdrama_kpnovel/config/theme/extension/app_spacing.dart';
import 'package:unkutdrama_kpnovel/config/theme/extension/app_text_style.dart';

extension AppThemeX on BuildContext {
  AppColors get color => Theme.of(this).extension<AppColors>()!;
  AppSpacing get spacing => Theme.of(this).extension<AppSpacing>()!;
  AppTextStyles get textStyle => Theme.of(this).extension<AppTextStyles>()!;
}

class AppTheme {
  AppTheme._();

  static List<ThemeExtension<dynamic>> get _sharedExtensions => [
    AppSpacing.defaultScale(),
    AppTextStyles.defaultStyles(),
  ];

  static ThemeData get light => _themeDataBuilder(
    ThemeData.light(
    useMaterial3: true,
    ).copyWith(extensions: [AppColors.light(), ..._sharedExtensions]),
  );

  static ThemeData get dark => _themeDataBuilder(
    ThemeData.dark(
    useMaterial3: true,
    ).copyWith(extensions: [AppColors.dark(), ..._sharedExtensions]),
  );

  static ThemeData _themeDataBuilder(ThemeData themeData) {
    final colors = themeData.extension<AppColors>()!;
    return themeData.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        hintStyle: TextStyle(color: colors.subtext, fontSize: 14, fontStyle: .normal),
        fillColor: colors.buttonTextWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 1.5.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.cardsInputFields, width: 1.5.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.inputBorderFocus, width: 1.5.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.errorTextValidation, width: 1.5.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.errorTextValidation, width: 1.5.w),
        ),

        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          backgroundColor: colors.blue300,
          foregroundColor: themeData.colorScheme.onPrimary,
          minimumSize: const Size(double.infinity, 48),
          elevation: 0,
          side: const BorderSide(width: 0, color: Colors.transparent),
          shadowColor: Colors.transparent,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,

            color: themeData.extension<AppColors>()?.buttonTextWhite,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48.r)),
        ),
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.bgColor,
        selectedItemColor: colors.blue300,
        unselectedItemColor: colors.cardsInputFields,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: colors.blue300,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: colors.cardsInputFields,
        ),
      ),

      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    
    );
  }
}
