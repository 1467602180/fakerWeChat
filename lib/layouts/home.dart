import 'package:fakewechat/pages/address.dart';
import 'package:fakewechat/pages/find.dart';
import 'package:fakewechat/pages/index.dart';
import 'package:fakewechat/pages/my.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          Index(),
          Address(),
          Find(),
          My(),
        ],
        physics: BouncingScrollPhysics(),
        onPageChanged: (value){
          setState(() {
            index = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                index == 0
                    ? 'assets/images/home/tabbar_chat_s.webp'
                    : 'assets/images/home/tabbar_chat_c.webp',
                scale: 3,
              ),
              title: Text('微信',style: TextStyle(color: index==0?Theme.of(context).primaryColor:Colors.black),),
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                index == 1
                    ? 'assets/images/home/tabbar_contacts_s.webp'
                    : 'assets/images/home/tabbar_contacts_c.webp',
                scale: 3,
              ),
              title: Text('通讯录',style: TextStyle(color: index==1?Theme.of(context).primaryColor:Colors.black),)),
          BottomNavigationBarItem(
              icon: Image.asset(
                index == 2
                    ? 'assets/images/home/tabbar_discover_s.webp'
                    : 'assets/images/home/tabbar_discover_c.webp',
                scale: 3,
              ),
              title: Text('发现',style: TextStyle(color: index==2?Theme.of(context).primaryColor:Colors.black),)),
          BottomNavigationBarItem(
              icon: Image.asset(
                index == 3
                    ? 'assets/images/home/tabbar_me_s.webp'
                    : 'assets/images/home/tabbar_me_c.webp',
                scale: 3,
              ),
              title: Text('我',style: TextStyle(color: index==3?Theme.of(context).primaryColor:Colors.black),)),
        ],
        currentIndex: index,
        elevation: 0,
        onTap: (value) {
          pageController.jumpToPage(value);
          setState(() {
            index = value;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
