import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:openpgp/openpgp.dart';
import 'package:rsa_text_encryption/models/my_key_model.dart';
import 'package:rsa_text_encryption/models/others_key.dart';
import 'package:rsa_text_encryption/screens/create_key_screen.dart';
import 'package:rsa_text_encryption/screens/export_key.dart';
import 'package:rsa_text_encryption/screens/import_key.dart';
import 'package:rsa_text_encryption/screens/public_key_qr_one.dart';
import 'package:rsa_text_encryption/screens/scan_public_key.dart';
import 'package:rsa_text_encryption/screens/settings.dart';
import 'package:rsa_text_encryption/screens/upgrade_screen.dart';
import 'package:rsa_text_encryption/services/storage_service.dart';
import 'package:share/share.dart';
import '../global/globals.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  bool isUpgraded = false;

  MyKey selectedMyKey;
  OthersKey selectedOthersKey;
  TextEditingController _Eplaintextcontroller = new TextEditingController();
  TextEditingController _Eciphertextcontroller = new TextEditingController();
  TextEditingController _Dplaintextcontroller = new TextEditingController();
  TextEditingController _Dciphertextcontroller = new TextEditingController();
  TextEditingController _Dpassphrasetextcontroller =
      new TextEditingController();

  StorageService storageService = StorageService();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  MyKeyList myKeyList = new MyKeyList();
  OthersKeyList othersKeyList = new OthersKeyList();

  loadData() {
    List<MyKey> items = storageService.getMyKeys();
    if (items != null) {
      myKeyList = new MyKeyList();
      selectedMyKey = items.first;
      myKeyList.items = items;
      setState(() {});
    }
    List<OthersKey> itemsOthers = storageService.getOthersKeys();
    if (itemsOthers != null) {
      othersKeyList = new OthersKeyList();
      selectedOthersKey = itemsOthers.first;
      othersKeyList.items = itemsOthers;
      setState(() {});
    }
  }

  void onSelected(BuildContext context, int item, MyKey selectedKey) {
    switch (item) {
      case 0:
        selectedKey == null
            ? Fluttertoast.showToast(
                msg: "Please select key first",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0)
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ExportKeyScreen(
                        selectedKey: OthersKey.fromJsonEncodable(
                            selectedKey.toJSONEncodable())))).then((value) {});
        break;
      case 1:
        selectedKey == null
            ? Fluttertoast.showToast(
                msg: "Please select key first",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0)
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PublicKeyQrOneScreen(
                        otherKey: OthersKey.fromJsonEncodable(
                            selectedKey.toJSONEncodable()))),
              );
        break;
      case 2:
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => ImportKeyScreen()))
            .then((value) {
          if (value == true) {
            loadData();
          }
        });
        break;
      case 3:
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => ScanPublicKeyScreen()))
            .then((value) {
          if (value == true) {
            loadData();
          }
        });
        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateKeyScreen()));
        break;
      case 5:
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsScreen()))
            .then((value) {
          //   if (value == true) {
          loadData();
          //   }
        });
        break;
      case 6:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UpgradeScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          dividerTheme: DividerThemeData(color: Colors.white, thickness: 2)),
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: Builder(builder: (context) {
              return AppBar(
                backgroundColor: Color(0xFF6200EE),
                shadowColor: Colors.grey,
                elevation: 10,
                /* leading: IconButton(
        onPressed: () {
       //   Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          size: 25,
        ),
      ),*/
                centerTitle: true,
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                actions: [
                  PopupMenuButton<int>(
                    color: Color(0XFFE8E8E8),
                    onSelected: (item) =>
                        onSelected(context, item, selectedMyKey),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text(
                          "EXPORT PUBLIC KEY",
                          style:
                              TextStyle(color: Color(0xFF6200EE), fontSize: 17),
                        ),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text(
                          "PUBLIC KEY QR CODE",
                          style:
                              TextStyle(color: Color(0xFF6200EE), fontSize: 17),
                        ),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Text(
                          "IMPORT PUBLIC KEY FILE",
                          style:
                              TextStyle(color: Color(0xFF6200EE), fontSize: 17),
                        ),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        value: 3,
                        child: Text(
                          "SCAN PUBLIC KEY QR",
                          style:
                              TextStyle(color: isUpgraded== true?Color(0xFF6200EE):Colors.grey, fontSize: 17),
                        ),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        value: 4,
                        child: Text(
                          "CREATE NEW PUBLIC KEY",
                          style:
                              TextStyle(color: isUpgraded==true?Color(0xFF6200EE):Colors.grey, fontSize: 17),
                        ),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        value: 5,
                        child: Text(
                          "SETTINGS",
                          style:
                              TextStyle(color: Color(0xFF6200EE), fontSize: 17),
                        ),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        value: 6,
                        child: Text(
                          "UPGRADE TO PRO VERSION",
                          style:
                          TextStyle(color: Colors.red, fontSize: 17),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                                color: selectedTab == 0
                                    ? GlobalColors.purple
                                    : Colors.grey)),
                        child: Text(
                          "ENCRYPTION",
                          style: TextStyle(
                              color: selectedTab == 0
                                  ? GlobalColors.purple
                                  : Colors.grey,
                              fontSize: 17),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                                color: selectedTab == 1
                                    ? GlobalColors.purple
                                    : Colors.grey)),
                        child: Text(
                          "DECRYPTION",
                          style: TextStyle(
                              color: selectedTab == 1
                                  ? GlobalColors.purple
                                  : Colors.grey,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Visibility(
                        visible: selectedTab == 0,
                        maintainState: true,
                        child: SizedBox.expand(
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
                                      controller: _Eplaintextcontroller,
                                      maxLines: null,
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        labelText: "Plain Text",
                                        alignLabelWithHint: true,
                                        labelStyle: TextStyle(
                                            color: GlobalColors.purple),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: GlobalColors.purple,
                                                width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        hintText: "Write Message...",
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                            height: 70,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButtonFormField<
                                                  OthersKey>(
                                                decoration: InputDecoration(
                                                  labelText: "Select key",
                                                  alignLabelWithHint: true,
                                                  labelStyle: TextStyle(
                                                      color:
                                                          GlobalColors.purple),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  GlobalColors
                                                                      .purple,
                                                              width: 2)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  hintText: "Select...",
                                                  hintStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                iconSize: 20,
                                                value: selectedOthersKey,
                                                onChanged: (item) {
                                                  selectedOthersKey = item;
                                                  setState(() {});
                                                },
                                                onTap: () {},
                                                autovalidateMode:
                                                    AutovalidateMode.always,
                                                validator: (text) {
                                                  if (othersKeyList
                                                      .items.isEmpty) {
                                                    return "No Public Key Found";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                iconEnabledColor: Colors.black,
                                                iconDisabledColor: Colors.black,
                                                items: othersKeyList.items
                                                    .map((e) {
                                                  return DropdownMenuItem<
                                                          OthersKey>(
                                                      value: e,
                                                      child: Text(e.name));
                                                }).toList(),
                                              ),
                                            )
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
                          )),*/
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
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  textStyle: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              onPressed: () {
                                                String message =
                                                    _Eplaintextcontroller.text;
                                                //     print(selectedMyKey.name);
                                                if (selectedOthersKey != null) {
                                                  OpenPGP.encrypt(
                                                          message,
                                                          selectedOthersKey
                                                              .publickey)
                                                      .then((value) =>
                                                          _Eciphertextcontroller
                                                              .text = value);
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
                                      controller: _Eciphertextcontroller,
                                      maxLines: null,
                                      readOnly: true,
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        labelText: "Cipher Text",
                                        alignLabelWithHint: true,
                                        labelStyle: TextStyle(
                                            color: GlobalColors.purple),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: GlobalColors.purple,
                                                width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        hintText: "Output...",
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(

                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey, width: 1.0)
                                      ),
                                      child:Center(
                                          child: Text("AD SPACE HERE", style: TextStyle(color: Colors.grey),)
                                      )
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (_Eciphertextcontroller
                                                  .text.isNotEmpty) {
                                                FlutterClipboard.copy(
                                                        _Eciphertextcontroller
                                                            .text)
                                                    .then((value) => {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Cipher text is copied",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  Colors.black,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0)
                                                        });
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "No Text Found",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.0,
                                                  vertical: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Text(
                                                "COPY",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (_Eciphertextcontroller
                                                  .text.isNotEmpty) {
                                                Share.share(
                                                    _Eciphertextcontroller
                                                        .text);
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "No Text Found",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.0,
                                                  vertical: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Text(
                                                "SHARE",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _Eciphertextcontroller.text = "";
                                          _Eplaintextcontroller.text = "";
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 8),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Text(
                                            "CLEAR ALL",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 17),
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
                        )),
                    Visibility(
                        visible: selectedTab == 1,
                        maintainState: true,
                        child: SizedBox.expand(
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
                                      controller: _Dciphertextcontroller,
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        labelText: "Cipher Text",
                                        alignLabelWithHint: true,
                                        labelStyle: TextStyle(
                                            color: GlobalColors.purple),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: GlobalColors.purple,
                                                width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        hintText: "Place Cipher Text...",
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
                                              controller:
                                                  _Dpassphrasetextcontroller,
                                              obscureText: true,
                                              textAlign: TextAlign.start,
                                              decoration: InputDecoration(
                                                labelText: "Passphrase",
                                                alignLabelWithHint: true,
                                                labelStyle: TextStyle(
                                                    color: GlobalColors.purple),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: GlobalColors
                                                                .purple,
                                                            width: 2)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                hintText: "****",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                            height: 70,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButtonFormField(
                                                autovalidateMode:
                                                    AutovalidateMode.always,
                                                validator: (text) {
                                                  if (myKeyList.items.isEmpty) {
                                                    return "No Private Key Found";
                                                  } else
                                                    return null;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: "Private key",
                                                  alignLabelWithHint: true,
                                                  labelStyle: TextStyle(
                                                      color:
                                                          GlobalColors.purple),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  GlobalColors
                                                                      .purple,
                                                              width: 2)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  hintText: "Select...",
                                                  hintStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                iconSize: 20,
                                                iconEnabledColor: Colors.black,
                                                iconDisabledColor: Colors.black,
                                                value: selectedMyKey,
                                                onChanged: (item) {
                                                  selectedMyKey = item;
                                                  setState(() {});
                                                },
                                                items: myKeyList.items.map((e) {
                                                  return DropdownMenuItem<
                                                          MyKey>(
                                                      value: e,
                                                      child:
                                                          Text(e.personalname));
                                                }).toList(),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
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

                                            if (DateTime.now().isAfter(
                                                DateFormat("dd-MM-yyyy").parse(
                                                    selectedMyKey
                                                        .expiryDate))) {
                                              Fluttertoast.showToast(
                                                  msg: "Key is expired",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              try {
                                                OpenPGP.decrypt(
                                                        _Dciphertextcontroller
                                                            .text,
                                                        selectedMyKey
                                                            .privatekey,
                                                        _Dpassphrasetextcontroller
                                                            .text)
                                                    .then((value) {
                                                  _Dplaintextcontroller.text =
                                                      value;
                                                });
                                              } catch (ggg) {
                                                Fluttertoast.showToast(
                                                    msg: "Wrong data",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }
                                              Future.delayed(
                                                      Duration(seconds: 2))
                                                  .then((value) {
                                                if (_Dplaintextcontroller
                                                    .text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg: "Wrong data",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.black,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                }
                                              });
                                            }
                                          },
                                          child: Text("DECRYPT")),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                      readOnly: true,
                                      maxLines: null,
                                      controller: _Dplaintextcontroller,
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        labelText: "Plain Text",
                                        alignLabelWithHint: true,
                                        labelStyle: TextStyle(
                                            color: GlobalColors.purple),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: GlobalColors.purple,
                                                width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        hintText: "Decrypted Text...",
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(

                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey, width: 1.0)
                                      ),
                                      child:Center(
                                          child: Text("AD SPACE HERE", style: TextStyle(color: Colors.grey),)
                                      )
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          if (_Dplaintextcontroller
                                              .text.isNotEmpty) {
                                            FlutterClipboard.copy(
                                                    _Dplaintextcontroller.text)
                                                .then((value) => {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Cipher text is copied",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.black,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0)
                                                    });
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "No Text Found",
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
                                              horizontal: 15.0, vertical: 8),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Text(
                                            "COPY",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _Dplaintextcontroller.text = "";
                                          _Dciphertextcontroller.text = "";
                                          _Dpassphrasetextcontroller.text = "";
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 8),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Text(
                                            "CLEAR ALL",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 17),
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
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
