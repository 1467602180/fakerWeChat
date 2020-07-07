import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/layouts/updateuser.dart';
import 'package:fakewechat/layouts/updateusername.dart';
import 'package:fakewechat/layouts/userqr.dart';
import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  Box box = Hive.box('hive');
  String imageData = '';
  String user = '';
  String username = '';

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
        title: Text(
          '个人信息',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                selectImage();
              },
              child: Container(
                height: 80,
                color: Colors.white,
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                        child: Container(
                      height: 79,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '头像',
                            style: TextStyle(fontSize: 16),
                          ),
                          Flexible(
                              child: Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
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
                          )),
                          Icon(
                            Icons.chevron_right,
                            color: Color(0xffbdbdbd),
                          ),
                          Container(
                            width: 8,
                          )
                        ],
                      ),
                    )),
                    Divider(
                      height: 1,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(AnimateRouter(UpdateUserName()))
                    .then((value) => getData());
              },
              child: Container(
                height: 50,
                color: Colors.white,
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                        child: Container(
                      height: 49,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '昵称',
                            style: TextStyle(fontSize: 16),
                          ),
                          Flexible(
                              child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    '${username}',
                                    style: TextStyle(
                                        color: Color(0xff7b7b7b), fontSize: 14),
                                  ))),
                          Icon(
                            Icons.chevron_right,
                            color: Color(0xffbdbdbd),
                          ),
                          Container(
                            width: 8,
                          )
                        ],
                      ),
                    )),
                    Divider(
                      height: 1,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(AnimateRouter(UpdateUser()));
              },
              child: Container(
                height: 50,
                color: Colors.white,
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                        child: Container(
                      height: 49,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '微信号',
                            style: TextStyle(fontSize: 16),
                          ),
                          Flexible(
                              child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    '${user}',
                                    style: TextStyle(
                                        color: Color(0xff7b7b7b), fontSize: 14),
                                  ))),
                          Icon(
                            Icons.chevron_right,
                            color: Color(0xffbdbdbd),
                          ),
                          Container(
                            width: 8,
                          )
                        ],
                      ),
                    )),
                    Divider(
                      height: 1,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(AnimateRouter(UserQR()));
              },
              child: Container(
                height: 50,
                color: Colors.white,
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                        child: Container(
                      height: 49,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '二维码名片',
                            style: TextStyle(fontSize: 16),
                          ),
                          Flexible(
                              child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Image.asset(
                                    'assets/images/my/qr.png',
                                    width: 18,
                                    height: 18,
                                  ))),
                          Icon(
                            Icons.chevron_right,
                            color: Color(0xffbdbdbd),
                          ),
                          Container(
                            width: 8,
                          )
                        ],
                      ),
                    )),
                    Divider(
                      height: 1,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 50,
                color: Colors.white,
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                        child: Container(
                      height: 49,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '更多',
                            style: TextStyle(fontSize: 16),
                          ),
                          Flexible(
                              child: Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(vertical: 8),
                          )),
                          Icon(
                            Icons.chevron_right,
                            color: Color(0xffbdbdbd),
                          ),
                          Container(
                            width: 8,
                          )
                        ],
                      ),
                    )),
                    Divider(
                      height: 1,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                color: Colors.white,
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                        child: Container(
                      height: 49,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '我的地址',
                            style: TextStyle(fontSize: 16),
                          ),
                          Flexible(
                              child: Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(vertical: 8),
                          )),
                          Icon(
                            Icons.chevron_right,
                            color: Color(0xffbdbdbd),
                          ),
                          Container(
                            width: 8,
                          )
                        ],
                      ),
                    )),
                    Divider(
                      height: 1,
                    )
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

  void selectImage() async {
    TextEditingController textEditingController = TextEditingController();
    showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text('更换头像'),
        content: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
              hintText: '输入头像链接'
          ),
        ),
        actions: <Widget>[
          FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text('取消')),
          FlatButton(onPressed: (){
            if(textEditingController.text.isNotEmpty&&RegexUtil.isURL(textEditingController.text)){
              SqliteTool().updateUserInfo(username, textEditingController.text);
              getData();
              Navigator.of(context).pop();
            }
          }, child: Text('确定')),
        ],
      );
    });
  }
}
