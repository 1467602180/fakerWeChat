import 'dart:io';

import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/layouts/home.dart';
import 'package:fakewechat/layouts/login.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Run extends StatefulWidget {
  @override
  _RunState createState() => _RunState();
}

class _RunState extends State<Run> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initHive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset('assets/images/run/bsc.webp',fit: BoxFit.cover,),
      ),
    );
  }

  void vLogin()async {
    var box = Hive.box('hive');
    bool haveLogin = box.get("haveLogin",defaultValue: false);
    if(haveLogin){
      Navigator.of(context).pushReplacement(AnimateRouter(Home()));
    }else{
      Navigator.of(context).pushReplacement(AnimateRouter(Login()));
    }
  }

  void initHive()async {
    Directory directory = await getApplicationDocumentsDirectory();
    await Hive.init('${directory.path}');
    await Hive.openBox('hive');
    vLogin();
  }
}
