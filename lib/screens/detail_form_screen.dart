import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:openpgp/openpgp.dart';
import 'package:rsa_text_encryption/models/my_key_model.dart';
import 'package:rsa_text_encryption/screens/key_success_screen.dart';
import 'package:rsa_text_encryption/services/storage_service.dart';

class DetailFormScreen extends StatefulWidget {
  @override
  _DetailFormScreenState createState() => _DetailFormScreenState();
}

class _DetailFormScreenState extends State<DetailFormScreen> {
  // final _storage = FlutterSecureStorage();
  // final MyKeyList list = new MyKeyList();

  final _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  int selectedRadio;
  bool isChecked = false;
  bool obscureText = true;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passphrasecontroller = new TextEditingController();
  TextEditingController personalNameController = new TextEditingController();
  TextEditingController _datecontroller = new TextEditingController();
  DateTime selectedDate ;

  StorageService storageService = StorageService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          key: _scaffoldkey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: AppBar(
              backgroundColor: Color(0xFF6200EE),
              shadowColor: Colors.grey,
              elevation: 10,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
              ),
            ),
          ),
          body: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20.0),
                    child: Text(
                      "Enter Details",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                        controller: namecontroller,
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
                          hintText: "Your Username/Nickname",
                        )),
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 40),
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Text(
                  //     "Optional",
                  //     textAlign: TextAlign.start,
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter personal name';
                          }
                          return null;
                        },
                        controller: personalNameController,
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
                          hintText: "Personal name(Shown on Decryption page)",
                        )),
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 40),
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Text(
                  //     "Optional/Recommended",
                  //     textAlign: TextAlign.start,
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "RSA",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Color(0xFF6200EE),
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextField(onTap: (){
                  setSelectedRadio(0);
                  setState(() {});
                  },
                      readOnly: true,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: "2048 bits(default)",
                        hintStyle: TextStyle(color: Colors.black),
                        icon: Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 5.0),
                          child: Image.asset(
                            "assets/images/lock.png",
                            width: 35,
                            height: 35,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Radio(
                              value: 0,
                              groupValue: selectedRadio,
                              activeColor: Color(0xFF6200EE),
                              focusColor: Color(0xFF6200EE),
                              onChanged: (val) {
                                print("Radio $val");
                                setSelectedRadio(val);
                                setState(() {});
                              }),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(onTap: (){
                    setSelectedRadio(1);
                    setState(() {});
                  },
                      readOnly: true,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: "3072 bits",
                        hintStyle: TextStyle(color: Colors.black),
                        focusColor: Color(0xFF6200EE),
                        icon: Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 5.0),
                          child: Image.asset(
                            "assets/images/lock.png",
                            width: 35,
                            height: 35,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Radio(
                              value: 1,
                              groupValue: selectedRadio,
                              activeColor: Color(0xFF6200EE),
                              focusColor: Color(0xFF6200EE),
                              onChanged: (val) {
                                print("Radio $val");
                                setSelectedRadio(val);
                                setState(() {});
                              }),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(onTap: (){
                    setSelectedRadio(2);
                    setState(() {});
                  },
                      readOnly: true,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: "4096 bits",
                        hintStyle: TextStyle(color: Colors.black),
                        focusColor: Color(0xFF6200EE),
                        icon: Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 5.0),
                          child: Image.asset(
                            "assets/images/lock.png",
                            width: 35,
                            height: 35,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Radio(
                              value: 2,
                              groupValue: selectedRadio,
                              activeColor: Color(0xFF6200EE),
                              focusColor: Color(0xFF6200EE),
                              onChanged: (val) {
                                print("Radio $val");
                                setSelectedRadio(val);
                                setState(() {});
                              }),
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.only(left: 25, top: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Valid until:",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          checkColor: Colors.white,
                          activeColor: Color(0xFF6200EE),
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value;
                            });
                          }),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _chooseDate(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 15.0, top: 15),
                            child: TextFormField(
                                controller: _datecontroller,
                                enabled: false,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  hintText: "Default not expire",
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter password';
                          } else if (value.length < 8) {
                            return 'Password must be more than 8 characters';
                          }
                          return null;
                        },
                        controller: passphrasecontroller,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          labelText: "Passphrase",
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.greenAccent)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          hintText: "****",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: obscureText == true
                                ? Container(
                                    child: Icon(Icons.visibility_off,
                                        size: 25.0, color: Colors.black),
                                  )
                                : Container(
                                    child: Icon(Icons.visibility,
                                        size: 25.0, color: Colors.black),
                                  ),
                          ),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Re-Enter New Password";
                          } else if (value.length < 8) {
                            return "Password must be more than 8 characters";
                          } else if (value != passphrasecontroller.text) {
                            return "Password do not match as above";
                          } else {
                            return null;
                          }
                        },
                        obscureText: obscureText,autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: "Repeat Passphrase",
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.greenAccent)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          hintText: "*****",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: obscureText == true
                                ? Container(
                                    child: Icon(Icons.visibility_off,
                                        size: 25.0, color: Colors.black),
                                  )
                                : Container(
                                    child: Icon(Icons.visibility,
                                        size: 25.0, color: Colors.black),
                                  ),
                          ),
                        )),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 20.0),
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
                          String name = namecontroller.text;
                          String passphrase = passphrasecontroller.text;
                          String personalname = personalNameController.text;
                          KeyOptions key = KeyOptions();
                          if (selectedRadio == 1) {
                            key.rsaBits = 3072;
                          } else if (selectedRadio == 2) {
                            key.rsaBits = 4096;
                          } else {
                            key.rsaBits = 2048;
                          }
                          Options options = Options();
                          options.name = name;
                          options.passphrase = passphrase;
                          options.keyOptions = key;
                          if (_formkey.currentState.validate()) {
                            if(isChecked){
                              if (selectedDate != null){

                              }
                              else {
                                _scaffoldkey.currentState.showSnackBar(new SnackBar(
                                    content:
                                    new Text("Please select the expiry date")));
                                   return;
                              }
                            }
                            else{
                              selectedDate = DateTime(2100);
                            }

                            _scaffoldkey.currentState.showSnackBar(new SnackBar(
                                content: new Text("Processing Data")));
                            OpenPGP.generate(

                              options: options,
                            ).then((mykeys)
                            {
                              print(mykeys.publicKey);
                              print(options.name);
                              print(selectedDate);
                                MyKey item = new MyKey(
                                    publickey:  mykeys.publicKey,
                                    privatekey: mykeys.privateKey,
                                    name: options.name,
                                    expiryDate:  DateFormat("dd-MM-yyyy").format(selectedDate).toString(),
                                    personalname: personalname);
                                storageService.addMyKey(item);


                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => KeySuccessScreen(
                                            mykey: item,
                                          )));

                              /*
                              Navigator.pushReplacementNamed(context, 'success',
                                 arguments: item
                              );*/
                              // _storage.write(key: mykeys.publicKey, value: mykeys.privateKey, name: options.name).then((value) {
                              //
                              // })
                            });
                          } else {
                            _scaffoldkey.currentState.showSnackBar(new SnackBar(
                                content:
                                    new Text("Please complete all fields")));
                          }
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _chooseDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(2022),
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _datecontroller.text =
            DateFormat("dd-MM-yyyy").format(picked).toString();
      });
  }

  _addItem(
      {String publickey, String privatekey, String name, String personalname}) {
    setState(() {
      MyKey item = new MyKey(
          publickey: publickey,
          privatekey: privatekey,
          name: name,
          personalname: personalname);
      storageService.addMyKey(item);
    });
  }
}
