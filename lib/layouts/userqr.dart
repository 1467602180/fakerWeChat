import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserQR extends StatefulWidget {
  @override
  _UserQRState createState() => _UserQRState();
}

class _UserQRState extends State<UserQR> {
  Box box = Hive.box('hive');
  String username = '';
  Uint8List imageData = Uint8List(0);
  String address = faker.address.city();
  bool gender = Random().nextBool();
  GlobalKey globalKey = GlobalKey();
  double height = 0;
  List<String> qrList = [
    'assets/images/qr/1.png',
    'assets/images/qr/2.png',
    'assets/images/qr/3.png',
    'assets/images/qr/4.png',
    'assets/images/qr/5.png',
    'assets/images/qr/6.png',
  ];

  String get qrAssest => qrList[Random().nextInt(5)];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    Timer(Duration(milliseconds: 300), () {
      setState(() {
        height = globalKey.currentContext.size.width;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          '二维码名片',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10))),
                            child: Text(
                              '换个样式',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {
                              qrAssest;
                            });
                          },
                        ),
                        Divider(
                          height: 0.5,
                          color: Color(0xfff1f1f1),
                        ),
                        GestureDetector(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                            ),
                            child: Text(
                              '保存到手机',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            alignment: Alignment.center,
                          ),
                          onTap: () {},
                        ),
                        Divider(
                          height: 0.5,
                          color: Color(0xfff1f1f1),
                        ),
                        GestureDetector(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Text(
                              '扫描二维码',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            alignment: Alignment.center,
                          ),
                          onTap: () {},
                        ),
                        Divider(
                          height: 0.5,
                          color: Color(0xfff1f1f1),
                        ),
                        GestureDetector(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Text(
                              '重置二维码',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            alignment: Alignment.center,
                          ),
                          onTap: () {},
                        ),
                        Divider(
                          height: 0.5,
                          color: Color(0xfff1f1f1),
                        ),
                        Container(height: 10,color: Color(0xfff6f6f6),),
                        GestureDetector(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Text(
                              '取消',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                  backgroundColor: Colors.transparent,
                );
              }),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          height: 460,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white),
          padding: EdgeInsets.all(16),
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 70,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            child: imageData.isEmpty
                                ? Image.asset(
                                    'assets/images/my/def_avatar.png',
                                    fit: BoxFit.fill,
                                  )
                                : Image.memory(
                                    imageData,
                                    fit: BoxFit.fill,
                                  )),
                        margin: EdgeInsets.only(right: 8),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                username,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Container(
                            height: 8,
                          ),
                          Text(
                            address,
                            style: TextStyle(
                                color: Color(0xffa8a8a8), fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  key: globalKey,
                  height: height,
                  child: Image.asset(
                    qrAssest,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width - 82,
                    height: MediaQuery.of(context).size.width - 82,
                  ),
                ),
                Flexible(
                    child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '扫一扫上面的二维码图案，加我微信',
                    style: TextStyle(color: Color(0xffb1b1b1), fontSize: 14),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getData() {
    setState(() {
      username = box.get('username');
      imageData = box.get('aver', defaultValue: Uint8List(0));
    });
  }
}
