import 'dart:convert';
import 'package:clipboard/clipboard.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rsa_text_encryption/home/home_screen.dart';
import 'package:rsa_text_encryption/models/my_key_model.dart';
import 'package:rsa_text_encryption/models/others_key.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';


class ExportKeyScreen extends StatefulWidget {
  OthersKey selectedKey;
  ExportKeyScreen({this.selectedKey});
  @override
  _ExportKeyScreenState createState() => _ExportKeyScreenState();
}

class _ExportKeyScreenState extends State<ExportKeyScreen> {
  TextEditingController _ciphertextcontroller = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  void initState() {
 //   requestPermission();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        dividerTheme: DividerThemeData(
          color: Colors.white,
          thickness: 2
        )
      ),
      home: SafeArea(
        child: Scaffold(

          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> HomeScreen()), (Route<dynamic> route) => false);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 25,
              ),
            ),
            title: Text("EXPORT PUBLIC KEY"), backgroundColor: Color(0xFF6200EE),
            shadowColor: Colors.grey,
            elevation: 10,centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(25.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "EXPORT PUBLIC KEY",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF6200EE),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 1.55,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: TextFormField(
                         // controller: _ciphertextcontroller,
                          initialValue: widget.selectedKey.publickey,
                            maxLines: null,
                            readOnly: true,
                            enableInteractiveSelection: true,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          hintText: "tx+RGi7N2lUbp728MXGwdnL9od4",
                        )),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: TextFormField(
                        //  controller: usernameController,
                            initialValue: widget.selectedKey.name,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: "Username",
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              FlutterClipboard.copy(widget.selectedKey.publickey).then((value) => {
                                Fluttertoast.showToast(
                                    msg: "Cipher text is copied",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                )
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  border: Border.all(color: Colors.grey)),
                              child: Text(
                                "COPY",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Share.share(widget.selectedKey.publickey);

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  border: Border.all(color: Colors.grey)),
                              child: Text(
                                "SHARE",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              saveFile(_ciphertextcontroller.text).then((value){
                                Fluttertoast.showToast(
                                    msg: "Downloaded",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              });

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  border: Border.all(color: Colors.grey)),
                              child: Text(
                                "DOWNLOAD",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 /* Future<String> _getPathToDownload() async {
    return ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
  }*/
  Future<String> getFilePath() async {

    await Permission.storage.request();
    String filePath;
    if(Platform.isAndroid){
       filePath = "/storage/emulated/0/Download/${widget.selectedKey.name}-public-key.txt";


    }
    else {
      Directory appDocumentsDirectory = await getDownloadsDirectory(); // 1
      String appDocumentsPath = appDocumentsDirectory.path; // 2
       filePath = '$appDocumentsPath${widget.selectedKey.name}/public-key.txt'; // 3
    }

    return filePath;
  }
 /* void requestPermission() {
    PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }*/

  Future<File> saveFile(String cypherText) async {
    File file = File(await getFilePath()); // 1

    file.openWrite().write(jsonEncode(widget.selectedKey.toJSON())); // 2
  }
}
