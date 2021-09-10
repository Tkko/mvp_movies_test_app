import 'package:mvp_movies/app/app.dart';

/// Dark Theme Colors
const kDM_BG_COLOR = const Color.fromRGBO(0, 0, 0, 1);
const kDM_BG_COLOR_SECONDARY = const Color.fromRGBO(17, 18, 25, 1);
const kDM_ACCENT_COLOR = const Color.fromRGBO(97, 117, 255, 1);
const kDM_TEXT_PRIMARY = const Color.fromRGBO(255, 255, 255, 1);
const kDM_TEXT_SECONDARY = const Color.fromRGBO(255, 255, 255, .6);

/// Fonts
const kFONT_GILROY = 'Gilroy';

extension ThemeExt on ThemeData {
  TextStyle get h3 => this.textTheme.bodyText1.copyWith(
        fontFamily: kFONT_GILROY,
        fontSize: 20,
        height: 1.4,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.15,
      );

  TextStyle get h3Primary => this.h3.copyWith(color: kDM_TEXT_PRIMARY);

  TextStyle get h3Indicator => this.h3.copyWith(color: this.indicatorColor);

  TextStyle get h4 => this.textTheme.bodyText1.copyWith(
        fontFamily: kFONT_GILROY,
        fontSize: 16,
        height: 1.4,
        fontWeight: FontWeight.bold,
        letterSpacing: 0,
      );

  TextStyle get h5Secondary => this.h4.copyWith(
        color: kDM_TEXT_PRIMARY,
        fontWeight: FontWeight.w700,
      );

  TextStyle get hint => this.textTheme.bodyText1.copyWith(
        fontFamily: kFONT_GILROY,
        fontSize: 36,
        fontWeight: FontWeight.bold,
        letterSpacing: 0,
      );

  TextStyle get h5 => this.textTheme.bodyText1.copyWith(
        fontFamily: kFONT_GILROY,
        fontSize: 14,
        height: 1.4,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.15,
      );
}

class AppThemes {
  ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: kDM_BG_COLOR,
        backgroundColor: kDM_BG_COLOR_SECONDARY,
        primaryColor: kDM_BG_COLOR,
        primaryColorLight: kDM_TEXT_PRIMARY,
        accentColor: kDM_ACCENT_COLOR,
        cardColor: kDM_BG_COLOR_SECONDARY,
        canvasColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          backgroundColor: kDM_BG_COLOR,
          elevation: 0,
          iconTheme: IconThemeData(
            color: kDM_TEXT_PRIMARY,
          ),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: kDM_TEXT_PRIMARY,
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
          headline5: TextStyle(
            color: kDM_TEXT_PRIMARY,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
          subtitle1: TextStyle(
            color: kDM_TEXT_SECONDARY,
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          subtitle2: TextStyle(
            color: kDM_TEXT_PRIMARY,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          bodyText1: TextStyle(
            color: kDM_TEXT_PRIMARY,
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          bodyText2: TextStyle(
            color: kDM_TEXT_SECONDARY,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          caption: TextStyle(
            color: kDM_TEXT_SECONDARY,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
          button: TextStyle(
            color: kDM_TEXT_PRIMARY,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      );
}
