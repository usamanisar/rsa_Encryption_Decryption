import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rsa_text_encryption/global/globals.dart';
import 'package:rsa_text_encryption/home/home_screen.dart';
import 'package:rsa_text_encryption/models/my_key_model.dart';
import 'package:rsa_text_encryption/models/others_key.dart';
import 'package:rsa_text_encryption/services/storage_service.dart';
import 'package:rsa_text_encryption/widgets/widgets.dart';

import 'detail_form_screen.dart';
import 'key_generate_screen.dart';
import 'key_success_screen.dart';

class UpgradeScreen extends StatefulWidget {
  @override
  _UpgradeScreenState createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  StorageService storageService = StorageService();
  @override
  Widget build(BuildContext context) {
    var _height =  MediaQuery.of(context).size.height;
    var _width =  MediaQuery.of(context).size.width;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: Custom(title: "UPGRADE"),
          ),
          body: Container(
            margin: EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _height/10,
                ),
                Text(
                  "WHY PRO:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color:GlobalColors.purple,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Unlimited Private keys",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "Unlimited Recipient keys",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "Import Existing keys",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "QR Scanner",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "More privacy - NO ADS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "Work Completely without internet connection",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(
                  height: _height/8,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),

                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          shadowColor: Colors.grey,
                          primary: Color(0xFF6200EE),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          textStyle: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {

                        //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailFormScreen() ));


                      },
                      child: Text("UPGRADE NOW"),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
