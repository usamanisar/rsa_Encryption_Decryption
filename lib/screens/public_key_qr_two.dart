import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global/globals.dart';
import 'public_key_qr_three.dart';
import '../widgets/widgets.dart';


class PublicKeyQrTwoScreen extends StatefulWidget {
  @override
  _PublicKeyQrTwoScreenState createState() => _PublicKeyQrTwoScreenState();
}

class _PublicKeyQrTwoScreenState extends State<PublicKeyQrTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                          "PART 2/3",
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
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PublicKeyQrThreeScreen()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                                  border: Border.all(color: Colors.grey)),
                              child: Text(
                                "NEXT",
                                style:
                                TextStyle(color: GlobalColors.purple, fontSize: 17),
                              ),
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
