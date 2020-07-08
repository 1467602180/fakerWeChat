import 'dart:async';

import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flutter/material.dart';

class ChatPublicContent extends StatefulWidget {

  final chatPublicId;

  const ChatPublicContent({Key key, @required this.chatPublicId}) : super(key: key);

  @override
  _ChatPublicContentState createState() => _ChatPublicContentState();
}

class _ChatPublicContentState extends State<ChatPublicContent> {

  Map chatPublicInfo = {};
  List<Map> list = [];
  bool showBootom = false;
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
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
        title: Text(chatPublicInfo['publicname']??''),
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
                          alignment: list[index]['before'] == 'my'
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: list[index]['before'] == 'my'
                              ? Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Color(0xff94ec6a), borderRadius: BorderRadius.circular(4)),
                                  child: Text(list[index]['chat']),
                                ),
                              ),
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
                                    chatPublicInfo['aver'],
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
//                                前往公众号详情界面
                                onTap: () {

                                },
                              ),
                              Container(
                                width: 16,
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Color(0xff94ec6a), borderRadius: BorderRadius.circular(4)),
                                  child: Text(list[index]['chat']),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: list.length,
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
//                            发消息
                            onSubmitted: (value) {
                              sendMessage(value);
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

  void getData()async {
    Map dataMap = await SqliteTool().getChatPublicInfo(widget.chatPublicId);
    List<Map> myList = await SqliteTool().getUserInfo();
    List<Map> dataList = await SqliteTool().getChatPublicContent(widget.chatPublicId);
    setState(() {
      chatPublicInfo = dataMap;
      myAver = myList[0]['aver'];
      list = dataList;
    });
    Timer(Duration(milliseconds: 300), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  void sendMessage(String value) async{
    if(textEditingController.text.isNotEmpty){
      await SqliteTool().sendMessage(widget.chatPublicId, textEditingController.text);
      await SqliteTool().autoMessage(widget.chatPublicId);
      getData();
    }
  }
}
