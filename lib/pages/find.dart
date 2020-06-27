import 'package:fakewechat/compents/animaterouter.dart';
import 'package:fakewechat/layouts/friendscircle.dart';
import 'package:flutter/material.dart';

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '发现',
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
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(AnimateRouter(FriendsCircle()));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
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
                      child: Image.asset(
                        'assets/images/find/ff_Icon_album.webp',
                        scale: 3,
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
                            '朋友圈',
                            style: TextStyle(
                                 fontSize: 16),
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black26,
                    )
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
                      child: Image.asset(
                        'assets/images/find/ff_Icon_qr_code.webp',
                        scale: 3,
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    '扫一扫',
                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  width: double.infinity,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
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
                      child: Image.asset(
                        'assets/images/find/ff_Icon_shake.webp',
                        scale: 3,
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
                            '摇一摇',
                            style: TextStyle(
                                fontSize: 16),
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black26,
                    )
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
                      child: Image.asset(
                        'assets/images/find/ff_Icon_browse.webp',
                        scale: 3,
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    '看一看',
                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  width: double.infinity,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
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
                      child: Image.asset(
                        'assets/images/find/ff_Icon_search.webp',
                        scale: 3,
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    '搜一搜',
                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  width: double.infinity,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
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
                      child: Image.asset(
                        'assets/images/find/ff_Icon_nearby.webp',
                        scale: 3,
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    '附近的人',
                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  width: double.infinity,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
//                margin: EdgeInsets.only(bottom: 8),
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
                      child: Image.asset(
                        'assets/images/find/shop.png',
                        scale: 3,
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    '购物',
                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  width: double.infinity,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
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
                      child: Image.asset(
                        'assets/images/find/game_center_h5.webp',
                        scale: 3,
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    '游戏',
                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  width: double.infinity,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
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
                      child: Image.asset(
                        'assets/images/find/mini_program.webp',
                        scale: 3,
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    '小程序',
                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  width: double.infinity,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
