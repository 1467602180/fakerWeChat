import 'dart:typed_data';
import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/layouts/addressinfo.dart';
import 'package:fakewechat/layouts/pushfriendscircle.dart';
import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class FriendsCircle extends StatefulWidget {
  @override
  _FriendsCircleState createState() => _FriendsCircleState();
}

class _FriendsCircleState extends State<FriendsCircle> {
  Box box = Hive.box('hive');
  Uint8List imageData = Uint8List(0);
  String username = '';
  String aver = '';
  ScrollController scrollController = ScrollController();
  String title = '';
  bool isScroll = false;
  List friendsCircle = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset >= 300) {
        setState(() {
          title = '朋友圈';
          isScroll = true;
        });
      } else {
        setState(() {
          title = '';
          isScroll = false;
        });
      }
    });
    getData();
  }

  getData()async{
    List<Map> userInfo = await SqliteTool().getUserInfo();
    List<Map> list = List.from(await SqliteTool().selectBaseReverse('friendscircle'));
    List<Map> dataList = [];
    for(var i in list){
      List<Map> imagesList = await SqliteTool().selectFriendsCircleImages(i['id']);
      Map userInfo = await SqliteTool().selectUser(i['user']);
      Map dataMap = Map.from(i);
      dataMap['user'] = userInfo;
      dataMap['images'] = imagesList;
      dataList.add(dataMap);
    }
    setState(() {
      username = userInfo[0]['username'];
      aver = userInfo[0]['aver'];
      friendsCircle = dataList;
      imageData = box.get('friendsCircleImage', defaultValue: Uint8List(0));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  expandedHeight: 300.0,
                  leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: isScroll ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  actions: [
                    IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: isScroll ? Colors.black : Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(AnimateRouter(PushFriendsCircle())).then((value) => getData());
                        })
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    background: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Text(
                                          '更换相册封面',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        setImage();
                                      },
                                    ),
                                    Container(
                                      height: 10,
                                      color: Color(0xfff6f6f6),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Text(
                                          '取消',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                              backgroundColor: Colors.transparent,
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 270,
                                width: MediaQuery.of(context).size.width,
                                child: imageData.isEmpty
                                    ? Image.asset(
                                        'assets/images/friendscircle/default-friendscircle.png',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.memory(
                                        imageData,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Flexible(
                                  child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                alignment: Alignment.bottomCenter,
                              ))
                            ],
                          ),
                        ),
                        Positioned(
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  username,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Container(
                                  width: 16,
                                ),
                                Container(
                                  height: 60,
                                  width: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: aver.isEmpty
                                        ? Image.asset(
                                      'assets/images/my/def_avatar.png',
                                      fit: BoxFit.fill,
                                    )
                                        : Image.network(
                                      aver,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 16,
                                ),
                              ],
                            ),
                          ),
                          height: 160,
                          width: MediaQuery.of(context).size.width,
                          bottom: 0,
                        )
                      ],
                    ),
                  ))
            ];
          },
          body: Container(
            color: Colors.white,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 1.5),
                  padding: EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xfff1f1f1), width: 1.5))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          if(friendsCircle[index]['user']['id']!=1){
                            Navigator.of(context).push(AnimateRouter(AddressInfo(info: friendsCircle[index]['user'])));
                          }
                        },
                        child: Container(
                          width: 40,
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              friendsCircle[index]['user']['aver'],
                              width: 36,
                              height: 36,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 16,
                      ),
                      Flexible(
                          child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              friendsCircle[index]['user']['username'],
                              style: TextStyle(
                                  color: Color(0xff57687e),
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 6,
                            ),
                            Text(friendsCircle[index]['content']),
                            Container(
                              height: 6,
                            ),
                            friendsCircle[index]['images'].length == 0
                                ? Container(
                                    width: 0,
                                    height: 0,
                                  )
                                : Container(
                                    height:
                                        friendsCircle[index]['images'].length <=
                                                3
                                            ? 100
                                            : friendsCircle[index]['images']
                                                        .length <=
                                                    6
                                                ? 201
                                                : 302,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 1,
                                              mainAxisSpacing: 1,
                                              crossAxisSpacing: 1),
                                      itemBuilder: (context, imageIndex) {
                                        return GestureDetector(
                                          onTap: (){
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
                                                        friendsCircle[index]['images']
                                                        [imageIndex]['image'],
                                                        fit: BoxFit.contain,
                                                        width: MediaQuery.of(context).size.width*0.95,
                                                      )),
                                                ),
                                              );
                                            }));
                                          },
                                          child: Container(
                                            child: Image.network(
                                              friendsCircle[index]['images']
                                                  [imageIndex]['image'],
                                              fit: BoxFit.fill,
                                              loadingBuilder: (context,child,progress){
                                                if(progress==null){
                                                  return child;
                                                }
                                                return Container(
                                                  alignment: Alignment.center,
                                                  child: CircularProgressIndicator(),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          friendsCircle[index]['images'].length,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  )
                          ],
                        ),
                      ))
                    ],
                  ),
                );
              },
              itemCount: friendsCircle.length,
              physics: BouncingScrollPhysics(),
            ),
          ),
          controller: scrollController,
        ),
      ),
    );
  }

  void setImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    Uint8List selectImage = await pickedFile.readAsBytes();
    box.put('friendsCircleImage', selectImage);
    setState(() {
      imageData = selectImage;
    });
  }
}
