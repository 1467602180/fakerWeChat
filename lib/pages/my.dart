import 'dart:typed_data';

import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/layouts/login.dart';
import 'package:fakewechat/layouts/userinfo.dart';
import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class My extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  Box box = Hive.box('hive');
  String username = '';
  String imageData = '';
  String user = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [IconButton(icon: Icon(Icons.camera_alt), onPressed: () {})],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8),
              height: 110,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Container(
                height: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 85,
                      alignment: Alignment.center,
                      child: Container(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child: imageData.isEmpty
                              ? Image.asset(
                                  'assets/images/my/def_avatar.png',
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  imageData,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                    Flexible(
                        child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(AnimateRouter(UserInfo()))
                                  .then((value) => getData());
                            },
                            child: Container(
                              height: 25,
//                              color: Colors.red,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                      child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      '微信号：${user}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff898989)),
                                    ),
                                  )),
                                  Image.asset(
                                    'assets/images/my/qr.png',
                                    scale: 5,
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Color(0xffb2b2b2),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 48,
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 65,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(4),
                      child: Image.asset(
                        'assets/images/my/ic_pay.png',
                        scale: 7,
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    '支付',
                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  width: double.infinity,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
//                margin: EdgeInsets.only(bottom: 8),
                height: 48,
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 65,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(4),
                      child: Image.asset(
                        'assets/images/my/aay.png',
                        scale: 7,
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    '收藏',
                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  width: double.infinity,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
//                margin: EdgeInsets.only(bottom: 8),
                height: 48,
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 65,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(4),
                      child: Image.asset(
                        'assets/images/my/photo.png',
                        scale: 4,
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    '相册',
                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  width: double.infinity,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
//                margin: EdgeInsets.only(bottom: 8),
                height: 48,
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 65,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(4),
                      child: Image.asset(
                        'assets/images/my/card.png',
                        scale: 4,
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    '卡包',
                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  width: double.infinity,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 48,
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 65,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(4),
                      child: Image.asset(
                        'assets/images/my/face.png',
                        scale: 4,
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    '表情',
                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  width: double.infinity,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                box.put('haveLogin', false);
                SqliteTool().deleteBase();
                Navigator.of(context).pushReplacement(AnimateRouter(Login()));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 48,
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 65,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(4),
                      child: Image.asset(
                        'assets/images/my/ic_setting.png',
                        scale: 8,
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    '设置',
                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  width: double.infinity,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getData() async {

    List<Map> list = await SqliteTool().getUserInfo();
    setState(() {
      username = list[0]['username'];
      user = list[0]['user'];
      imageData = list[0]['aver'];
    });
  }
}
