import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class EditChatPublic extends StatefulWidget {
  final chatPublicId;

  const EditChatPublic({Key key, @required this.chatPublicId})
      : super(key: key);

  @override
  _EditChatPublicState createState() => _EditChatPublicState();
}

class _EditChatPublicState extends State<EditChatPublic> {
  TextEditingController publicName = TextEditingController();
  TextEditingController aver = TextEditingController();
  TextEditingController autoChat = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        title: Text('设置公众号'),
        actions: <Widget>[
          FlatButton(onPressed: (){
            update();
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
        padding: EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: publicName,
                  decoration: InputDecoration(labelText: '公众号名称'),
                  validator: (String value) {
                    return value.length > 0 ? null : '账号最少1个字符';
                  },
                ),
                TextFormField(
                 controller: aver,
                  decoration: InputDecoration(labelText: '公众号头像'),
                  validator: (String value) {
                    return value.length > 0
                        ? RegexUtil.isURL(value) ? null : '请输入合法的链接'
                        : '最少1个字符';
                  },
                ),
                TextFormField(
                  controller: autoChat,
                  decoration:
                      InputDecoration(labelText: '自动回复', hintText: '空则不自动回复'),
                  maxLines: null,
                  validator: (String value) {
                    return null;
                  },
                ),
              ],
            )),
      ),
    );
  }

  void getData() async {
    Map dataMap = await SqliteTool().getChatPublicInfo(widget.chatPublicId);
    setState(() {
      publicName.text = dataMap['publicname'];
      aver.text = dataMap['aver'];
      autoChat.text = dataMap['autoChat'];
    });
  }

  void update() async{
    if(_formKey.currentState.validate()){
      await SqliteTool().editChatPublicInfo(widget.chatPublicId, publicName.text, aver.text, autoChat.text);
      Navigator.of(context).pop();
    }
  }
}
