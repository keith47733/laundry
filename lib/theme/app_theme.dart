// ignore_for_file:prefer_const_constructors,deprecated_member_use

import 'package:flutter/material.dart';

import '../styles/layout.dart';
import '../styles/layout.dart';

final Color color1 = hexToColor('7895B2'); // darkest blue
final Color color2 = hexToColor('AEBDCA'); // medium blue
final Color color3 = hexToColor('E8DFCA'); // light off brown
final Color color4 = hexToColor('F5EFE6'); // light blue

Color hexToColor(String code) {
  return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
}

Color darken(Color baseColor, int percent) {
  // assert(1 <= percent && percent <= 100);
  var f = 1 - percent / 100;
  return Color.fromARGB(
      baseColor.alpha, (baseColor.red * f).round(), (baseColor.green * f).round(), (baseColor.blue * f).round());
}

Color lighten(Color baseColor, int percent) {
  // assert(1 <= percent && percent <= 100);
  var p = percent / 100;
  return Color.fromARGB(baseColor.alpha, baseColor.red + ((255 - baseColor.red) * p).round(),
      baseColor.green + ((255 - baseColor.green) * p).round(), baseColor.blue + ((255 - baseColor.blue) * p).round());
}

ThemeData lightTheme = ThemeData(
  // MISCELLANEOUS
  // applyElevationOverlayColor: false,
  brightness: Brightness.light,
  // fixTextFieldOutlineLabel: true,
  fontFamily: 'InterTight',
  // materialTapTargetSize: MaterialTapTargetSize.padded,
  platform: TargetPlatform.android,
  // splashFactory: InkSplash.splashFactory,
  // typography: Typography.material2021(),
  // useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,

  // COLOR SCHEME
  // Create color scheme for app theme
  // colorScheme: ColorScheme(
  //   brightness: Brightness.light,
  //   background: Colors.white,
  //   error: Colors.white,
  //   onBackground: Colors.white,
  //   onError: Colors.white,
  //   onPrimary: Colors.white,
  //   onSecondary: Colors.white,
  //   onSurface: Colors.white,
  //   primary: Colors.white,
  //   secondary: Colors.white,
  //   surface: Colors.white,
  // ),

  // PRIMARY SWATCH
  // Acts a primary color with shades
  primarySwatch: MaterialColor(
    0xFFAEBDCA, // requires 0xFF plus color hex code
    <int, Color>{
      50: lighten(color2, 90),
      100: lighten(color2, 80),
      200: lighten(color2, 60),
      300: lighten(color2, 40),
      400: lighten(color2, 20),
      500: color2,
      600: darken(color2, 20),
      700: darken(color2, 40),
      800: darken(color2, 60),
      900: darken(color2, 80),
    },
  ),

// CUSTOM COLORS
  // accentColor: Colors.white,
  // backgroundColor: Colors.white,
  // bottomAppBarColor: Colors.white,
  // buttonColor: Colors.white,
  // canvasColor: Colors.white,
  // cardColor: Colors.white,
  // colorSchemeSeed: Colors.white,
  // dialogBackgroundColor: Colors.white,
  disabledColor: Colors.grey[200],
  dividerColor: color2,
  // errorColor: Colors.white,
  // focusColor: Colors.white,
  // highlightColor: Colors.white,
  // hintColor: Colors.white,
  hoverColor: lighten(color2, 30),
  // indicatorColor: Colors.white,
  // primaryColor: Colors.white,
  // primaryColorDark: Colors.white,
  // primaryColorLight: Colors.white,
  scaffoldBackgroundColor: lighten(color4, 80),
  // secondaryHeaderColor: Colors.white,
  // splashColor: Colors.white,
  // toggleableActiveColor: Colors.white,
  // unselectedWidgetColor: Colors.white,

// THEMES FOR PRE-DEFINED FONT TYPES
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(),
    bodySmall: TextStyle(),
    //   bodyText1: TextStyle(),
    //   bodyText2: TextStyle(),
    //   button: TextStyle(),
    //   caption: TextStyle(),
    //   displayLarge: TextStyle(),
    //   displayMedium: TextStyle(),
    //   displaySmall: TextStyle(),
    //   headline1: TextStyle(),
    //   headline2: TextStyle(),
    //   headline3: TextStyle(),
    //   headline4: TextStyle(),
    //   headline5: TextStyle(),
    //   headline6: TextStyle(),
    //   headlineLarge: TextStyle(),
    //   headlineMedium: TextStyle(),
    //   headlineSmall: TextStyle(),
    //   labelLarge: TextStyle(),
    //   labelMedium: TextStyle(),
    //   labelSmall: TextStyle(),
    //   overline: TextStyle(),
    //   subtitle1: TextStyle(),
    //   subtitle2: TextStyle(),
    //   titleLarge: TextStyle(),
    //   titleMedium: TextStyle(),
    //   titleSmall: TextStyle(),
  ),

  // WIDGET THEMES
  // Theme properties override custom colors and text
  // accentColorBrightness: Brightness.light,
  // cupertinoOverrideTheme: NoDefaultCupertinoThemeData(),
  // primaryColorBrightness: Brightness.light,
  // accentIconTheme: IconThemeData(),
  appBarTheme: AppBarTheme(
    elevation: Layout.appElevation,
    backgroundColor: color1,
    foregroundColor: lighten(color4, 80),
  ),
  // bannerTheme: MaterialBannerThemeData(),
  bottomAppBarTheme: BottomAppBarTheme(
    elevation: Layout.appElevation,
    shape: const CircularNotchedRectangle(),
    color: color1,
  ),
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(),
  // bottomSheetTheme: BottomSheetThemeData(),
  // buttonBarTheme: ButtonBarThemeData(),
  // buttonTheme: ButtonThemeData(),
  cardTheme: CardTheme(
    color: lighten(color2, 90),
    elevation: Layout.appElevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Layout.appRadius * 1.5),
    ),
  ),
  // checkboxTheme: CheckboxThemeData(),
  // chipTheme: ChipThemeData(),
  // dataTableTheme: DataTableThemeData(),
  // dialogTheme: DialogTheme(),
  // dividerTheme: DividerThemeData(),
  // drawerTheme: DrawerThemeData(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStatePropertyAll(Layout.appElevation),
      backgroundColor: MaterialStatePropertyAll<Color>(color1),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Layout.appRadius * 2),
        ),
      ),
    ),
  ),
  // expansionTileTheme: ExpansionTileThemeData(),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: color2,
  ),
  iconTheme: IconThemeData(
    color: darken(color1, 40),
  ),
  // inputDecorationTheme: InputDecorationTheme(),
  listTileTheme: ListTileThemeData(
    tileColor: lighten(color2, 75),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Layout.appRadius),
    ),
  ),
  // navigationBarTheme: NavigationBarThemeData(),
  // navigationRailTheme: NavigationRailThemeData(),
  // outlinedButtonTheme: OutlinedButtonThemeData(),
  // pageTransitionsTheme: PageTransitionsTheme(),
  popupMenuTheme: PopupMenuThemeData(
      elevation: Layout.appElevation,
      color: darken(color1, 40),
      enableFeedback: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Layout.appRadius),
      ),
      textStyle: TextStyle(
        color: lighten(color4, 80),
      )),
  // primaryIconTheme: IconThemeData(),
  // progressIndicatorTheme: ProgressIndicatorThemeData(),
  // radioTheme: RadioThemeData(),
  // scrollbarTheme: ScrollbarThemeData(),
  // sliderTheme: SliderThemeData(),
  // snackBarTheme: SnackBarThemeData(),
  // switchTheme: SwitchThemeData(),
  // tabBarTheme: TabBarTheme(),
  // textButtonTheme: TextButtonThemeData(),
  // textSelectionTheme: TextSelectionThemeData(),
  // timePickerTheme: TimePickerThemeData(),
  // toggleButtonsTheme: ToggleButtonsThemeData(),
  // tooltipTheme: TooltipThemeData(),
);
