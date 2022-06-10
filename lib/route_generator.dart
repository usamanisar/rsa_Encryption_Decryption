import 'package:flutter/material.dart';
import 'package:rsa_text_encryption/home/home_screen.dart';
import 'package:rsa_text_encryption/screens/create_key_screen.dart';
import 'package:rsa_text_encryption/screens/detail_form_screen.dart';
import 'package:rsa_text_encryption/screens/export_key.dart';
import 'package:rsa_text_encryption/screens/import_key.dart';
import 'package:rsa_text_encryption/screens/key_generate_screen.dart';
import 'package:rsa_text_encryption/screens/key_success_screen.dart';
import 'package:rsa_text_encryption/screens/public_key_qr_one.dart';
import 'package:rsa_text_encryption/screens/public_key_qr_three.dart';
import 'package:rsa_text_encryption/screens/public_key_qr_two.dart';
import 'package:rsa_text_encryption/screens/qrfile.dart';
import 'package:rsa_text_encryption/screens/scan_public_key.dart';
import 'package:rsa_text_encryption/screens/settings.dart';
import 'package:rsa_text_encryption/screens/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
        break;

      case 'home':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            // mykeys: args,

          ));
        break;

      case 'createkey':
        return MaterialPageRoute(builder: (_) => CreateKeyScreen());
        break;

      /*case 'generatekey':
        return MaterialPageRoute(builder: (_) => KeyGenerateScreen(
          // mykeys: args,


        ));
        break;*/

      case 'detailform':
          return MaterialPageRoute(
            builder: (_) => DetailFormScreen(
            ),
          );

        break;
        case 'exportkey':
        return MaterialPageRoute(builder: (_) => ExportKeyScreen());
        break;
        case 'importkey':
        return MaterialPageRoute(builder: (_) => ImportKeyScreen());
        break;

      case 'success':
        return MaterialPageRoute(builder: (_) => KeySuccessScreen(
          mykey:args,
         ));
        break;

      case 'qrone':
        return MaterialPageRoute(builder: (_) => PublicKeyQrOneScreen());
        break;

      case 'qrtwo':
        return MaterialPageRoute(builder: (_) => PublicKeyQrTwoScreen());
        break;

      case 'qrthree':
        return MaterialPageRoute(builder: (_) => PublicKeyQrThreeScreen());
        break;

      case 'qr':
        return MaterialPageRoute(builder: (_) => QrFileScreen());
        break;

      case 'scan':
        return MaterialPageRoute(builder: (_) => ScanPublicKeyScreen());
        break;

      case 'settings':
        return MaterialPageRoute(builder: (_) => SettingsScreen());

        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
