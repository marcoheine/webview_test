import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_test/screen/common/standardScaffold.dart';
import 'package:webview_test/utils/AppConstant.dart';
import 'package:webview_test/utils/push_notifications.dart';
import 'package:webview_test/utils/globals.dart' as globals;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'webview_test',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF66bc29, myMaterialColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryIconTheme: IconThemeData(color: Colors.white)
      ),
      home: MyHomePage(title: 'webview_test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String title;
  String url;
  bool hideFAB;

  MyHomePage({this.title: '', this.url: '', this.hideFAB = false});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseMessaging _fcm = new FirebaseMessaging();
  InAppWebViewController webView;

  @override
  void initState() {
    super.initState();
    initPushNotification();
  }

  @override
  void dispose() {
    print('!!!!!!!!!!!!!!!');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url == '') {
        widget.url = 'https://marktmonster.de';
    }

    return StandardScaffold(
      InAppWebView(
          initialUrl: widget.url,
          initialHeaders: {},
          initialOptions: InAppWebViewGroupOptions(
              android: AndroidInAppWebViewOptions(
                  allowContentAccess: true,
                  builtInZoomControls: true,
                  thirdPartyCookiesEnabled: true,
                  allowFileAccess: true,
                  supportMultipleWindows: true,
              ),
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
                debuggingEnabled: true,
              )
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            webView = controller;
          },
          androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
            return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
          },
          onLoadStart: (InAppWebViewController controller, String url) {
            setState(() {
              widget.url = url;
            });
          },
          onLoadStop: (InAppWebViewController controller, String url) async {
            setState(() {
              widget.url = url;
            });
          },
          shouldOverrideUrlLoading: (controller, shouldOverrideUrlLoadingRequest) async {
            String action = shouldOverrideUrlLoadingRequest.url.split(':').first;
            List<String> customActions = ['tel', 'whatsapp', 'mailto'];
            bool isCustomAction = customActions.contains(action);

            if (isCustomAction) {
              if (await canLaunch(shouldOverrideUrlLoadingRequest.url)) {
                // Launch the App
                await launch(
                  shouldOverrideUrlLoadingRequest.url,
                );
                // and cancel the request
                return ShouldOverrideUrlLoadingAction.CANCEL;
              }
            }

            return ShouldOverrideUrlLoadingAction.ALLOW;
          },
          onCreateWindow: (controller, createWindowRequest) async {
            String action = createWindowRequest.url
                .split(':')
                .first;
            List<String> customActions = ['tel', 'whatsapp', 'mailto'];
            bool isCustomAction = customActions.contains(action);
            bool isPDF = createWindowRequest.url.contains("/pdf/");

            //if (isCustomAction || isPDF) {
            if (isPDF) {
              createWindowRequest.url = createWindowRequest.url + '&res_q_id=1';
            }
            if (await canLaunch(createWindowRequest.url)) {
              await launch(
                createWindowRequest.url,
              );
            } else {
              print('Could not launch ' + createWindowRequest.url);
            }
            return true;
          }
               ),
      hideFAB: widget.hideFAB,
    );
  }

  void initPushNotification() {
    new PushNotificationsManager();
    PushNotificationsManager().init();
    setupFCMListeners(context);
    if (globals.userID != null && globals.subscribedToNotification == null) {
      _fcm.subscribeToTopic('push_user_' + globals.userID.toString());
      _fcm.subscribeToTopic('push_all_users');
      globals.subscribedToNotification = true;
    }
  }
}
