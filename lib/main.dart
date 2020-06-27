import 'dart:io';
import 'package:fakewechat/layouts/run.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fake 微信',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff07c160),
        backgroundColor: Color(0xffededed),
        appBarTheme: AppBarTheme(
          color: Color(0xffededed),
          elevation: 0,
          actionsIconTheme: IconThemeData(
            color: Colors.black
          ),
        ),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Color(0xffededed),
      ),
      routes: {
        "Run":(context)=>Run(),
      },
      initialRoute: 'Run',
    );
  }
}