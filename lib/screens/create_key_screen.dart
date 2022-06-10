import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rsa_text_encryption/home/home_screen.dart';
import 'package:rsa_text_encryption/models/my_key_model.dart';
import 'package:rsa_text_encryption/models/others_key.dart';
import 'package:rsa_text_encryption/screens/upgrade_screen.dart';
import 'package:rsa_text_encryption/services/storage_service.dart';

import 'detail_form_screen.dart';
import 'key_generate_screen.dart';
import 'key_success_screen.dart';

class CreateKeyScreen extends StatefulWidget {
  @override
  _CreateKeyScreenState createState() => _CreateKeyScreenState();
}

class _CreateKeyScreenState extends State<CreateKeyScreen> {
  StorageService storageService = StorageService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: AppBar(
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
              backgroundColor: Color(0xFF6200EE),
              shadowColor: Colors.grey,
              elevation: 10,
            ),
          ),
          body: Container(
            margin: EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  "The private key is need to decrypt or sign.",
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
                  "The public key can be used by others to verify your identity or encrypt to you.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
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

                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailFormScreen() ));


                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            size: 25,
                          ),
                          Text("CREATE NEW KEY PAIR"),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () async
                    {
                      showAlertDialog(context);
                     /* FilePickerResult result =
                      await FilePicker.platform.pickFiles(
                          allowedExtensions: ['txt'],
                          type: FileType.custom);

                      if (result != null) {

                        try{

                          File file = File(result.files.single.path);
                        Map<String, dynamic> data = json.decode(
                            (await file.readAsString(
                                encoding: Encoding.getByName(
                                    "US-ASCII"))));
                          if(data['personalname'] != null){
                           var  secItem = MyKey.fromJsonEncodable(data);
                            print(data);
                           storageService.addMyKey(secItem);
                           Fluttertoast.showToast(
                               msg: "Key added in storage successfully",
                               toastLength: Toast.LENGTH_SHORT,
                               gravity: ToastGravity.BOTTOM,
                               timeInSecForIosWeb: 1,
                               backgroundColor: Colors.black,
                               textColor: Colors.white,
                               fontSize: 16.0);
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => KeySuccessScreen(
                                     mykey: secItem,
                                   )));

                          }
                          else{
                            Fluttertoast.showToast(
                                msg: "Invalid personal key",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }

                        } catch (e){
                          Fluttertoast.showToast(
                              msg: "Invalid personal key",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }


                      } else {
                        // User canceled the picker
                      }*/
                    },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: Colors.grey)),
                    child: Text(
                      "IMPORT",
                      style: TextStyle(color: Colors.grey, fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget closeButton = TextButton(
      child: Text("CLOSE"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget upgradeButton = TextButton(
      child: Text("UPGRADE"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UpgradeScreen()), );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Upgrade to Pro version"),
      actions: [
        upgradeButton,
        closeButton,


      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
