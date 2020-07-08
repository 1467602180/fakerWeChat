import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/layouts/chatpubliccontent.dart';
import 'package:fakewechat/layouts/editchatpublic.dart';
import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flutter/material.dart';

class ChatPublic extends StatefulWidget {
  @override
  _ChatPublicState createState() => _ChatPublicState();
}

class _ChatPublicState extends State<ChatPublic> {
  List<Map> list = [];

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
          '公众号',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(AnimateRouter(ChatPublicContent(chatPublicId: list[index]['id'])));
            },
            onLongPress: (){
              Navigator.of(context).push(AnimateRouter(EditChatPublic(chatPublicId: list[index]['id']))).then((value){
                getData();
              });
            },
            child: Container(
              color: Colors.white,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xfff0f0f0)))
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(list[index]['aver'],width: 40,height: 40,),
                    ),
                    Container(width: 8,),
                    Text(list[index]['publicname'])
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: list.length,
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  void getData() async {
    List<Map> dataList = await SqliteTool().getChatPublic();
    setState(() {
      list = dataList;
    });
  }
}
