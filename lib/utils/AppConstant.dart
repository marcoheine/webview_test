import 'dart:ui';
import 'package:flutter/material.dart';

/*fonts*/
const mainAppName = 'heine_digital';
const fontRegular = 'Regular';
const fontMedium = 'Medium';
const fontSemibold = 'Semibold';
const fontBold = 'Bold';
/* font sizes*/
const textSizeSmall = 12.0;
const textSizeSMedium = 14.0;
const textSizeMedium = 16.0;
const textSizeLargeMedium = 18.0;
const textSizeNormal = 20.0;
const textSizeLarge = 24.0;
const textSizeXLarge = 30.0;
const borderRadius = 5.0;

/// Linux - for linux, you have to change default window width in linux/my_application.cc
const applicationMaxWidth = 500.0;

const colorPrimary = Color(0xff66bc29);
const colorSecondary = Color(0xff3665f3);

Map<int, Color> myMaterialColor =
{
  50:Color.fromRGBO(102, 188, 41, .1),
  100:Color.fromRGBO(102, 188, 41, .2),
  200:Color.fromRGBO(102, 188, 41, .3),
  300:Color.fromRGBO(102, 188, 41, .4),
  400:Color.fromRGBO(102, 188, 41, .5),
  500:Color.fromRGBO(102, 188, 41, .6),
  600:Color.fromRGBO(102, 188, 41, .7),
  700:Color.fromRGBO(102, 188, 41, .8),
  800:Color.fromRGBO(102, 188, 41, .9),
  900:Color.fromRGBO(102, 188, 41, 1),
};

const white = Color(0XFFffffff);
const edit_background = Color(0XFFF5F4F4);
const textColorSecondary = Color(0XFF808293);
const grey = Color(0XFFDADADA);
const background = Color(0XFFf8f8f8);