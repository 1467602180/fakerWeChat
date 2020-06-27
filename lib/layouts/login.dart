import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/layouts/login_step.dart';
import 'package:fakewechat/layouts/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/run/bsc.webp',
              fit: BoxFit.cover,
            )),
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(8),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(AnimateRouter(LoginStep()));
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Text(
                      '登录',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(AnimateRouter(Register()));
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Text(
                      '注册',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ))
            ],
          ),
        )
      ],
    ));
  }
}
