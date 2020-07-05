import 'dart:async';

import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/layouts/addressinfo.dart';
import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final Map chatData;

  const Chat({Key key, @required this.chatData}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool showBootom = false;
  List<Map> dataList = [];
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  String myAver = '';

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
        title: Text(widget.chatData['username']),
        actions: [IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})],
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
                child: ListView.builder(
                  controller: scrollController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: dataList[index]['before'] == 'my'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: dataList[index]['before'] == 'my'
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                chatView(dataList[index]),
                                Container(
                                  width: 16,
                                ),
                                ClipRRect(
                                  child: Image.network(
                                    myAver,
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                )
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  child: ClipRRect(
                                    child: Image.network(
                                      widget.chatData['aver'],
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(AnimateRouter(
                                        AddressInfo(info: widget.chatData)));
                                  },
                                ),
                                Container(
                                  width: 16,
                                ),
                                chatView(dataList[index]),
                              ],
                            ),
                    );
                  },
                  itemCount: dataList.length,
                  shrinkWrap: true,
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
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            SqliteTool()
                                .sendChatContent(value, widget.chatData['id'])
                                .then((value) {
                              textEditingController.text = '';
                              getData();
                            });
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
                              sendImage();
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
                            onTap: () {},
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

  void getData() async {
    List<Map> list = await SqliteTool().getChatContent(widget.chatData['id']);
    List<Map> myList = await SqliteTool().getUserInfo();
    setState(() {
      dataList = list;
      myAver = myList[0]['aver'];
    });
    Timer(Duration(milliseconds: 300), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  Widget chatView(Map dataList) {
    Widget widget;
    if (dataList['type'] == 'content') {
      widget = Flexible(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Color(0xff94ec6a), borderRadius: BorderRadius.circular(4)),
          child: Text(dataList['chat']),
        ),
      );
    } else if (dataList['type'] == 'image') {
      widget = GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    onLongPress: () {},
                    child: Image.network(
                      dataList['chat'],
                      fit: BoxFit.contain,
                    )),
              ),
            );
          }));
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width*0.2
          ),
          child: Image.network(
            dataList['chat'],
            fit: BoxFit.contain,
          ),
        ),
      );
    } else {
      widget = Container(
        width: 60,
        height: 60,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text('定位占位'),
      );
    }
    return widget;
  }

  void sendImage() {
    TextEditingController imageUrl = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('发送图片'),
            content: TextField(
              controller: imageUrl,
              decoration: InputDecoration(hintText: '请输入图片链接'),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('取消')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (imageUrl.text.isNotEmpty &&
                        RegexUtil.isURL(imageUrl.text)) {
                      SqliteTool()
                          .sendChatImage(imageUrl.text, widget.chatData['id'])
                          .then((value) => getData());
                    }
                  },
                  child: Text('确定'))
            ],
          );
        });
  }
}
