import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rsa_text_encryption/models/my_key_model.dart';
import 'package:rsa_text_encryption/models/others_key.dart';
import 'package:rsa_text_encryption/screens/splash_screen.dart';
import '../global/globals.dart';
import '../widgets/widgets.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class PublicKeyQrOneScreen extends StatefulWidget {
  OthersKey otherKey;

  PublicKeyQrOneScreen({this.otherKey});

  @override
  _PublicKeyQrOneScreenState createState() => _PublicKeyQrOneScreenState();
}

class _PublicKeyQrOneScreenState extends State<PublicKeyQrOneScreen> {
  List<Uint8List> qrList = [];

  @override
  void initState() {
    setBarcode();
    super.initState();
  }

  setBarcode() async {
    /*Stream<NDEFMessage> stream = NFC.readNDEF();

    stream.listen((NDEFMessage message) {
      print("records: ${message.records.length}");
    });
*/
    /*scanner.generateBarCode(jsonEncode(widget.myKey.toJSONEncodable())).then((value){
      setState(() {
        result = value;
      });
    });*/
    int length = jsonEncode(widget.otherKey.toJSONEncodable()).length + 50;
    Map<String, dynamic> map = {"length": length};
    map.addAll(widget.otherKey.toJSONEncodable());
    List<String> qrList = getQRcodes(length, map);
  }

  getQRcodes(int length, Map<String, dynamic> map) {
    List<String> myList = [];
    String data = jsonEncode(map);
    List<String> list = getSub(data, myList);
    list.forEach((element) {
      scanner.generateBarCode(element).then((value) {
        setState(() {
          qrList.add(value);
        });
      });
    });
  }

  List<String> getSub(String data, List<String> list) {
    if (data.length < 1000) {
      list.add(data.substring(0, data.length));
      return list;
    } else {
      list.add(data.substring(0, 1000));
      List<String> myList = getSub(data.substring(1000, data.length), list);

      return myList;
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          dividerTheme: DividerThemeData(color: Colors.white, thickness: 2)),
      home: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: Builder(builder: (context) {
              return Custom(
                title: "PUBLIC KEY QR CODE",
                context: context,
              );
            }),
          ),
          body: ListView.builder(
              itemCount: qrList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(25.0),
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.height - 100,
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: Colors.grey)),
                        child: Text(
                          "PART ${index + 1}/${qrList.length}",
                          style: TextStyle(
                              color: GlobalColors.purple, fontSize: 17),
                        ),
                      ),
                      Spacer(),
                      Image.memory(
                        qrList.elementAt(index),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width - 10,
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: Colors.grey)),
                        child: Text(
                          index == qrList.length - 1
                              ? "END"
                              : "Slide to See More",
                          style: TextStyle(
                              color: GlobalColors.purple, fontSize: 17),
                        ),
                      ),
                      Spacer(),
                      Spacer(),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
