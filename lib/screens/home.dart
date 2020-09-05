import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:mariealert/screens/authen.dart';
import 'package:mariealert/screens/register.dart';
import 'package:mariealert/screens/show_news_list.dart';
import 'package:mariealert/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit
  String appName = 'Maria Care';
  double mySizeLogo = 130.0, mySizeButton = 180.0;
  Color fontColor = Colors.blue[800];
  bool status = false;

  // Method
  @override
  void initState() {
    super.initState();
    aboutNoti();
    checkStatus();
  }

  Future<Null> aboutNoti() async {
    Firebase.initializeApp().then((value) {
      FirebaseMessaging messaging = FirebaseMessaging();
    messaging.configure(
      onLaunch: (message) {
        print('onLaunch Process');
      },
      onMessage: (message) {
        print('onMessage Process');
      },
      onResume: (message) {
        print('onResume Process');
      },
    );
    });
  }

  Future<void> checkStatus() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool remember = preferences.getBool('Remember');
      print('remember = $remember');

      if (remember) {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => ShowNewsList(),
        );
        Navigator.of(context).pushAndRemoveUntil(route, (value) => false);
      }
    } catch (e) {
      print('e ====> ${e.toString()}');
      setState(() {
        status = true;
      });
    }
  }

  Widget showAppName() {
    return Text(
      appName,
      style: MyStyle().h1WhiteStyle,
    );
  }

  Widget signInButton() {
    return Container(
      width: mySizeButton,
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: MyStyle().textColors,
        child: Text(
          'ลงชื่อเข้าใช้งาน',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          var authenRoute =
              MaterialPageRoute(builder: (BuildContext context) => Authen());
          Navigator.of(context).push(authenRoute);
        },
      ),
    );
  }

  Widget signUpButton() {
    return Container(
      width: mySizeButton,
      child: RaisedButton(
        color: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          'สมัครสมาชิก',
          style: TextStyle(color: MyStyle().textColors),
        ),
        onPressed: () {
          var registerRoute =
              MaterialPageRoute(builder: (BuildContext context) => Register());
          Navigator.of(context).push(registerRoute);
        },
      ),
    );
  }

  Container showContent() {
    return Container(
      decoration: BoxDecoration(gradient: MyStyle().bgGradien()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyStyle().showLogo,
          MyStyle().mySizeBox,
          showAppName(),
          signInButton(),
          signUpButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: status ? showContent() : MyStyle().showProgress(),
    );
  }
}
