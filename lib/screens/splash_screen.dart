import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rsa_text_encryption/home/home_screen.dart';
import 'package:rsa_text_encryption/models/my_key_model.dart';
import 'package:rsa_text_encryption/screens/create_key_screen.dart';
import 'package:rsa_text_encryption/services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final MyKeyList list = new MyKeyList();
  bool initialized = false;

  StorageService storageService = StorageService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      storageService.keyStorage.ready.then((value) {
        var items = storageService.getMyKeys();

        if (items != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()), );
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CreateKeyScreen()), );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
