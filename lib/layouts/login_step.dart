import 'dart:convert';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/config/config.dart';
import 'package:fakewechat/layouts/home.dart';
import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class LoginStep extends StatefulWidget {
  @override
  _LoginStepState createState() => _LoginStepState();
}

class _LoginStepState extends State<LoginStep> {

  Box box = Hive.box('hive');
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      height: 60,
                      child: Text('手机号登录', style: Config.LoginTitleSize)),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 8),
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
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              child: Text(
                                '中国大陆（+86）',
                                style: Config.TitleTextSize,
                              ))
                        ],
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      height: 40,
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              '手机号',
                              style: Config.TitleTextSize,
                            ),
                            margin: EdgeInsets.only(right: 42),
                            height: 40,
                            alignment: Alignment.centerLeft,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '请填写手机号'
                              ),
                              autofocus: true,
                              keyboardType: TextInputType.phone,
                              onChanged: (value){
                                setState(() {
                                  phone = value;
                                });
                              },
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            Divider(
              height: 4,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    '用微信号/QQ号/邮箱登录',
                    style: TextStyle(color: Color(0xff585a67)),
                  )),
              alignment: Alignment.centerLeft,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: FlatButton(
                onPressed: () {
                  if(phone.isNotEmpty&&RegexUtil.isMobileSimple(phone)){
                    box.put('haveLogin', true);
                    box.put('user', phone);
                    box.put('username', faker.person.name());
                    FakeAddress();
                    Navigator.of(context).pushAndRemoveUntil(AnimateRouter(Home()), (route) => false);
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: phone.isEmpty?Color(0xffe6e6e6):RegexUtil.isMobileSimple(phone)?Theme.of(context).primaryColor:Color(0xffe6e6e6),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  alignment: Alignment.center,
                  child: Text(
                    '下一步',
                    style: TextStyle(color: phone.isEmpty?Color(0xffcfcfcf):RegexUtil.isMobileSimple(phone)?Colors.white:Color(0xffcfcfcf)),
                  ),
                ),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
            ),
            Flexible(
                child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(8),
              child: Container(
                height: 35,
                child: ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FlatButton(
                        onPressed: () {},
                        child: Text(
                          '找回密码',
                          style: TextStyle(color: Color(0xff585a67)),
                        )),
                    VerticalDivider(
                      width: 1,
                    ),
                    FlatButton(
                        onPressed: () {},
                        child: Text(
                          '紧急冻结',
                          style: TextStyle(color: Color(0xff585a67)),
                        )),
                    VerticalDivider(
                      width: 1,
                    ),
                    FlatButton(
                        onPressed: () {},
                        child: Text(
                          '微信安全中心',
                          style: TextStyle(color: Color(0xff585a67)),
                        )),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void FakeAddress() async{
    List list = [];
    Map data = json.decode(await rootBundle.loadString("assets/json/address.json"));
    List<int> indexList = [];
    for(var i=0;i<20;i++){
      int index = Random().nextInt(1000);
      indexList.add(index);
    }
    Set set = Set.from(indexList);
    List initList = [];
    for(var i in set){
      initList.add(data['data'][i]);
    }
    List surnameList = [];
    for(var i in initList){
      surnameList.add(i['surname']);
    }
    surnameList.sort();
    Set surnameSet = Set.from(surnameList);
    for(var i in surnameSet){
      Map dataMap = {};
      List dataList = [];
      for(var j in initList){
        if(i==j['surname']){
          dataList.add(j);
        }
      }
      dataMap[i] = dataList;
      list.add(dataMap);
    }
    box.put('address', list);
    Map contentData = json.decode(await rootBundle.loadString('assets/json/content.json'));
    Map imagesData = json.decode(await rootBundle.loadString('assets/json/images.json'));
    List friendsCircle = [];
    for(var i=0;i<20;i++){
      Map friendsCircleData = {};
      List friendsCircleImages = [];
      int userIndex = Random().nextInt(initList.length);
      friendsCircleData['user'] = initList[userIndex]['username'];
      friendsCircleData['aver'] = initList[userIndex]['aver'];
      friendsCircleData['content'] = contentData['data'][Random().nextInt(contentData['data'].length)];
      for(var j=0;j<Random().nextInt(9);j++){
        friendsCircleImages.add(imagesData['data'][Random().nextInt(imagesData['data'].length)]);
      }
      friendsCircleData['images'] = friendsCircleImages;
      friendsCircle.add(friendsCircleData);
    }
    box.put('friendsCircle', friendsCircle);
    List chatUser = [];
    List before = ['other','my'];
    List type = ['content','image','location'];
    for(var i=0;i<5;i++){
      chatUser.add(initList[i]);
      chatUser[i]['chat'] = [];
      for(var j=0;j<5;j++){
        Map chat = {};
        chat['type'] = type[Random().nextInt(3)];
        chat['content'] = chat['type']=='content'?contentData['data'][Random().nextInt(1000)]:chat['type']=='image'?imagesData['data'][Random().nextInt(1000)]:'';
        chat['before'] = before[Random().nextInt(2)];
        chatUser[i]['chat'].add(chat);
      }
    }
    box.put('chatUser', chatUser);
    initDataBase();
  }

  void initDataBase() async{
    await SqliteTool().initAddress();
    await SqliteTool().initFriendsCircle();
    await SqliteTool().initChat();
  }
}
