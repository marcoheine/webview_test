import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_test/main.dart';
import 'package:webview_test/screen/common/sideMenu.dart';
import 'package:webview_test/utils/AppConstant.dart';
import 'package:webview_test/utils/helper.dart';
import 'package:webview_test/utils/globals.dart' as globals;

class StandardScaffold extends StatefulWidget {
  final Widget content;
  final String topBarTitle;
  final bool hideFAB;

  StandardScaffold(this.content, {this.topBarTitle = 'webview_test', this.hideFAB = false});

  @override
  State<StatefulWidget> createState() {
    return StandardScaffoldState();
  }
}

class StandardScaffoldState extends State<StandardScaffold> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Timer timerOffer;

  @override
  void initState() {
    timerOffer = Timer.periodic(Duration(seconds: 10), (Timer t) => getOffersCount());
    getOffersCount();
    super.initState();
  }

  getOffersCount() async {
    if (globals.offersChanged) {
      globals.offersChanged = false;
      setState(() {
      });
    }
    if (globals.messagesChanged) {
      globals.messagesChanged = false;
      setState(() {
      });
    }
  }

  @override
  void dispose() {
    timerOffer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawerEnableOpenDragGesture: false,
       appBar: AppBar(
        title: GestureDetector(onTap: () {
            callNext(MyHomePage(), context);
        },
            child: Text(widget.topBarTitle, style: TextStyle(color: white))),
        actions: [
          (globals.userID == null) ? SizedBox() : Container(
              margin: EdgeInsets.only(right: 20.0),
              child: InkWell(child: Badge(
                position: BadgePosition.topStart(top: 2.0, start: 10.0),
                showBadge: (globals.newMessagesCount > 0) ? true : false,
                badgeContent: Text(globals.newMessagesCount.toString(), style: TextStyle(color: Colors.white)),
                child: Icon(FontAwesomeIcons.inbox),
              ),
                onTap: () {
                  callNext(MyHomePage(url: "https://marktmonster.de/auto-motorrad-cat1"), context);
                },)
          ),
          Container(
              margin: EdgeInsets.only(right: 14.0),
              child: InkWell(child: Badge(
                position: BadgePosition.topStart(top: 2.0, start: 10.0),
                showBadge: (globals.newOffersCount > 0) ? true : false,
                badgeContent: Text(globals.newOffersCount.toString(), style: TextStyle(color: Colors.white)),
                child: Icon(FontAwesomeIcons.commentsDollar),
              ),
                onTap: () {
                  callNext(MyHomePage(url: "https://marktmonster.de/auto-motorrad-cat1"), context);
                },)
          ),
          Container(
              margin: EdgeInsets.only(right: 14.0),
              child: InkWell(child: Badge(
                position: BadgePosition.topStart(top: 2.0, start: 10.0),
                showBadge: (globals.newOffersCount > 0) ? true : false,
                badgeContent: Text(globals.newOffersCount.toString(), style: TextStyle(color: Colors.white)),
                child: Icon(FontAwesomeIcons.inbox),
              ),
                onTap: () {
                  callNext(MyHomePage(url: "https://marktmonster.de/immobilien-haeuser-cat3"), context);
                },)
          )
        ],
      ),
      body: widget.content, // This
      drawer: SideMenu(),
      drawerScrimColor: white,
    );
  }
}
