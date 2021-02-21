import 'package:webview_test/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_test/utils/AppConstant.dart';
import 'package:webview_test/utils/helper.dart';
import 'package:webview_test/utils/widgets.dart';
import 'package:webview_test/utils/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class SideMenu extends StatefulWidget {
  static var tag = "/SideMenu";

  @override
  State<StatefulWidget> createState() {
    return SideMenuState();
  }
}

class SideMenuState extends State<SideMenu> {
  Widget menuItem(String name, {nextClass, url, icon: FontAwesomeIcons.home}) {
    return GestureDetector(
      onTap: () async {
        if (nextClass != null) {
          callNext(nextClass, context);
        } else {
          await launch(url);
        }
      },
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0,
                ),
              ),
            ),
        child: Column(
      children: <Widget>[
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(icon: FaIcon(icon, color: colorPrimary), padding: EdgeInsets.all(0.0), onPressed: () {},),
            text(name, textColor: colorPrimary, fontFamily: fontMedium),
          ],
        ),
        SizedBox(height: 2),
        Divider(
          height: 0.5,
          color: colorPrimary,
        )
      ],
    )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
        child: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height + 100,
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 8),
                menuItem('Startseite',  nextClass: MyApp(), icon: FontAwesomeIcons.home),
               Expanded(
                  child:
                  GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                    margin: EdgeInsets.only(top: 50),
                    child: text('Logout',
                        textColor: CupertinoColors.systemRed,
                        fontFamily: fontSemibold,
                        fontSize: textSizeNormal),
                  )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    )
    );
  }
}
