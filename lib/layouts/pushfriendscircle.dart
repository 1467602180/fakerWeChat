import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class PushFriendsCircle extends StatefulWidget {
  @override
  _PushFriendsCircleState createState() => _PushFriendsCircleState();
}

class _PushFriendsCircleState extends State<PushFriendsCircle> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController addController = TextEditingController();
  List imageList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          FlatButton(
              onPressed: () {
                if(textEditingController.text.isNotEmpty){
                  SqliteTool().pushFriendsCircle(textEditingController.text, imageList).then((value) => Navigator.of(context).pop());
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
                  '发表',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 120,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  controller: textEditingController,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: '这一刻的想法...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: Color(0xffa7a7a7),
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                  child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                      ),
                      children: imageView(),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ),
                  margin: EdgeInsets.only(bottom: 100),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(height: 1,color: Color(0xfff2f2f2),),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(Icons.gps_fixed),
                          Container(width: 8,),
                          Text('所在位置')
                        ],
                      ),
                    ),
                    Divider(height: 1,color: Color(0xfff2f2f2),),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(Icons.notification_important),
                          Container(width: 8,),
                          Text('提醒谁看')
                        ],
                      ),
                    ),
                    Divider(height: 1,color: Color(0xfff2f2f2),),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(Icons.supervised_user_circle),
                          Container(width: 8,),
                          Text('谁可以看'),
                          Flexible(child: Container(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('公开',style: TextStyle(color: Color(0xffa8a8a8)),),
                                Icon(Icons.chevron_right,color: Color(0xffe0e0e0),)
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    Divider(height: 1,color: Color(0xfff2f2f2),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

 List<Widget> imageView() {
    List<Widget> list = [];
    for(var i in imageList){
      list.add(Image.network(i,fit: BoxFit.cover,));
    }
    if(imageList.length<9){
      list.add(GestureDetector(
        onTap: (){
          showDialog(context: context,builder: (context){
            return AlertDialog(
              title: Text('增加图像'),
              content: TextField(
                controller: addController,
                decoration: InputDecoration(hintText: '图像链接'),
              ),
              actions: [
                FlatButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text('取消')),
                FlatButton(onPressed: (){
                  if(addController.text.isNotEmpty&&RegexUtil.isURL(addController.text)){
                    setState(() {
                      imageList.add(addController.text);
                    });
                    addController.text = '';
                    Navigator.of(context).pop();
                  }
                }, child: Text('确定')),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
            );
          },);
        },
        child: Container(
          width: MediaQuery.of(context).size.width*0.35,
          color: Color(0xfff7f7f7),
          alignment: Alignment.center,
          child: Icon(Icons.add),
        ),
      ));
    }
    return list;
 }
}
