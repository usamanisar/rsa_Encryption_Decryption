import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rsa_text_encryption/home/home_screen.dart';
import 'package:rsa_text_encryption/models/my_key_model.dart';
import 'package:rsa_text_encryption/models/others_key.dart';
import 'package:rsa_text_encryption/screens/public_key_qr_one.dart';
import 'package:share/share.dart';

import '../widgets/widgets.dart';

import 'detail_form_screen.dart';

class KeySuccessScreen extends StatefulWidget {
  MyKey mykey;

  KeySuccessScreen({this.mykey});

  @override
  _KeySuccessScreenState createState() => _KeySuccessScreenState();
}

class _KeySuccessScreenState extends State<KeySuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          dividerTheme: DividerThemeData(color: Colors.white, thickness: 2)),
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: Custom(title: ""),
          ),
          body: Container(
            margin: EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Key Pair Successfully Created",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                shadowColor: Colors.grey,
                                primary: Color(0xFF6200EE),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              File file = File((await getFilePath())+"-public-key.txt"); // 1
                              print(jsonEncode(widget.mykey.toJSON()));
                              File file1 = File((await getFilePath())+"-private-key.txt"); // 1
                              print(jsonEncode(widget.mykey.toJSON()));
                              file.openWrite().write(jsonEncode(OthersKey.fromJsonEncodable(widget.mykey.toJSONEncodable()).toJSON()));
                              file1.openWrite().write(jsonEncode(widget.mykey.toJSON()));
                              Fluttertoast.showToast(
                                  msg: "Key Saved to Downloads",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  Icons.save_alt_sharp,
                                  size: 25,
                                ),
                                Text("BACKUP KEY PAIR"),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: 25),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                shadowColor: Colors.grey,
                                primary: Color(0xFF6200EE),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Share.share(
                                  widget.mykey.publickey);
                              // will be back in 5 minuteds
                              //why :(
                              //akar btata
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  Icons.share,
                                  size: 25,
                                ),
                                Text("SHARE PUBLIC KEY"),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: 25),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                shadowColor: Colors.grey,
                                primary: Color(0xFF6200EE),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PublicKeyQrOneScreen(
                                              otherKey: OthersKey.fromJsonEncodable(widget.mykey.toJSONEncodable()))));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  Icons.qr_code_scanner_sharp,
                                  size: 25,
                                ),
                                Text("QR PUBLIC KEY"),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> HomeScreen()), (Route<dynamic> route) => false);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: Colors.grey)),
                          child: Text(
                            "FINISH",
                            style: TextStyle(
                                color: Color(0xFF6200EE), fontSize: 17),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getFilePath() async {

    await Permission.storage.request();
    String filePath;
    if(Platform.isAndroid){
      filePath = "/storage/emulated/0/Download/${widget.mykey.name}";


    }
    else {
      Directory appDocumentsDirectory = await getDownloadsDirectory(); // 1
      String appDocumentsPath = appDocumentsDirectory.path; // 2
      filePath = '$appDocumentsPath/${widget.mykey.name}'; // 3
    }

    return filePath;
  }
}
