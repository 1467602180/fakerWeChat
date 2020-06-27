import 'dart:io';
import 'dart:typed_data';

import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/config/config.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import 'home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Uint8List imageData = Uint8List(0);

  String username = '';
  String phone = '';
  String password = '';
  bool check = false;
  Box box = Hive.box('hive');

  bool vInfo() {
    if (phone.isNotEmpty &&
        RegexUtil.isMobileSimple(phone) &&
        password.isNotEmpty &&
        check == true &&
        username.isNotEmpty &&
        imageData.isNotEmpty
    ) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  child: Text('手机号注册', style: Config.LoginTitleSize)),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Flexible(
                        child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 63,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  child: Text(
                                    '昵称',
                                    style: Config.TitleTextSize,
                                  ),
                                  margin: EdgeInsets.only(right: 40),
                                ),
                                Flexible(
                                    child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '例如：张三',
                                      hintStyle: Config.HintStyle),
                                  onChanged: (value) {
                                    setState(() {
                                      username = value;
                                    });
                                  },
                                ))
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                          )
                        ],
                      ),
                    )),
                    Container(
                      width: 80,
                      alignment: Alignment.center,
                      child: Container(
                        width: 65,
                        height: 65,
                        child: Visibility(
                          child: GestureDetector(
                              onTap: () {
                                selectImage();
                              },
                              child: Image.memory(
                                imageData,
                                fit: BoxFit.fill,
                              )),
                          visible: imageData.isEmpty ? false : true,
                          replacement: GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: Image.asset(
                              'assets/images/register/select_avatar.webp',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  height: 40,
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          '国家/地区',
                          style: Config.TitleTextSize,
                        ),
                        margin: EdgeInsets.only(right: 24),
                      ),
                      DefaultTextStyle(
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          child: Text(
                            '中国大陆（+86）',
                            style: Config.TitleTextSize,
                          ))
                    ],
                  )),
              Container(
                height: 63,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Text(
                        '手机号',
                        style: Config.TitleTextSize,
                      ),
                      margin: EdgeInsets.only(right: 40),
                    ),
                    Flexible(
                        child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '请填写手机号',
                          hintStyle: Config.HintStyle),
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                    )),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 63,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Text(
                        '密码',
                        style: Config.TitleTextSize,
                      ),
                      margin: EdgeInsets.only(right: 40),
                    ),
                    Flexible(
                        child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '填写密码',
                          hintStyle: Config.HintStyle),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                    ))
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 44,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: check,
                      onChanged: (value) {
                        setState(() {
                          check = value;
                        });
                      },
                      checkColor: Colors.white,
                      activeColor: Theme.of(context).primaryColor,
                    ),
                    Text(
                      '已阅读并同意',
                      style: TextStyle(color: Color(0xffa9a9a9)),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text(
                        '《微信软件许可及服务协议》',
                        style: TextStyle(color: Color(0xff565962)),
                      ),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    )
                  ],
                ),
              ),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: vInfo()
                        ? Theme.of(context).primaryColor
                        : Color(0xffe6e6e6)),
                child: FlatButton(
                  onPressed: () {
                    if(vInfo()){
                      box.put('user', phone);
                      box.put('username', username);
                      box.put('aver', imageData);
                      box.put('haveLogin', true);
                      Navigator.of(context).pushAndRemoveUntil(AnimateRouter(Home()), (route) => false);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      '注册',
                      style: TextStyle(
                          color: vInfo() ? Colors.white : Color(0xffcfcfcf)),
                    ),
                  ),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void selectImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    Uint8List data = await pickedFile.readAsBytes();
    setState(() {
      imageData = data;
    });
  }
}
