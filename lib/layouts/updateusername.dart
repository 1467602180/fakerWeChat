import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UpdateUserName extends StatefulWidget {
  @override
  _UpdateUserNameState createState() => _UpdateUserNameState();
}

class _UpdateUserNameState extends State<UpdateUserName> {
  Box box = Hive.box('hive');
  TextEditingController textEditingController = TextEditingController();
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
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text('更改名字',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          FlatButton(onPressed: (){
            Update();
          }, child: Container(
            width: 52,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Theme.of(context).primaryColor
            ),
            alignment: Alignment.center,
            child: Text('保存',style: TextStyle(color: Colors.white),),
          ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: TextField(
          decoration: InputDecoration(
              helperText: '好名字可以让你的朋友更容易记住你',
              helperStyle: TextStyle(fontSize: 13)),
          autofocus: true,
          controller: textEditingController,
        ),
      ),
    );
  }

  void getData()async {
    List<Map> list = await SqliteTool().getUserInfo();
    textEditingController.text = list[0]['username'];
  }

  void Update() async{
    List<Map> list = await SqliteTool().getUserInfo();
    SqliteTool().updateUserInfo(textEditingController.text, list[0]['aver']);
    Navigator.of(context).pop();
  }
}
