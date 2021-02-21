import 'package:flutter/material.dart';
import 'package:webview_test/utils/AppConstant.dart';
import 'package:webview_test/utils/helper.dart';


Padding editTextStyle(var hintText, saveVariable, {required = false, isPassword = false, saveToGlobals = true, controller, maxLines = 1,
  Function onchange, initialValue, keyboardType, maxLength, padding = const EdgeInsets.fromLTRB(8, 0, 8, 0), fillColor = edit_background, contentPadding = const EdgeInsets.fromLTRB(12, 14, 12, 14), showLabel = false, readOnly = false}) {
  return Padding(
      padding: padding,
      child: TextFormField(
        initialValue: initialValue,
        maxLength: maxLength,
        readOnly: readOnly,
        keyboardType: keyboardType,
        style:
        TextStyle(fontSize: textSizeSMedium, fontFamily: fontRegular),
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          hintText: hintText,
          filled: true,
          fillColor: fillColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: edit_background, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: edit_background, width: 0.0),
          ),
          labelText: (showLabel) ? hintText : '',
          floatingLabelBehavior:FloatingLabelBehavior.always,
        ),
        maxLines: maxLines,
        validator: (String value) {
          if (value.isEmpty && required == true) {
            return 'bitte ausfüllen!';
          }
          return null;
        },
        onSaved: (String value) {

        },
        onChanged: (String value) {
          if (onchange != null) {
              onchange(value);
          }
        },
        controller: controller,
      ));
}

class AppButton extends StatefulWidget {
  AppButton({this.textContent, this.onPressed, this.buttonColor, this.textColor, this.fontSize, this.badge, this.icon});
  final textContent;
  final VoidCallback onPressed;
  var buttonColor = colorPrimary;
  var textColor = white;
  var fontSize = 18.0;

  final int badge;
  final icon;

  @override
  State<StatefulWidget> createState() {
    return AppButtonState();
  }
}

class AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.fontSize == null) {
      widget.fontSize = 18.0;
    }
    return Stack(
        children: [
        RaisedButton(
        onPressed: widget.onPressed,
        textColor: white,
        //elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: BoxDecoration(
            color: widget.buttonColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (widget.icon != null) ? Icon(widget.icon, color: widget.textColor) : SizedBox(),
                    (widget.icon != null) ? SizedBox(width: 6) : SizedBox(),
                    Text(
                      widget.textContent,
                      style: TextStyle(fontSize: widget.fontSize, color: widget.textColor),
                      textAlign: TextAlign.center,
                    ),
                  ]
              )
            ),
          ),
        ),
        ),
          (widget.badge != null && widget.badge > 0) ? new Positioned(
            right: -12,
            top: -12,
            child: new Container(
              padding: EdgeInsets.all(2),
              decoration: new BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              constraints: BoxConstraints(
                minWidth: 30,
                minHeight: 30,
              ),
              child: Center(child: Text(
                widget.badge.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              )),
            ),
          ) : SizedBox(),
        ]);
  }
}

Widget text(var text,
    {var fontSize = textSizeLargeMedium,
      textColor = textColorSecondary,
      var fontFamily = fontRegular,
      var isCentered = false,
      var maxLine = 1,
      var latterSpacing = 0.2,
      var decoration = TextDecoration.none,
      var islongTxt = false,
      var lineHeight = 1.5,
      var fontWeight = FontWeight.w400}) {
  return Text(text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: islongTxt ? null : maxLine,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor,
          height: lineHeight,
          decoration: decoration,
          letterSpacing: latterSpacing,
          fontWeight: fontWeight));
}

BoxDecoration boxDecoration({double radius = 2, Color color = Colors.transparent, Color bgColor = white, var showShadow = false}) {
  return BoxDecoration(
      color: bgColor,
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      boxShadow: showShadow ? [BoxShadow(color: grey, blurRadius: 10, spreadRadius: 2)] : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}

Widget standardPadding(child) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: child
  );
}

BoxDecoration myBoxDecoration({color1: colorPrimary, color2: colorPrimary}) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment(1.0, 0.0),
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(borderRadius) //                 <--- border radius here
    ),
  );
}

Widget myButton({textColor: Colors.white, color: colorPrimary, onPressed, icon, textContent: "", fontSize: textSizeLargeMedium}) {
  return RaisedButton.icon(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    textColor: Colors.white,
    color: colorPrimary,
    onPressed: () {
      onPressed();
    },
    icon: (icon != null) ? Icon(icon, size: textSizeLargeMedium) : SizedBox(),
    label: Expanded(child: Center(child: Text(textContent, overflow: TextOverflow.ellipsis,  maxLines: 1, style: TextStyle(fontSize: fontSize)))),
  );
}

Widget myCard({textContent, image, size, goTo, context, badge: 0, parent}) {
  return InkWell(
      onTap: () {
        callNext(goTo, context).then((value) {
          if (value) {
            parent.onRefresh();
          }
        });
      },
      child: Stack(
          children: [
            Container(
  width: size.width,
  child: Card(
    elevation: 1.0,
    color: colorPrimary,
    margin: EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(14.0), child:  ConstrainedBox(
      constraints: new BoxConstraints(
        maxHeight: size.height / 6,
        maxWidth: size.width - 32,
      ),
      child: Image.asset('assets/icon/' + image))),
        Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: colorPrimary, width: 4),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(borderRadius), bottomRight: Radius.circular(borderRadius)),
              color: colorPrimary,
            ),
            width: size.width,
          child: Center(child: Text(textContent, style: TextStyle(fontSize: textSizeNormal, color: Colors.white)))),
      ],
    ),
  )
  ),
            (badge != null && badge > 0) ? new Positioned(
              right: -10,
              top: -10,
              child: new Container(
                padding: EdgeInsets.all(2),
                decoration: new BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                constraints: BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
                child: Center(child: Text(
                  badge.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                )),
              ),
            ) : SizedBox(),
          ],
      )
  );
}
