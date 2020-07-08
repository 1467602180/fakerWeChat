import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScreenView extends StatefulWidget {
  @override
  _QRScreenViewState createState() => _QRScreenViewState();
}

class _QRScreenViewState extends State<QRScreenView> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController qrcontroller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('扫一扫'),
      ),
      body: QRView(key: qrKey, onQRViewCreated: (controller){
        qrcontroller  = controller;
        controller.scannedDataStream.listen((scanData) {
          showDialog(context: context,builder: (context){
            return AlertDialog(
              title: Text('展示数据'),
              content: Text(scanData),
              actions: <Widget>[
                FlatButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text('确定'))
              ],
            );
          });
        });
      }),
    );
  }
}
