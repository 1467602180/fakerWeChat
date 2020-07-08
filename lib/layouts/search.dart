import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/layouts/chat.dart';
import 'package:fakewechat/layouts/chatpubliccontent.dart';
import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool showSearchResult = false;
  List<Map> addressList = [];
  List<Map> chatPublicList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
//          搜索框
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      child: Container(
                    height: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '搜索'),
                        autofocus: true,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              showSearchResult = false;
                            });
                          } else {
                            search(value);
                          }
                        },
                      ),
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        '取消',
                        style:
                            TextStyle(color: Color(0xff455880), fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showSearchResult,
//            搜索结果视图
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Visibility(
                      visible: addressList.length != 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Color(0xffededed))),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '联系人',
                              style: TextStyle(color: Color(0xff7a7a7a)),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: addressListView(),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: chatPublicList.length != 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Color(0xffededed))),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '公众号',
                              style: TextStyle(color: Color(0xff7a7a7a)),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: chatPublicListView(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              replacement: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: Text(
                      '搜索指定内容',
                      style: TextStyle(color: Color(0xffc2c2c2)),
                    ),
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: 20,
                          alignment: Alignment.center,
                          child: Text(
                            '朋友圈',
                            style: TextStyle(
                                color: Color(0xff435886), fontSize: 18),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          alignment: Alignment.center,
                          height: 20,
                          child: Text(
                            '文章',
                            style: TextStyle(
                                color: Color(0xff435886), fontSize: 18),
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Color(0xffe0e0e0)),
                                  right: BorderSide(color: Color(0xffe0e0e0)))),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: 20,
                          alignment: Alignment.center,
                          child: Text(
                            '公众号',
                            style: TextStyle(
                                color: Color(0xff435886), fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: 20,
                          alignment: Alignment.center,
                          child: Text(
                            '小程序',
                            style: TextStyle(
                                color: Color(0xff435886), fontSize: 18),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          alignment: Alignment.center,
                          height: 20,
                          child: Text(
                            '音乐',
                            style: TextStyle(
                                color: Color(0xff435886), fontSize: 18),
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Color(0xffe0e0e0)),
                                  right: BorderSide(color: Color(0xffe0e0e0)))),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: 20,
                          alignment: Alignment.center,
                          child: Text(
                            '表情',
                            style: TextStyle(
                                color: Color(0xff435886), fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void search(String value) async {
    List<Map> searchAddressList = await SqliteTool().searchAddress(value);
    List<Map> searchChatPublicList = await SqliteTool().searchChatPublic(value);
    setState(() {
      addressList = searchAddressList;
      chatPublicList = searchChatPublicList;
      showSearchResult = true;
    });
  }

  List<Widget> addressListView() {
    List<Widget> list = [];
    for (var i in addressList) {
      list.add(GestureDetector(
        onTap: (){
          Navigator.of(context).push(AnimateRouter(Chat(chatData: i)));
        },
        child: Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 60,
                alignment: Alignment.center,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      i['aver'],
                      width: 45,
                      height: 45,
                    )),
              ),
              Flexible(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Color(0xffededed)))),
                  alignment: Alignment.centerLeft,
                  child: Text(i['username']),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return list;
  }

  List<Widget> chatPublicListView() {
    List<Widget> list = [];
    for (var i in chatPublicList) {
      list.add(GestureDetector(
        onTap: (){
          Navigator.of(context).push(AnimateRouter(ChatPublicContent(chatPublicId: i['id'])));
        },
        child: Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 60,
                alignment: Alignment.center,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      i['aver'],
                      width: 45,
                      height: 45,
                    )),
              ),
              Flexible(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Color(0xffededed)))),
                  alignment: Alignment.centerLeft,
                  child: Text(i['publicname']),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return list;
  }
}
