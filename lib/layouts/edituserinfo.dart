import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class EditUserInfo extends StatefulWidget {
  final info;

  const EditUserInfo({Key key, this.info}) : super(key: key);

  @override
  _EditUserInfoState createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  String username = '';
  String user = '';
  String aver = '';
  String city = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑通讯录'),
        actions: [
          FlatButton(
              onPressed: () {
                var state = _formKey.currentState;
                if (state.validate()) {
                  state.save();
                  updateAddress();
                }
              },
              child: Container(
                width: 52,
                height: 28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Theme.of(context).primaryColor),
                alignment: Alignment.center,
                child: Text(
                  '保存',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.info['username'],
                decoration: InputDecoration(labelText: '昵称'),
                onSaved: (value) {
                  username = value;
                },
                validator: (String value) {
                  return value.isNotEmpty ? null : '不可为空';
                },
              ),
              TextFormField(
                initialValue: widget.info['user'],
                decoration: InputDecoration(labelText: '用户名'),
                onSaved: (value) {
                  user = value;
                },
                validator: (String value) {
                  return value.isNotEmpty ? null : '不可为空';
                },
              ),
              TextFormField(
                initialValue: widget.info['aver'],
                decoration: InputDecoration(labelText: '头像'),
                onSaved: (value) {
                  aver = value;
                },
                validator: (String value) {
                  return value.isNotEmpty
                      ? RegexUtil.isURL(value) ? null : '请输入正确格式的URL'
                      : '不可为空';
                },
              ),
              TextFormField(
                initialValue: widget.info['city'],
                decoration: InputDecoration(labelText: '地区'),
                onSaved: (value) {
                  city = value;
                },
                validator: (String value) {
                  return value.isNotEmpty ? null : '不可为空';
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateAddress() {
    SqliteTool().updateAddress(widget.info['id'], username, user, aver, city);
    Navigator.of(context).pop();
  }
}
