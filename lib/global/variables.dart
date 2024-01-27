import 'package:flutter/material.dart';

double? bottomNavBardHeight;

getAppBarHeight(BuildContext context) {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    bottomNavBardHeight = 92;
  } else {
    bottomNavBardHeight = 60;
  }
}
