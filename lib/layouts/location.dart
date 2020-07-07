import 'dart:async';

import 'package:flutter/material.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:amap_search_fluttify/amap_search_fluttify.dart';

class LocationView extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<LocationView> with AmapSearchDisposeMixin {

  AmapController amapController;
  List<Poi> addressList = [];
  int listIndex = 0;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    closeAmapDebug();
    getAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(child: Text('取消',style: TextStyle(fontSize: 16),),alignment: Alignment.center,),
        ),
        actions: <Widget>[
          FlatButton(onPressed: (){
            sendLocation();
          }, child: Container(
            width: 52,
            height: 28,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Theme.of(context).primaryColor
            ),
            alignment: Alignment.center,
            child: Text('发送',style: TextStyle(color: Colors.white),),
          ))
        ],
        backgroundColor: Colors.white,
      ),
      body: Flex(direction: Axis.vertical,children: <Widget>[
        Expanded(child: Container(
          child: AmapView(
            onMapCreated: (controller)async{
              amapController = controller;
              await controller.showMyLocation(MyLocationOption(show: true,fillColor: Colors.transparent,strokeColor: Colors.transparent));
              getAddressList();
            },
            // 缩放级别 (可选)
            zoomLevel: 19,
          ),
        )),
        Expanded(child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 8,left: 8,right: 8),
          child: ListView.builder(itemBuilder: (context,index){
            return ListTile(
              title: Text(addressList[index].title),
              subtitle: Text(addressList[index].address),
              trailing: listIndex==index?Icon(Icons.check,color: Theme.of(context).primaryColor,):null,
              onTap: (){
                setState(() {
                  listIndex = index;
                });
                amapController.addMarker(MarkerOption(latLng: addressList[index].latLng));
                Timer(Duration(milliseconds: 300), (){
                  amapController.setCenterCoordinate(addressList[index].latLng);
                });
              },
            );
          },
          itemCount: addressList.length,
            physics: BouncingScrollPhysics(),
          ),
        )),
      ],),
    );
  }

  void closeAmapDebug() async{
    await enableFluttifyLog(false);
  }

  void getAddressList()async {
    Timer(Duration(milliseconds: 500), ()async{
      /// 搜索周边poi
      final poiList = await AmapSearch.searchAround(
          await amapController.getLocation(),
      keyword: ''
      );
      setState(() {
      addressList = poiList;
      });
    });
  }

  void sendLocation()async {
    Map location = {
      'address':addressList[listIndex].title,
      'lat':addressList[listIndex].latLng.latitude,
      'lng':addressList[listIndex].latLng.longitude
    };
    Navigator.of(context).pop(location);
  }
}
