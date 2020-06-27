import 'package:flutter/material.dart';

class AnimateRouter extends PageRouteBuilder {
  final Widget x;

  AnimateRouter(this.x) :super(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation<double> animation1,
          Animation<double> animation2) {
        return x;
      },

      transitionsBuilder: (BuildContext context,
          Animation<double> animation1,
          Animation<double> animation2,
          Widget child) {
        return
          SlideTransition(
            child: child,
            position: Tween<Offset>(
                begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(
                CurvedAnimation(parent: animation1, curve: Curves.ease)),
          );
      }

  );
}