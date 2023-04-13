import 'package:flutter/material.dart';
import 'package:witnet_wallet/screens/screen_transitions/no_transitions_builder.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'colors.dart';

Brightness brightness = Brightness.light;
MaterialColor primarySwatch = createMaterialColor(WitnetPallet.witnetGreen2);
Color primaryColor = WitnetPallet.witnetGreen2;
TextSelectionThemeData textSelectionTheme =
    TextSelectionThemeData(cursorColor: WitnetPallet.witnetGreen2);
Brightness primaryColorBrightness = brightness;
TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(
      fontFamily: 'NotoSans',
      color: WitnetPallet.darkGrey,
      fontSize: 24,
      fontWeight: FontWeight.bold),
  displayMedium: TextStyle(
      fontFamily: 'NotoSans',
      color: WitnetPallet.darkGrey,
      fontSize: 18,
      fontWeight: FontWeight.bold),
  displaySmall: TextStyle(
      fontFamily: 'NotoSans',
      color: WitnetPallet.darkGrey,
      fontSize: 16,
      fontWeight: FontWeight.bold),
  headlineMedium: TextStyle(
      fontFamily: 'NotoSans',
      color: WitnetPallet.witnetGreen1,
      fontSize: 24,
      fontWeight: FontWeight.normal),
  headlineSmall: TextStyle(
      fontFamily: 'NotoSans',
      color: WitnetPallet.witnetGreen1,
      fontSize: 16,
      fontWeight: FontWeight.normal),
  titleMedium: TextStyle(
      fontFamily: 'NotoSans',
      color: WitnetPallet.darkGrey,
      fontSize: 16,
      fontWeight: FontWeight.normal),
  titleSmall: TextStyle(
      fontFamily: 'NotoSans',
      color: WitnetPallet.darkGrey,
      fontSize: 14,
      fontWeight: FontWeight.bold),
  bodyLarge: TextStyle(
      fontFamily: 'NotoSans',
      color: WitnetPallet.darkGrey,
      fontSize: 16,
      fontWeight: FontWeight.normal),
  bodyMedium: TextStyle(
      fontFamily: 'NotoSans',
      color: WitnetPallet.darkGrey,
      fontSize: 14,
      fontWeight: FontWeight.normal),
  bodySmall: TextStyle(
      fontFamily: 'NotoSans',
      color: WitnetPallet.darkGrey,
      fontSize: 12,
      fontWeight: FontWeight.normal),
  labelLarge: TextStyle(
      fontFamily: 'NotoSans',
      color: WitnetPallet.white,
      fontSize: 16,
      fontWeight: FontWeight.normal),
  labelMedium: TextStyle(
      fontFamily: 'NotoSans',
      color: WitnetPallet.witnetGreen1,
      fontSize: 16,
      fontWeight: FontWeight.normal),
);
InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  fillColor: WitnetPallet.white,
  filled: true,
  errorStyle: TextStyle(color: WitnetPallet.darkRed),
  helperStyle: TextStyle(color: WitnetPallet.darkGrey),
  helperMaxLines: 1,
  errorMaxLines: 1,
  hintStyle: TextStyle(),
  hoverColor: WitnetPallet.white,
  focusColor: WitnetPallet.witnetGreen2,
  isDense: false,
  isCollapsed: false,
  contentPadding: EdgeInsets.all(16),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
        color: WitnetPallet.lightGrey, width: 1.0, style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(4),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
        color: WitnetPallet.witnetGreen2, width: 1.0, style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(4),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
        color: WitnetPallet.darkRed, width: 1.0, style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(4),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(
        color: WitnetPallet.white, width: 1.0, style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(4),
  ),
  alignLabelWithHint: true,
);
CardTheme cardTheme = CardTheme(
  elevation: 5.0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
  color: WitnetPallet.darkBlue2,
);
ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(16),
      backgroundColor: WitnetPallet.darkBlue2,
      disabledForegroundColor: Color.fromARGB(114, 2, 29, 48).withOpacity(0.38),
      disabledBackgroundColor: Color.fromARGB(114, 2, 29, 48).withOpacity(0.12),
      foregroundColor: WitnetPallet.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)), // background color
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: WitnetPallet.white,
      )),
);
TextButtonThemeData textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: WitnetPallet.witnetGreen1,
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: WitnetPallet.witnetGreen1,
    ),
  ),
);
OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
  foregroundColor: WitnetPallet.darkBlue2,
  disabledForegroundColor: Color.fromARGB(114, 2, 29, 48).withOpacity(0.38),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  side: BorderSide(width: 1, color: WitnetPallet.darkBlue2),
  padding: const EdgeInsets.all(16),
  textStyle: const TextStyle(
    fontSize: 16,
    color: WitnetPallet.darkBlue2,
  ),
));
IconThemeData iconTheme = IconThemeData(
  color: WitnetPallet.witnetGreen1,
  size: 16,
);
IconThemeData primaryIconTheme = IconThemeData(
  color: WitnetPallet.witnetGreen2,
  size: 24,
);
CheckboxThemeData checkboxTheme = CheckboxThemeData(
  splashRadius: 0,
  side: MaterialStateBorderSide.resolveWith(
      (_) => const BorderSide(width: 2, color: WitnetPallet.witnetGreen2)),
  fillColor: MaterialStateProperty.all(WitnetPallet.witnetGreen2),
  checkColor: MaterialStateProperty.all(WitnetPallet.white),
  overlayColor: MaterialStateProperty.all(WitnetPallet.white),
);

Color getColorPrimary(Set<MaterialState> states) {
  const Set<MaterialState> activeStates = <MaterialState>{
    MaterialState.selected
  };
  if (states.any(activeStates.contains)) {
    return WitnetPallet.witnetGreen1;
  }
  return Color.fromARGB(126, 193, 196, 198);
}

Color getColorSecondary(Set<MaterialState> states) {
  const Set<MaterialState> activeStates = <MaterialState>{
    MaterialState.selected
  };
  if (states.any(activeStates.contains)) {
    return WitnetPallet.opacityWitnetGreen;
  }
  return WitnetPallet.lightGrey;
}

SwitchThemeData switchTheme = SwitchThemeData(
  thumbColor: MaterialStateProperty.resolveWith(getColorPrimary),
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  trackColor: MaterialStateProperty.resolveWith(getColorSecondary),
  splashRadius: 1,
);

PageTransitionsTheme pageTransitionsTheme = PageTransitionsTheme(
  builders: kIsWeb
      ? {
          // No animations for every OS if the app running on the web
          for (final platform in TargetPlatform.values)
            platform: const NoTransitionsBuilder(),
        }
      : const {
          // handel other platforms you are targeting
        },
);

ThemeData lightTheme = ThemeData(
    pageTransitionsTheme: pageTransitionsTheme,
    primaryColor: primaryColor,
    switchTheme: switchTheme,
    checkboxTheme: checkboxTheme,
    splashColor: Colors.transparent,
    iconTheme: iconTheme,
    primaryIconTheme: primaryIconTheme,
    textSelectionTheme: textSelectionTheme,
    shadowColor: Colors.transparent,
    elevatedButtonTheme: elevatedButtonTheme,
    textButtonTheme: textButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    cardTheme: cardTheme,
    textTheme: textTheme,
    inputDecorationTheme: inputDecorationTheme,
    colorScheme: ColorScheme.light().copyWith(background: WitnetPallet.white));
