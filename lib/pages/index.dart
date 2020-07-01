import 'dart:async';

import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/layouts/chat.dart';
import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Box box = Hive.box('hive');
  List chatUser = [];

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
          '微信',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.add_circle_outline), onPressed: () {}),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(AnimateRouter(Chat(chatData: chatUser[index]))).then((value) => getData());
              },
              child: Container(
                width: double.infinity,
                height: 70,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 45,
                      alignment: Alignment.center,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            chatUser[index]['aver'],
                            width: 45,
                            height: 45,
                            fit: BoxFit.fill,
                          )),
                    ),
                    Container(
                      width: 16,
                    ),
                    Flexible(
                        child: Column(
                      children: [
                        Flexible(
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chatUser[index]['username'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Container(
                                  height: 3,
                                ),
                                Text(
                                  chatUser[index]['chat'][
                                              chatUser[index]['chat'].length -
                                                  1]['type'] ==
                                          'content'
                                      ? chatUser[index]['chat']
                                              [chatUser[index]['chat'].length - 1]
                                          ['chat']
                                      : chatUser[index]['chat'][
                                                  chatUser[index]['chat'].length -
                                                      1]['type'] ==
                                              'image'
                                          ? '[图片]'
                                          : '[定位]',
                                  style: TextStyle(color: Color(0xffc5c5c5),fontSize: 12,fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    ))
                  ],
                ),
              ),
            );
          },
          itemCount: chatUser.length,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }

  void getData()async {
    List<Map> list = await SqliteTool().getChatUser();
    setState(() {
      chatUser = list;
    });
  }
}
