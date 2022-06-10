// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:openpgp/openpgp.dart';
//
// class SplashNewScreen extends StatefulWidget {
//   @override
//   _SplashNewScreenState createState() => _SplashNewScreenState();
// }
//
// class _SplashNewScreenState extends State<SplashNewScreen> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//       _readAll().then((value)  {
//         if(value.isEmpty){
//           Navigator.pushReplacementNamed(context, 'createkey');
//         }else{
//           Navigator.pushReplacementNamed(context, 'home',arguments: KeyPair(value.first.key,value.first.value));
//         }
//       });
//     });
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(),
//
//         ),
//       );
//   }
//   // Future<List<_SecItem>> _readAll() async {
//   //
//   //   final _storage = FlutterSecureStorage();
//   //   List<_SecItem> _items = [];
//   //   final all = await _storage.readAll();
//   //   _items = all.entries
//   //       .map((entry) => _SecItem(entry.key, entry.value))
//   //       .toList(growable: false);
//   //   return _items;
//   // }
//
// }
// class _SecItem {
//   _SecItem(this.key, this.value);
//
//   final String key;
//   final String value;
//
// }
