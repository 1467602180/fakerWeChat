import 'dart:async';

import 'package:fakewechat/tools/sqlitetool.dart';
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
                      alignment: dataList[index]['before'] == 'my'?Alignment.centerRight:Alignment.centerLeft,
                      child: dataList[index]['before'] == 'my'
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                chatView(dataList[index]),
                                Container(width: 16,),
                                ClipRRect(
                                  child: Image.network(
                                    widget.chatData['aver'],
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(4),)
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    child: Image.network(
                                  widget.chatData['aver'],
                                  width: 35,
                                  height: 35,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(4),),
                                Container(width: 16,),
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
                    padding: EdgeInsets.all(8),
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
                        onSubmitted: (value){
                          if(value.isNotEmpty){
                            SqliteTool().sendChatContent(value, widget.chatData['id']).then((value){
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
                      })
                ],
              ),
            ),
            Container(
              height: showBootom ? 350 : 1,
            )
          ],
        ),
      ),
    );
  }

  void getData() async {
    List<Map> list = await SqliteTool().getChatContent(widget.chatData['id']);
    print(widget.chatData);
    setState(() {
      dataList = list;
    });
    Timer(Duration(milliseconds: 300), (){
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

 Widget chatView(Map dataList) {
    Widget widget;
    if(dataList['type']=='content'){
      widget = Container(
        width: MediaQuery.of(context).size.width*0.6,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xff94ec6a),
          borderRadius: BorderRadius.circular(4)
        ),
        child: Text(dataList['chat']),
      );
    }else if(dataList['type']=='image'){
      widget = Image.network(dataList['chat'],fit: BoxFit.fill,);
    }else{
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
}
