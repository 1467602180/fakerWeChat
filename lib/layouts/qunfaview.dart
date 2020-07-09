import 'dart:async';

import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/layouts/home.dart';
import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QunFaView extends StatefulWidget {

  final List<Map> list;

  const QunFaView({Key key, @required this.list}) : super(key: key);

  @override
  _QunFaViewState createState() => _QunFaViewState();
}

class _QunFaViewState extends State<QunFaView> {

  bool showBootom = false;
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  String qunbfaAddress = '';

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
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text('群发'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xffe9e9e9)))),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
                child: GestureDetector(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('你将发信息给${widget.list.length}位朋友',style: TextStyle(color: Color(0xffc5c5c5)),),
                        Text(qunbfaAddress,style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  ),
                  onTap: () {
                    if (showBootom) {
                      setState(() {
                        showBootom = false;
                      });
                    }
                  },
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 55,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Color(0xffe2e2e2)),
                      bottom: BorderSide(color: Color(0xffe2e2e2)))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.keyboard_voice), onPressed: () {}),
                  Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: TextField(
                            controller: textEditingController,
                            maxLines: null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                            textInputAction: TextInputAction.send,
//                            发送信息
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                qunFaMessage(value);
                              }
                            },
                          ),
                        ),
                      )),
                  IconButton(icon: Icon(Icons.face), onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        setState(() {
                          showBootom = !showBootom;
                        });
                        Timer(Duration(milliseconds: 300), () {
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                        });
                      })
                ],
              ),
            ),
            Container(
              height: showBootom ? 350 : 1,
              child: !showBootom
                  ? Container()
                  : Container(
                alignment: Alignment.center,
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 1),
                  children: [
                    GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Icon(Icons.photo),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            Container(
                              height: 4,
                            ),
                            Text(
                              '相册',
                              style: TextStyle(
                                  color: Color(0xff4d4d4d), fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Icon(Icons.camera_alt),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            Container(
                              height: 4,
                            ),
                            Text(
                              '拍摄',
                              style: TextStyle(
                                  color: Color(0xff4d4d4d), fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Icon(Icons.video_call),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            Container(
                              height: 4,
                            ),
                            Text(
                              '视频通话',
                              style: TextStyle(
                                  color: Color(0xff4d4d4d), fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Icon(Icons.location_on),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            Container(
                              height: 4,
                            ),
                            Text(
                              '位置',
                              style: TextStyle(
                                  color: Color(0xff4d4d4d), fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Icon(Icons.mic),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            Container(
                              height: 4,
                            ),
                            Text(
                              '语音输入',
                              style: TextStyle(
                                  color: Color(0xff4d4d4d), fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Icon(Icons.star),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            Container(
                              height: 4,
                            ),
                            Text(
                              '我的收藏',
                              style: TextStyle(
                                  color: Color(0xff4d4d4d), fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Icon(Icons.supervised_user_circle),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            Container(
                              height: 4,
                            ),
                            Text(
                              '名片',
                              style: TextStyle(
                                  color: Color(0xff4d4d4d), fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Icon(Icons.filter),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            Container(
                              height: 4,
                            ),
                            Text(
                              '文件',
                              style: TextStyle(
                                  color: Color(0xff4d4d4d), fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void qunFaMessage(value) {
    showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text('操作提示'),
        content: Text('确认进行群发？'),
        actions: <Widget>[
          FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text('取消')),
          FlatButton(onPressed: (){
            for(var i in widget.list){
              SqliteTool().vChatUser(i['id']).then((v){
                if(v){
                  SqliteTool()
                      .sendChatContent(value, i['id'])
                      .then((value) {
                    textEditingController.text = '';
                  });
                }else{
                  SqliteTool().addChatUser(i['id']).then((_){
                    SqliteTool()
                        .sendChatContent(value, i['id'])
                        .then((value) {
                      textEditingController.text = '';
                    });
                  });
                }

              });
            }
            Navigator.of(context).pushAndRemoveUntil(AnimateRouter(Home()), (route) => false);
          }, child: Text('确定')),
        ],
      );
    });
  }

  void getData() {
    String str = '';
    for(var i in widget.list){
      str+=i['username']+' ';
    }
    setState(() {
      qunbfaAddress = str;
    });
  }
}
