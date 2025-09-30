import 'package:flutter/material.dart';

class ZAppBarTheme {
  ZAppBarTheme._();

  static const AppBarTheme lightAppBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    iconTheme: IconThemeData(color: Colors.black , size: 24),
    actionsIconTheme: IconThemeData(color: Colors.black , size: 24),
    titleTextStyle: TextStyle(
        color: Colors.black ,
        fontSize: 18 ,
        fontWeight: FontWeight.w600
    ),
  );



  static const AppBarTheme darkAppBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    iconTheme: IconThemeData(color: Colors.white , size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white , size: 24),
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18 ,
        fontWeight: FontWeight.w600
    ),
  );

}



