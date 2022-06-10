import 'package:flutter/material.dart';
import 'package:rsa_text_encryption/global/globals.dart';
import 'package:rsa_text_encryption/route_generator.dart';
import 'package:rsa_text_encryption/screens/splash_screen.dart';
import 'package:rsa_text_encryption/screens/upgrade_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final _storage = FlutterSecureStorage();
  // List<_SecItem> _items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _readAll();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: GlobalColors.purple,
          accentColor: GlobalColors.purple,
          hintColor: GlobalColors.purple,
          dividerTheme: DividerThemeData(
              color: Colors.white,
              thickness: 2
          )
      ),
      home:   SplashScreen() ,

    );
  }


}


