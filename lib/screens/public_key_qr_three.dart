import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global/globals.dart';
import '../widgets/widgets.dart';


class PublicKeyQrThreeScreen extends StatefulWidget {
  @override
  _PublicKeyQrThreeScreenState createState() => _PublicKeyQrThreeScreenState();
}

class _PublicKeyQrThreeScreenState extends State<PublicKeyQrThreeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          dividerTheme: DividerThemeData(
              color: Colors.white,
              thickness: 2
          )
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: Custom(
                title:  "PUBLIC KEY QR CODE"
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(25.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: Colors.grey)),
                        child: Text(
                          "PART 3/3",
                          style:
                          TextStyle(color: GlobalColors.purple, fontSize: 17),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.qr_code_scanner_rounded,
                        size: MediaQuery.of(context).size.height/3,),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(color: Colors.grey)),
                            child: Text(
                              "FINISH",
                              style:
                              TextStyle(color: GlobalColors.purple, fontSize: 17),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
