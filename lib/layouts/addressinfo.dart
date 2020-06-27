import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressInfo extends StatefulWidget {
  final Map info;

  const AddressInfo({Key key, @required this.info}) : super(key: key);

  @override
  _AddressInfoState createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 110,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      widget.info['aver'],
                      width: 55,
                      height: 55,
                      fit: BoxFit.fill,
                    )),
                Container(
                  width: 16,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.info['username'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 4,
                    ),
                    Text(
                      '微信号：' + widget.info['user'],
                      style: TextStyle(
                          color: Color(0xff6a6a6a),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 4,
                    ),
                    Text(
                      '地区：' + widget.info['address'],
                      style: TextStyle(
                          color: Color(0xff6a6a6a),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Color(0xfff1f1f1),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 55,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '设置备注和标签',
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xffa3a3a3),
                        ),
                        Container(
                          width: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xfff2f2f2),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 55,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '朋友权限',
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xffa3a3a3),
                        ),
                        Container(
                          width: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xfff2f2f2),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 55,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '朋友圈',
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xffa3a3a3),
                        ),
                        Container(
                          width: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xfff2f2f2),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 55,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '更多信息',
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xffa3a3a3),
                        ),
                        Container(
                          width: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xfff2f2f2),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
//              margin: EdgeInsets.only(bottom: 10),
              height: 55,
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/addressinfo/message.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    width: 4,
                  ),
                  Text(
                    '发信息',
                    style: TextStyle(
                        color: Color(0xff586590),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Color(0xfff1f1f1),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
//              margin: EdgeInsets.only(bottom: 10),
              height: 55,
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/addressinfo/video.png',
                    width: 26,
                    height: 26,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    width: 4,
                  ),
                  Text(
                    '音视频通话',
                    style: TextStyle(
                        color: Color(0xff586590),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
