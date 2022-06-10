import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rsa_text_encryption/home/home_screen.dart';
import '../screens/create_key_screen.dart';
import '../screens/export_key.dart';
import '../screens/import_key.dart';
import '../screens/public_key_qr_one.dart';
import '../screens/scan_public_key.dart';
import '../screens/settings.dart';
import 'package:flutter/services.dart';



class Custom extends StatefulWidget {
  String title;
  BuildContext context;

  Custom({this.title, this.context});

  @override
  _CustomState createState() => _CustomState();
}

class _CustomState extends State<Custom> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF6200EE),
      shadowColor: Colors.grey,
      elevation: 10,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context)
              .pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> HomeScreen()), (Route<dynamic> route) => false);
        },
        icon: Icon(
          Icons.arrow_back,
          size: 25,
        ),
      ),
      centerTitle: true,
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
     /* actions: [
        PopupMenuButton<int>(
          color: Color(0XFFE8E8E8),
          onSelected: (item) => onSelected(context, item),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              value: 0,
              child: Text(
                "EXPORT PUBLIC KEY",
                style: TextStyle(color: Color(0xFF6200EE), fontSize: 17),
              ),
            ),
            PopupMenuDivider(),
            PopupMenuItem<int>(
              value: 1,
              child: Text(
                "PUBLIC KEY QR CODE",
                style: TextStyle(color: Color(0xFF6200EE), fontSize: 17),
              ),
            ),
            PopupMenuDivider(),
            PopupMenuItem<int>(
              value: 2,
              child: Text(
                "IMPORT PUBLIC KEY FILE",
                style: TextStyle(color: Color(0xFF6200EE), fontSize: 17),
              ),
            ),
            PopupMenuDivider(),
            PopupMenuItem<int>(
              value: 3,
              child: Text(
                "SCAN PUBLIC KEY QR",
                style: TextStyle(color: Color(0xFF6200EE), fontSize: 17),
              ),
            ),
            PopupMenuDivider(),
            PopupMenuItem<int>(
              value: 4,
              child: Text(
                "CREATE NEW PUBLIC KEY",
                style: TextStyle(color: Color(0xFF6200EE), fontSize: 17),
              ),
            ),
            PopupMenuDivider(),
            PopupMenuItem<int>(
              value: 5,
              child: Text(
                "SETTINGS",
                style: TextStyle(color: Color(0xFF6200EE), fontSize: 17),
              ),
            ),
          ],
        )
      ],*/
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ExportKeyScreen()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PublicKeyQrOneScreen()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ImportKeyScreen()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ScanPublicKeyScreen()));
        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateKeyScreen()));
        break;
      case 5:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsScreen()));
        break;
    }
  }
}
class CopyIconButton extends StatelessWidget {
  const CopyIconButton({
     this.clipboardDataText, this.alertText, this.iconSize,
  });

  final String clipboardDataText;
  final String alertText;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: iconSize,
        onPressed: () {
          Clipboard.setData(ClipboardData(text: clipboardDataText)).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  alertText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black,
                  fontSize: 14.0),
                ),
                backgroundColor: Colors.transparent,
              ),
            );
          });
        },
        icon: Icon(Icons.copy));
  }
}
