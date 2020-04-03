import 'package:flutter/material.dart';
import 'package:mariealert/screens/edit_my_sql.dart';
import 'package:mariealert/screens/home.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Field
  Map<int, Color> color = {
    50: Color.fromRGBO(1, 50, 255, 0.1),
    100: Color.fromRGBO(1, 50, 255, 0.2),
    200: Color.fromRGBO(1, 50, 255, 0.3),
    300: Color.fromRGBO(1, 50, 255, 0.4),
    400: Color.fromRGBO(1, 50, 255, 0.5),
    500: Color.fromRGBO(1, 50, 255, 0.6),
    600: Color.fromRGBO(1, 50, 255, 0.7),
    700: Color.fromRGBO(1, 50, 255, 0.8),
    800: Color.fromRGBO(1, 50, 255, 0.9),
    900: Color.fromRGBO(1, 50, 255, 1.0)
  };

  @override
  Widget build(BuildContext context) {

    MaterialColor materialColor = MaterialColor(0xff0a32e1, color);


    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.orange));

    return MaterialApp(
      theme: ThemeData(primarySwatch: materialColor),
      title: 'Marie Alert',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}