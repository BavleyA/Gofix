import 'package:flutter/material.dart';

class DeviceUtils {

  DeviceUtils._();

  static double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  static double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  static bool isPortrait(BuildContext context) => MediaQuery.of(context).orientation == Orientation.portrait;

  static bool isLandscape(BuildContext context) => MediaQuery.of(context).orientation == Orientation.landscape;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.shortestSide >= 600;
}
