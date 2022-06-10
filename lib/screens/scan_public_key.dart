import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rsa_text_encryption/models/my_key_model.dart';
import 'package:rsa_text_encryption/models/others_key.dart';
import 'package:rsa_text_encryption/services/storage_service.dart';
import '../global/globals.dart';
import '../widgets/widgets.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:typed_data';

class ScanPublicKeyScreen extends StatefulWidget {
  ScanPublicKeyScreen();

  @override
  _ScanPublicKeyScreenState createState() => _ScanPublicKeyScreenState();
}

class _ScanPublicKeyScreenState extends State<ScanPublicKeyScreen> {
  List<Uint8List> qrList = [];
  List<String> qrStringList = [];
  TextEditingController numberController = TextEditingController(text: "1");

  @override
  void initState() {
    // setBarcode();
    qrList.add(null);
    qrStringList.add("");
    super.initState();
  }

  setBarcode() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          dividerTheme: DividerThemeData(color: Colors.white, thickness: 2)),
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: Custom(title: "PUBLIC KEY QR CODE"),
          ),
          body: SingleChildScrollView(scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 15,),
                Text("Add the number of QR CODES",style: TextStyle(
                    color: Colors.black, fontSize: 17),),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        controller: numberController,
                        keyboardType: TextInputType.number,
                      ),
                    )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.grey,
                            primary: Color(0xFF6200EE),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            textStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          int parts = int.parse(numberController.text);
                          qrList = [];
                          qrStringList = [];
                          while (true) {
                            qrList.add(null);

                            qrStringList.add("");
                            parts--;
                            if (parts == 0) {
                              break;
                            }
                          }
                          setState(() {});
                        },
                        child: Text("Generate")),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                      children:qrList.map((e) {
                        return Container(
                          margin: EdgeInsets.all(25.0),
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              //         Spacer(),
                              SizedBox(height: 10,),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                    border: Border.all(color: Colors.grey)),
                                child: Text(
                                  "PART ${qrList.indexOf(e) + 1}/${qrList.length}",
                                  style: TextStyle(
                                      color: GlobalColors.purple, fontSize: 17),
                                ),
                              ),

                              SizedBox(height: 10,),
                              //            Spacer(),
                              e == null
                                  ? Icon(
                                Icons.qr_code_scanner_rounded,
                                size:
                                MediaQuery.of(context).size.width - 100,
                              )
                                  : Image.memory(
                                e,
                                fit: BoxFit.cover,
                                width:
                                MediaQuery.of(context).size.width - 50,
                              ),

                              SizedBox(height: 10,),
                              //           Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                    border: Border.all(color: Colors.grey)),
                                child: Text(
                                  qrList.indexOf(e) == qrList.length - 1
                                      ? "END"
                                      : "Slide to See More",
                                  style: TextStyle(
                                      color: GlobalColors.purple, fontSize: 17),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SizedBox(height: 10,),
                              //           Spacer(),
                              //            Spacer(),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shadowColor: Colors.grey,
                                      primary: Color(0xFF6200EE),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      textStyle: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    _scan(qrList.indexOf(e));
                                  },
                                  child: Text("SCAN PART: ${qrList.indexOf(e) + 1}")),
                              //          Spacer(),
                              //           Spacer(),
                              SizedBox(height: 10,),
                              SizedBox(height: 10,),
                            ],
                          ),
                        );
                      }).toList()
                  ),
                ),
                /*Container(

                  child: ListView.builder(
                      itemCount: qrList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(25.0),
                          width: MediaQuery.of(context).size.width - 50,
                          height: MediaQuery.of(context).size.height - 100,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                     //         Spacer(),
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
                  //            Spacer(),
                              qrList.elementAt(index) == null
                                  ? Icon(
                                      Icons.qr_code_scanner_rounded,
                                      size:
                                          MediaQuery.of(context).size.height / 3,
                                    )
                                  : Image.memory(
                                      qrList.elementAt(index),
                                      fit: BoxFit.cover,
                                      width:
                                          MediaQuery.of(context).size.width - 10,
                                    ),
                   //           Spacer(),
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
                   //           Spacer(),
                  //            Spacer(),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shadowColor: Colors.grey,
                                      primary: Color(0xFF6200EE),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      textStyle: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    _scan(index);
                                  },
                                  child: Text("SCAN PART: ${index + 1}")),
                    //          Spacer(),
                   //           Spacer(),
                            ],
                          ),
                        );
                      }),
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (qrList.any((element) => element == null)) {
                          Fluttertoast.showToast(
                              msg: "Please Scan all parts",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {


                          String key = "";
                          qrStringList.forEach((element) {
                            key = key + element;
                          });
                          StorageService storageService = StorageService();


                          try{
                            storageService.addOtherKey(OthersKey.fromJsonEncodable(jsonDecode(key)));

                            Fluttertoast.showToast(
                                msg: "Key added in storage successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.pop(context,true);
                          } catch (e){
                            Fluttertoast.showToast(
                                msg: "Invalid QR",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }

                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: Colors.grey)),
                        child: Text(
                          "FINISH",
                          style:
                              TextStyle(color: GlobalColors.purple, fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _scan(int index) async {
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      scanner.generateBarCode(barcode).then((value) {
        print(index.toString());
        qrList[index] = value;
        qrStringList[index] = barcode;
        setState(() {});
      });
      // this._outputController.text = item.publickey;
    }
  }
}
