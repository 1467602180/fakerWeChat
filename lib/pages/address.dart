import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/layouts/addressinfo.dart';
import 'package:fakewechat/layouts/chatpublic.dart';
import 'package:fakewechat/layouts/edituserinfo.dart';
import 'package:fakewechat/layouts/search.dart';
import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {

  Box box = Hive.box('hive');
  List address = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    setState(() {
//      address = box.get('address');
//    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '通讯录',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: () {
              Navigator.of(context).push(AnimateRouter(Search()));
            }),
            IconButton(icon: Icon(Icons.add_circle_outline), onPressed: () {}),
          ],
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 48,
                      color: Colors.white,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 65,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(4),
                            child: ClipRRect(
                              child: Image.asset(
                                  'assets/images/address/ic_new_friend.webp'),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          Flexible(
                              child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                  child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '新的朋友',
                                  style: TextStyle(
//                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )),
                              Divider(
                                height: 1,
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 48,
                      color: Colors.white,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 65,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(4),
                            child: ClipRRect(
                              child: Image.asset(
                                  'assets/images/address/ic_group.webp'),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          Flexible(
                              child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                  child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '群聊',
                                  style: TextStyle(
//                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )),
                              Divider(
                                height: 1,
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 48,
                      color: Colors.white,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 65,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(4),
                            child: ClipRRect(
                              child: Image.asset(
                                  'assets/images/address/ic_tag.webp'),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          Flexible(
                              child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                  child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '标签',
                                  style: TextStyle(
//                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )),
                              Divider(
                                height: 1,
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(AnimateRouter(ChatPublic()));
                    },
                    child: Container(
                      height: 48,
                      color: Colors.white,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 65,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(4),
                            child: ClipRRect(
                              child: Image.asset(
                                  'assets/images/address/ic_offical.webp'),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          Flexible(
                              child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                  child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '公众号',
                                  style: TextStyle(
//                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )),
                              Divider(
                                height: 1,
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: AddressListView(),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      child: Text('↑'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('A'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('B'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('C'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('D'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('E'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('F'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('G'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('H'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('I'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('J'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('K'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('L'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('M'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('N'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('O'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('P'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('Q'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('R'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('S'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('T'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('U'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('V'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('W'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('X'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('Y'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('Z'),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Text('#'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              right: 0,
              left: MediaQuery.of(context).size.width * 0.94,
            )
          ],
        ));
  }

  List<Widget> AddressListView() {
    List<Widget> list = [];
    if(address.isNotEmpty){
      for(var i in address){
        i.forEach((k,v){
          list.add(
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.centerLeft,
              child: Text('${k}'),
            )
          );
          list.add(Column(
            children: AddressListItemView(v),
          ));
        });
      }
    }
    return list;
  }

  List<Widget> AddressListItemView(v) {
    List<Widget> list = [];
    for(var i in v){
      list.add(
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(AnimateRouter(AddressInfo(info: i,)));
          },
          onLongPress: (){
            Navigator.of(context).push(AnimateRouter(EditUserInfo(info:i))).then((value) => getData());
          },
          child: Container(
            height: 48,
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 65,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(4),
                  child: ClipRRect(
                    child: Image.network(
                        i['aver']),
                    borderRadius:
                    BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${i['username']}',
                                style: TextStyle(
//                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            )),
                        Divider(
                          height: 1,
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      );
    }
    return list;
  }

  void getData()async {
    List list = [];
    List<Map> initList = List.from(await SqliteTool().selectBase('address'));
    initList.removeAt(0);
    List surnameList = [];
    for(var i in initList){
      surnameList.add(i['surname']);
    }
    surnameList.sort();
    Set surnameSet = Set.from(surnameList);
    for(var i in surnameSet){
      Map dataMap = {};
      List dataList = [];
      for(var j in initList){
        if(i==j['surname']){
          dataList.add(j);
        }
      }
      dataMap[i] = dataList;
      list.add(dataMap);
    }
    setState(() {
      address = list;
    });
  }
}
