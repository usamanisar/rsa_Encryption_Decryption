import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:openpgp/openpgp.dart';
import 'package:rsa_text_encryption/models/my_key_model.dart';
import 'package:rsa_text_encryption/services/storage_service.dart';
import '../global/globals.dart';

class DecryptionScreen extends StatefulWidget {
  @override
  _DecryptionScreenState createState() => _DecryptionScreenState();
}

class _DecryptionScreenState extends State<DecryptionScreen> {
  MyKeyList list = new MyKeyList();
  MyKey selectedKey;
  TextEditingController _plaintextcontroller = new TextEditingController();
  TextEditingController _ciphertextcontroller = new TextEditingController();
  TextEditingController _passphrasetextcontroller = new TextEditingController();
  final StorageService storageService = new StorageService();

  loadData() {
    List<MyKey> items = storageService.getMyKeys();
    if (items != null) {
      list.items = items;
      setState(() {});
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Expanded(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                TextField(
                    maxLines: null,
                    controller: _ciphertextcontroller,
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
                      hintText: "Plain Text",
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: TextFormField(
                            controller: _passphrasetextcontroller,
                            obscureText: true,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              labelText: "Passphrase",
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
                              hintText: "****",
                              hintStyle: TextStyle(color: Colors.grey),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: "Private key",
                                alignLabelWithHint: true,
                                labelStyle:
                                    TextStyle(color: GlobalColors.purple),
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
                              iconEnabledColor: Colors.black,
                              iconDisabledColor: Colors.black,
                              value: selectedKey,
                              onChanged: (item) {
                                selectedKey = item;
                                setState(() {});
                              },
                              items: list.items.map((e) {
                                return DropdownMenuItem<MyKey>(
                                    value: e, child: Text(e.name));
                              }).toList(),
                            ),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.grey,
                            primary: Color(0xFF6200EE),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            textStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          OpenPGP.decrypt(
                                  _ciphertextcontroller.text,
                                  selectedKey.privatekey,
                                  _passphrasetextcontroller.text)
                              .then(
                                  (value) => _plaintextcontroller.text = value);
                        },
                        child: Text("DECRYPT")),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  readOnly: true,
                    maxLines: null,
                    controller: _plaintextcontroller,
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
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        FlutterClipboard.copy(_plaintextcontroller.text)
                            .then((value) => {
                                  Fluttertoast.showToast(
                                      msg: "Cipher text is copied",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0)
                                });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
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
                    GestureDetector(
                      onTap: () {
                        _plaintextcontroller.text ="";
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
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
      ),
    );
  }
}
