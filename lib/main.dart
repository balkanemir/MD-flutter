import 'package:flutter/material.dart';
import 'ui/home.dart';
//void main() => runApp(ScaffoldExample());

final ThemeData _appTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
    brightness:  Brightness.dark,
    accentColor: Colors.amber,
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.red,
    backgroundColor: Colors.amber,
    textTheme: _appTextTheme(base.textTheme)
  ) ;
}

TextTheme _appTextTheme(TextTheme base) {
  return base.copyWith(
    headline1: base.headline1?.copyWith(
      fontWeight: FontWeight.w500,
    ),

    subtitle1: base.subtitle1?.copyWith(
      fontSize: 18.0
    ),

    caption: base.caption?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0
    ),

    button: base.button?.copyWith(
      //fontSize: 23.9,
    ),

    bodyText2: base.bodyText2?.copyWith(
       fontSize: 16.9,
        color: Colors.white
    )
  );
}

void main() => runApp(new MaterialApp(
  theme: _appTheme,
  //theme:ThemeData(
  //   brightness: Brightness.dark,
  //   primaryColor: Colors.grey[800],

  //   textTheme: TextTheme(
  //     headline1: TextStyle(
  //       fontSize: 34,
  //       fontWeight: FontWeight.bold
  //     ),
  //     bodyText2: TextStyle(
  //       fontSize: 16.9,
  //       color: Colors.white
  //     )
  //   )
  // ),
  home: QuizApp()
));


