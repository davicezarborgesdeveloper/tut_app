import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/font_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/style_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: false,
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager
        .grey1, // will be used in case of disabled button of for example
    // ripple color
    splashColor: ColorManager.primaryOpacity70,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorManager.primary,
      secondary: ColorManager.grey,
    ),
    // card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),
    // App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.primaryOpacity70,
      titleTextStyle:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
    ),
    // Botton theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
    ),
    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white),
        foregroundColor: ColorManager.white,
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    // Text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s16), // headline1
      displayMedium: getRegularStyle(
          color: ColorManager.white, fontSize: FontSize.s16), // headline2
      displaySmall: getBoldStyle(
          color: ColorManager.primary, fontSize: FontSize.s16), // headline3
      headlineMedium: getRegularStyle(
          color: ColorManager.primary, fontSize: FontSize.s14), // headline4
      titleMedium: getMediumStyle(
          color: ColorManager.lightGrey, fontSize: FontSize.s14), // subtitle1
      titleSmall: getMediumStyle(
          color: ColorManager.primary, fontSize: FontSize.s14), //  subtitle2

      bodyMedium: getMediumStyle(color: ColorManager.lightGrey), // bodyText2
      bodySmall: getRegularStyle(color: ColorManager.grey1), // caption

      bodyLarge: getRegularStyle(color: ColorManager.grey), // bodyText1
    ),
    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      // hint style
      hintStyle: getRegularStyle(color: ColorManager.grey1),
      // label style
      labelStyle: getMediumStyle(color: ColorManager.darkGrey),
      // error style
      errorStyle: getRegularStyle(color: ColorManager.error),
      // enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      // focused border
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      // error border
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      // focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
  );
}
