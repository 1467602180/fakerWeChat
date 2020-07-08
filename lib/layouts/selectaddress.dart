import 'package:fakewechat/tools/sqlitetool.dart';
import 'package:flutter/material.dart';

class SelectAddress extends StatefulWidget {
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  List<Map> list = [];
  List<bool> selectList = [];

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
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text('选择收信人'),
        actions: [
          FlatButton(
              onPressed: () {},
              child: Container(
                width: 52,
                height: 28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Theme.of(context).primaryColor),
                alignment: Alignment.center,
                child: Text(
                  '下一步',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 60,
          ),
          Flexible(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 60,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Checkbox(
                          value: selectList[index],
                          onChanged: (v) {
                            setState(() {
                              selectList[index] = v;
                            });
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                      ),
                      Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                          list[index]['aver'],
                          width: 40,
                          height: 40,
                        )),
                      ),
                      Flexible(child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(list[index]['username']),
                      ))
                    ],
                  ),
                );
              },
              itemCount: list.length,
              physics: BouncingScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }

  void getData() async {
    List<Map> data = await SqliteTool().getAddressList();
    List<Map> dataList = List.from(data);
    dataList.removeAt(0);
    List<bool> dataSelectList = [];
    for (var i in dataList) {
      dataSelectList.add(false);
    }
    setState(() {
      list = dataList;
      selectList = dataSelectList;
    });
  }
}
