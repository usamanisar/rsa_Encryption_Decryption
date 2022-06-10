/*
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:openpgp/openpgp.dart';
import 'package:rsa_text_encryption/screens/splash_screen.dart';
import 'package:share/share.dart';
import '../global/globals.dart';

class EncryptionScreen extends StatefulWidget {
  KeyPair mykeys;
  String name;
  EncryptionScreen({this.mykeys});

  @override
  _EncryptionScreenState createState() => _EncryptionScreenState();
}

class _EncryptionScreenState extends State<EncryptionScreen> {
  TextEditingController _plaintextcontroller = new TextEditingController();
  TextEditingController _ciphertextcontroller = new TextEditingController();

  final LocalStorage storage = new LocalStorage('keys');

  @override
  void initState() {
    loadData();

    super.initState();
  }

  SecItemList list = new SecItemList();

  loadData() {
    int i = 0;
    var items = storage.getItem('allkeys');
    if (items != null) {
      list.items = List<SecItem>.from(
        (items as List).map(
          (item) => SecItem(
              publickey: item['publickey'],
              privatekey: item['privatekey'],
              name: item['name']),
        ),
      );
      setState(() {});
    }
  }

  SecItem selectedKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        margin: EdgeInsets.all(
          15.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: _plaintextcontroller,
                  maxLines: null,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    labelText: "Plain Text",
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(color: GlobalColors.purple),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: GlobalColors.purple, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "Input Text...",
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child:
                    Container(
                        height: 70,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<SecItem>(
                            decoration: InputDecoration(
                              labelText: "Select key",
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(color: GlobalColors.purple),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: GlobalColors.purple, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: "Select...",
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                            iconSize: 20,
                            value: selectedKey,
                            onChanged: (item) {
                              selectedKey = item;
                              setState(() {});
                            },
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.black,
                            items: list.items.map((e) {
                              return DropdownMenuItem<SecItem>(
                                  value: e, child: Text(e.name));
                            }).toList(),
                          ),
                        )
                        */
/*TextField(
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            labelText: "Add Recipient",
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(color: GlobalColors.purple),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: GlobalColors.purple, width: 2)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintText: "Select...",
                            hintStyle: TextStyle(color: Colors.black),
                            suffix: ,
                          )),*//*

                        ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50,
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
                            String message = _plaintextcontroller.text;
                            if (selectedKey != null) {
                              OpenPGP.encrypt(message, selectedKey.publickey)
                                  .then((value) =>
                                      _ciphertextcontroller.text = value);
                            }
                          },
                          child: Text("ENCRYPT")),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: _ciphertextcontroller,
                  maxLines: null,
                  readOnly: true,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    labelText: "Cipher Text",
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(color: GlobalColors.purple),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: GlobalColors.purple, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "Input Text...",
                  )),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          FlutterClipboard.copy(_ciphertextcontroller.text).then((value) => {
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
                              horizontal: 15.0, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: Colors.grey)),
                          child: Text(
                            "COPY",
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share(_ciphertextcontroller.text);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: Colors.grey)),
                          child: Text(
                            "SHARE",
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _ciphertextcontroller.text = "";
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(color: Colors.grey)),
                      child: Text(
                        "CLEAR ALL",
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
