import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Future push(BuildContext context, Widget page) {
    return Navigator.push(context, CupertinoPageRoute(builder: (_) {
      return page;
    }));
  }

  static Future pushNamed(BuildContext context, String routeName) {
    return Navigator.pushNamed(context, routeName);
  }
}
