import 'package:flutter/material.dart';

class MyTheme {

  static ThemeData lightTheme(BuildContext context) =>
      ThemeData(primarySwatch: Colors.amber,
          //to change the font for overall app do it from here

          cardColor: Colors.white,
          canvasColor: lightcream,
          buttonColor: lightbluishcolor,
          appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
              textTheme: Theme
                  .of(context)
                  .textTheme
          )
      );

  static ThemeData darkTheme(BuildContext context) =>
      ThemeData(
          brightness: Brightness.dark,
          cardColor: Colors.black,
          buttonColor: primaryColor,
          appBarTheme: AppBarTheme(
              color: Colors.black,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.white),
              textTheme: Theme
                  .of(context)
                  .textTheme
          )

      );

  static Color lightcream = Color(0xfff5f5f5);
  static Color darkbluishcolor = Color(0xff0c0c0c);
  static Color lightbluishcolor = Color(0xffe01159);
  static Color primaryColor = Color(0xFF53F9FF);
  static Color redColor = Color(0xFFFF5368);

}