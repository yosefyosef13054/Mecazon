import 'package:flutter/material.dart';
import 'package:mecazone/style/fonts.dart';

class AppTheme {
  static Color lightBG = const Color(0xFFFFFFFF);
  static String appSemiBoldFont = "AppSemiBold";

  static Map<int, Color> myColor = {
    50: const Color.fromRGBO(17, 112, 217, .1),
    100: const Color.fromRGBO(17, 112, 217, .2),
    200: const Color.fromRGBO(17, 112, 217, .3),
    300: const Color.fromRGBO(17, 112, 217, .4),
    400: const Color.fromRGBO(17, 112, 217, .5),
    500: const Color.fromRGBO(17, 112, 217, .6),
    600: const Color.fromRGBO(17, 112, 217, .7),
    700: const Color.fromRGBO(17, 112, 217, .8),
    800: const Color.fromRGBO(17, 112, 217, .9),
    900: const Color.fromRGBO(17, 112, 217, 1),
  };

  static MaterialColor colorCustom = MaterialColor(0xFF010432, myColor);

  static ThemeData lightTheme = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
        bodyLarge: Fonts.regularLabelTextStyle,
        bodyMedium: Fonts.regularTextStyle,
        bodySmall: Fonts.regularSmallTextStyle,

        headlineLarge: Fonts.editTextLabelStyle,
        headlineMedium: Fonts.editTextFieldStyle,
        headlineSmall: Fonts.editTextHintStyle,
        labelSmall: Fonts.editTextErrorStyle,

        displayLarge: Fonts.cardTitleTextStyle,
        displayMedium: Fonts.cardTextStyle,
        displaySmall: Fonts.cardLabelTextStyle,

        labelLarge:  Fonts.darkTitleTextStyle,
        labelMedium: Fonts.buttonStyle
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColor.appPrimaryColor.withOpacity(.5),
      cursorColor: AppColor.appPrimaryColor.withOpacity(.6),
      selectionHandleColor: AppColor.appPrimaryColor.withOpacity(1),
    ),
    appBarTheme: const AppBarTheme(
        elevation: 0
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColor.appButtonGreyColor,
        selectedItemColor: AppColor.appPrimaryColor,
        unselectedItemColor: AppColor.appBlackColor
    ),
    scaffoldBackgroundColor: AppColor.appWhiteColor,
    primaryColor: AppColor.appPrimaryColor,
    canvasColor: AppColor.appLightOrangeColor,
    unselectedWidgetColor: AppColor.appButtonGreyColor,
    primaryColorDark: AppColor.appPrimaryColor,
    primaryColorLight: AppColor.appBlackColor
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
        bodyLarge: Fonts.regularLabelTextStyle.copyWith(
            color: AppColor.appWhiteColor
        ),
        bodyMedium: Fonts.regularTextStyle.copyWith(
            color: AppColor.appWhiteColor
        ),
        bodySmall: Fonts.regularSmallTextStyle.copyWith(
            color: AppColor.appWhiteColor
        ),

        headlineLarge: Fonts.editTextLabelStyle.copyWith(
            color: AppColor.appWhiteColor
        ),
        headlineMedium: Fonts.editTextFieldStyle.copyWith(
            color: AppColor.appWhiteColor
        ),
        headlineSmall: Fonts.editTextHintStyle.copyWith(
            color: AppColor.appWhiteColor
        ),
        labelSmall: Fonts.editTextErrorStyle.copyWith(
            color: AppColor.appWhiteColor
        ),

        displayLarge: Fonts.cardTitleTextStyle.copyWith(
            color: AppColor.appWhiteColor
        ),
        displayMedium: Fonts.cardTextStyle.copyWith(
            color: AppColor.appWhiteColor
        ),
        displaySmall: Fonts.cardLabelTextStyle.copyWith(
            color: AppColor.appWhiteColor
        ),

        labelLarge:  Fonts.darkTitleTextStyle.copyWith(
            color: AppColor.appWhiteColor
        ),
        labelMedium: Fonts.buttonStyle.copyWith(
            color: AppColor.appBlackColor
        )
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColor.appPrimaryColor.withOpacity(.5),
      cursorColor: AppColor.appPrimaryColor.withOpacity(.6),
      selectionHandleColor: AppColor.appPrimaryColor.withOpacity(1),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.appBlackColor,
      selectedItemColor: AppColor.appPrimaryColor,
      unselectedItemColor: AppColor.appWhiteColor
    ),
    scaffoldBackgroundColor: AppColor.appBlackColor,
    primaryColor: AppColor.appPrimaryColor,
    canvasColor: AppColor.appLightOrangeColor,
    unselectedWidgetColor: AppColor.appBlackColor,
    primaryColorDark: AppColor.appPrimaryColor,
    primaryColorLight: AppColor.appWhiteColor
  );

}

class AppColor {
  static Color appPrimaryColor = const Color(0xFFFF471F);
  static Color appBlackColor = const Color(0xFF0C0C0C);
  static Color appWhiteColor = const Color(0xFFFFFFFF);
  static Color appBg = const Color(0xFFf2f2f2);
  static Color appDividerColor = const Color(0xFFD3D3D3);

  static Color appTextColor = const Color(0xFF0C0C0C);
  static Color appTextLightColor = const Color(0x800c0c0c);
  static Color appLightOrangeColor = const Color(0x0dff471f);

  static Color appFocusBorderColor = const Color(0xFFFF471F);
  static Color appUnFocusBorderColor = const Color(0xFFF3F3F3);

  static Color appRedColor = const Color(0xFFDE4841);
  static Color appGreenColor = const Color(0xFF66BD50);

  static Color appPlaceHolderColor = const Color(0xFFAEAEAE);
  static Color appButtonGreyColor = const Color(0xFFF3F3F3);
  static Color fullyBookedBgColor = const Color(0xFF72191C);
  static Color appLightBlue = const Color(0xFFF3F8FD);
  static Color appMediumBlue = const Color(0xFFAFCFF2);
}
