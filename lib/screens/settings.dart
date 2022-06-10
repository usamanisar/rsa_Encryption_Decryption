import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rsa_text_encryption/global/globals.dart';
import 'package:rsa_text_encryption/models/my_key_model.dart';
import 'package:rsa_text_encryption/models/others_key.dart';
import 'package:rsa_text_encryption/services/storage_service.dart';
import '../widgets/widgets.dart';
import 'export_key.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  StorageService storageService = StorageService();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  MyKeyList list = new MyKeyList();
  OthersKeyList otherKeylist = new OthersKeyList();

  loadData() {
    List<MyKey> items = storageService.getMyKeys();
    if (items != null) {
      list.items = items;
      setState(() {});
    }
    List<OthersKey> items2 = storageService.getOthersKeys();
    if (items2 != null) {
      otherKeylist.items = items2;
      setState(() {});
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
            child: Custom(title: "SETTINGS"),
          ),
          body: Container(
            margin: EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "SETTINGS",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF6200EE),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Your keys",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: list.items.length,
                    itemBuilder: (BuildContext context, index) {
                      MyKey itemname = list.items.elementAt(index);
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExportKeyScreen(
                                      selectedKey: OthersKey.fromJsonEncodable(
                                          itemname.toJSONEncodable())))).then((value) {});
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              // border: Border.all(color: Colors.grey[300],width: 2),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[400],
                                    blurRadius: 8,
                                    spreadRadius: 0.5)
                              ]),
                          child: ListTile(
                              // leading: Icon(Icons.list),
                              trailing: TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext alertContext) =>
                                          AlertDialog(
                                            actionsPadding: EdgeInsets.symmetric(
                                                horizontal: 40),
                                            elevation: 20,
                                            title: Text("Are you sure?"),
                                            content: Text("Delete Key Pair?"),
                                            actions: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(alertContext);
                                                  },
                                                  child: Text(
                                                    "No",
                                                    style: TextStyle(
                                                        color: GlobalColors.purple,
                                                        fontSize: 17),
                                                  )),
                                              FlatButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (list.items.length == 0) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Last key cannot be deleted",
                                                            toastLength:
                                                                Toast.LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity.BOTTOM,
                                                            timeInSecForIosWeb: 1,
                                                            backgroundColor:
                                                                Colors.black,
                                                            textColor: Colors.white,
                                                            fontSize: 16.0);
                                                      } else {

                                                        storageService.deleteMyKey(
                                                            index
                                                        );
                                                        loadData();
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Key deleted successfully",
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

                                                    Navigator.pop(alertContext);
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                        color: GlobalColors.purple,
                                                        fontSize: 17),
                                                  )),
                                            ],
                                          ),
                                      barrierDismissible: true);
                                },
                                child: Text(
                                  "DELETE",
                                  style: TextStyle(
                                      color: GlobalColors.purple, fontSize: 15),
                                ),
                              ),
                              title: Text(itemname.name)),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Recipient keys",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: otherKeylist.items.length,
                    itemBuilder: (BuildContext context, index) {
                      OthersKey itemname = otherKeylist.items.elementAt(index);
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExportKeyScreen(
                                      selectedKey: itemname))).then((value) {});
                        },
                        child: Container(
                          margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              // border: Border.all(color: Colors.grey[300],width: 2),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[400],
                                    blurRadius: 8,
                                    spreadRadius: 0.5)
                              ]),
                          child: ListTile(
                            // leading: Icon(Icons.list),
                              trailing: TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext alertContext) =>
                                          AlertDialog(
                                            actionsPadding: EdgeInsets.symmetric(
                                                horizontal: 40),
                                            elevation: 20,
                                            title: Text("Are you sure?"),
                                            content: Text("Delete Public Key?"),
                                            actions: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(alertContext);
                                                  },
                                                  child: Text(
                                                    "No",
                                                    style: TextStyle(
                                                        color: GlobalColors.purple,
                                                        fontSize: 17),
                                                  )),
                                              FlatButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (otherKeylist.items.length == 0) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                            "Last key cannot be deleted",
                                                            toastLength:
                                                            Toast.LENGTH_SHORT,
                                                            gravity:
                                                            ToastGravity.BOTTOM,
                                                            timeInSecForIosWeb: 1,
                                                            backgroundColor:
                                                            Colors.black,
                                                            textColor: Colors.white,
                                                            fontSize: 16.0);
                                                      } else {

                                                        storageService.deleteOthersKey(
                                                            index);
                                                        loadData();
                                                        Fluttertoast.showToast(
                                                            msg:
                                                            "Key deleted successfully",
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
                                                    Navigator.pop(alertContext);
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                        color: GlobalColors.purple,
                                                        fontSize: 17),
                                                  )),
                                            ],
                                          ),
                                      barrierDismissible: true);
                                },
                                child: Text(
                                  "DELETE",
                                  style: TextStyle(
                                      color: GlobalColors.purple, fontSize: 15),
                                ),
                              ),
                              title: Text(itemname.name)),
                        ),
                      );
                    },
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
