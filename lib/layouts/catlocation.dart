import 'dart:async';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CatLocation extends StatefulWidget {
  final Map location;

  const CatLocation({Key key, @required this.location}) : super(key: key);

  @override
  _CatLocationState createState() => _CatLocationState();
}

class _CatLocationState extends State<CatLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('查看位置'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                toAMap();
              },
              child: Container(
                width: 80,
                height: 28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Theme.of(context).primaryColor),
                alignment: Alignment.center,
                child: Text(
                  '跳转地图',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
      body: AmapView(
          zoomLevel: 19,
          onMapCreated: (controller) async {
            controller.setCenterCoordinate(
                LatLng(widget.location['lat'], widget.location['lng']));
            Timer(Duration(milliseconds: 300), () {
              controller.addMarker(MarkerOption(
                  latLng:
                      LatLng(widget.location['lat'], widget.location['lng']),
              title: widget.location['address']));
            });
          }),
    );
  }

  void toAMap() async {
    final String url =
        'androidamap://viewMap?sourceApplication=faker微信&poiname=${widget.location['address']}&lat=${widget.location['lat']}&lon=${widget.location['lng']}&dev=0';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('操作提示'),
              content: Text('未安装高德地图'),
              actions: <Widget>[
                FlatButton(onPressed: () {}, child: Text('确定'))
              ],
            );
          });
    }
  }
}
