import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:async';

class PushNotificationsManager {

  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager
      ._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      //print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }
}

Widget setupFCMListeners(BuildContext context) {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void navigateToItemDetail(String route, String routeId) {
    if (route == 'package') {
      /*
      Future packageData = getPackage(routeId);
      packageData.then((package) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PackageDetails(package),
          ),
        );
      });

       */
    }
  }

  void handlePath(Map<String, dynamic> dataMap) {
    var path = dataMap["route"];
    var id = dataMap["id"];
    if (path == '' || path == null) {
      path = dataMap["data"]["route"];
    }
    if (id == '' || id == null) {
      id = dataMap["data"]["id"];
    }
    return navigateToItemDetail(path, id);
  }

  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("Message: $message"); // Not handling path since on notification in app it can be weird to open a new page randomly.
      handlePath(message);
    },
    onLaunch: (Map<String, dynamic> message) async {
      //print("Message: $message");
      handlePath(message);
    },
    onResume: (Map<String, dynamic> message) async {
      //print("Message: $message");
      handlePath(message);
    },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler

  );
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  print("Message: $message");
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print(notification);
  }

  // Or do other work.
}


