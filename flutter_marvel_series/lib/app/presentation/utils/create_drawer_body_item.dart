import 'package:flutter/material.dart';
// ignore: unused_import

Widget createDrawerBodyItem(
    {String iconName,
    String text,
    double height,
    double width,
    GestureTapCallback onTap}) {
  var start = 'Home';
  return ListTile(
    contentPadding: EdgeInsets.only(
      left: 20,
    ),
    title: Row(
      children: <Widget>[
        Image.asset(
          iconName,
          height: height,
          width: width,
        ),
        Padding(
          padding: EdgeInsets.only(left: text.contains(start) ? 17 : 20.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
