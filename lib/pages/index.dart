import 'dart:async';

import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/layouts/chat.dart';
import 'package:fakewechat/layouts/qrview.dart';
import 'package:fakewechat/layouts/search.dart';
import 'package:fakewechat/layouts/selectaddress.dart';
import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:ffloat/ffloat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Box box = Hive.box('hive');
  List chatUser = [];
  FFloatController fFloatController = FFloatController();

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
          IconButton(icon: Icon(Icons.search), onPressed: () {
            Navigator.of(context).push(AnimateRouter(Search()));
          }),
          FFloat((_){
            return Container(
              width: 160,
              height: 260,
              decoration: BoxDecoration(
                color: Color(0xff4c4c4c),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                children: <Widget>[
                  Container(height: 50,child: Row(
                      mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Icon(Icons.message,size: 20,color: Colors.white,),
                      ),
                      Flexible(child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xff545454)))
                        ),
                        child: Text('发起群聊',style: TextStyle(color: Colors.white,fontSize: 18),),
                      ))
                    ],
                  ),),
                  Container(height: 50,child: Row(
                      mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Icon(Icons.add,size: 20,color: Colors.white,),
                      ),
                      Flexible(child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xff545454)))
                        ),
                        child: Text('添加朋友',style: TextStyle(color: Colors.white,fontSize: 18),),
                      ))
                    ],
                  ),),
                  GestureDetector(
                    onTap: (){
                      fFloatController.dismiss();
                      Navigator.of(context).push(AnimateRouter(QRScreenView()));
                    },
                    child: Container(height: 50,child: Row(
                        mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          width: 50,
                          alignment: Alignment.center,
                          child: Icon(Icons.camera_alt,size: 20,color: Colors.white,),
                        ),
                        Flexible(child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xff545454)))
                          ),
                          child: Text('扫一扫',style: TextStyle(color: Colors.white,fontSize: 18),),
                        ))
                      ],
                    ),),
                  ),
                  Container(height: 50,child: Row(
                      mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Icon(Icons.monetization_on,size: 20,color: Colors.white,),
                      ),
                      Flexible(child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xff545454)))
                        ),
                        child: Text('收付款',style: TextStyle(color: Colors.white,fontSize: 18),),
                      ))
                    ],
                  ),),
                  Container(height: 50,child: Row(
                      mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Icon(Icons.help,size: 20,color: Colors.white,),
                      ),
                      Flexible(child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xff545454)))
                        ),
                        child: Text('帮助与反馈',style: TextStyle(color: Colors.white,fontSize: 18),),
                      ))
                    ],
                  ),),
                ],
              ),
            );
          },
          anchor: IconButton(icon: Icon(Icons.add_circle_outline), onPressed: () {
            fFloatController.show();
          }),
            controller: fFloatController,
            alignment: FFloatAlignment.bottomCenter,
            color: Colors.transparent,
            margin: EdgeInsets.only(right: 60),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(AnimateRouter(Chat(chatData: chatUser[index]))).then((value) => getData());
                    },
                    onLongPress: (){
//                      showDialog(context: context,builder: (context){
//                        return AlertDialog(
//                          title: Text('操作提示'),
//                          content: Text('确认删除该聊天记录'),
//                          actions: <Widget>[
//                            FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text('取消')),
//                            FlatButton(onPressed: ()async{
//                              Navigator.of(context).pop();
//                              await SqliteTool().deleteChat(chatUser[index]['id']);
//                              getData();
//                            }, child: Text('确定')),
//                          ],
//                        );
//                      });
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
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(AnimateRouter(SelectAddress())).then((value) => getData());
                },
                onLongPress: (){

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
                            child: Image.asset(
                              'assets/images/index/qunfa.png',
                              width: 30,
                              height: 30,
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
                                        '群发助手',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
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
