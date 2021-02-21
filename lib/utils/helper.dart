import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future callNext(var className, var context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => className),
  );
}

back(var context) {
  Navigator.pop(context, true);
}

void putShared(String key, bool val) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, val);
}

Future getShared(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool val = prefs.getBool(key) == null ? false : (prefs.getBool(key));
  return val;
}

formatDateToGermanString(date, {format: 'dd.MM.yyyy'}) {
  DateTime parsedDate = DateTime.parse(date);
  final DateFormat formatter = DateFormat(format);
  String formatted = formatter.format(parsedDate);
  formatted = formatted.replaceAll('Monday', "Montag").replaceAll('Tuesday', "Dienstag").replaceAll('Wednesday', "Mittwoch").replaceAll('Thursday', "Donnerstag").replaceAll('Friday', "Freitag").replaceAll('Saturday', "Samstag").replaceAll('Sunday', "Sonntag");
  return formatted;
}

getDifferenceTwoTimestamps(DateTime timestamp1, DateTime timestamp2) {
    return timestamp2.difference(timestamp1).inSeconds;
}

Future checkForConnection() async {
  try {
    final result = await InternetAddress.lookup('webview_test.de');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
}