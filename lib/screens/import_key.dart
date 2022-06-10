import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rsa_text_encryption/home/home_screen.dart';
import 'package:rsa_text_encryption/models/my_key_model.dart';
import 'package:rsa_text_encryption/models/others_key.dart';
import 'package:rsa_text_encryption/services/storage_service.dart';

class ImportKeyScreen extends StatefulWidget {
  @override
  _ImportKeyScreenState createState() => _ImportKeyScreenState();
}

class _ImportKeyScreenState extends State<ImportKeyScreen> {
  OthersKey secItem;
  TextEditingController publicController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();

  StorageService storageService = StorageService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          dividerTheme: DividerThemeData(color: Colors.white, thickness: 2)),
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
            title: Text("IMPORT PUBLIC KEY"),
            backgroundColor: Color(0xFF6200EE),
            shadowColor: Colors.grey,
            elevation: 10,
            centerTitle: true,
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
                        "IMPORT PUBLIC KEY FILE",
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
                        child: TextField(
                          maxLines: null,
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
                          ),
                          controller: publicController,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: TextFormField(
                          controller: usernameController,
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
                          Row(
                            children: <Widget>[
                              /*Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    border: Border.all(color: Colors.grey)),
                                child: Text(
                                  "PASTE",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                              ),*/
                              GestureDetector(
                                onTap: () async
                                {
                                  FilePickerResult result =
                                      await FilePicker.platform.pickFiles(
                                          allowedExtensions: ['txt'],
                                          type: FileType.custom);

                                  if (result != null) {
                                    File file = File(result.files.single.path);
                                    Map<String, dynamic> data = json.decode(
                                        (await file.readAsString(
                                            encoding: Encoding.getByName(
                                                "US-ASCII"))));
                                    secItem = OthersKey.fromJsonEncodable(data);
                                    print(data);
                                    publicController.text = secItem.publickey;
                                    usernameController.text = secItem.name;
                                    setState(() {});
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      border: Border.all(color: Colors.grey)),
                                  child: Text(
                                    "OPEN",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 17),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              if (usernameController.text.isNotEmpty && publicController.text.isNotEmpty) {
                                storageService.addOtherKey(OthersKey(publickey: publicController.text, name: usernameController.text));

                                Fluttertoast.showToast(
                                    msg: "Key added in storage successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);

                                Navigator.pop(context,true);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please Open key file first",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  border: Border.all(color: Colors.grey)),
                              child: Text(
                                "SAVE",
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
}
