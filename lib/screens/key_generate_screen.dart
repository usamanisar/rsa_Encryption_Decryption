/*
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openpgp/openpgp.dart';


class KeyGenerateScreen extends StatefulWidget {
   String name;
   KeyPair mykeys;
   KeyGenerateScreen({this.mykeys,this.name});


  @override
  _KeyGenerateScreenState createState() => _KeyGenerateScreenState();
}

class _KeyGenerateScreenState extends State<KeyGenerateScreen> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: AppBar(
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
                  "Creating Key Pair...",
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
                  "The process to creating a key pair require large amounts of random numbers.This might take several minutes",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                isLoading ? CircularProgressIndicator(
                  color: Color(0xFF6200EE),
                ):
                Column(
                  children: [
                    Text("Successfully created key pair"),
                    SizedBox(height: 15,),
                    Container(
                      child:
                      ElevatedButton(
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
                            // print(widget.mykeys);
                            Navigator.pushReplacementNamed(context, 'success',
                                 arguments: widget.mykeys
                            );
                          },
                          child: Text("Next",
                          style: TextStyle(
                            fontSize: 17
                          ),)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
 void startTimer() {
    Timer.periodic(const Duration(seconds: 3), (t) {
      setState(() {
        isLoading = false; //set loading to false
      });
      t.cancel(); //stops the timer
    });
  }

}
*/
