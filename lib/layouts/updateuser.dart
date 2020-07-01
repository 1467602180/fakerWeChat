import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UpdateUser extends StatefulWidget {
  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  Box box = Hive.box('hive');
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/updateuser/wechat.png',
                    width: 56,
                    height: 56,
                  ),
                  Container(
                    height: 30,
                  ),
                  Text(
                    '微信号：${user}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    height: 20,
                  ),
                  Text(
                    '微信号是账号的唯一凭证，一年只能修改一次',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            flex: 3,
          ),
          Expanded(child: Container()),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: FlatButton(
                  onPressed: () {},
                  child: Container(
                    width: 170,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xfff2f2f2),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    alignment: Alignment.center,
                    child: Text(
                      '修改微信号',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  void getData()async {
    List<Map> list = await SqliteTool().getUserInfo();
    setState(() {
      user = list[0]['user'];
    });
  }
}
