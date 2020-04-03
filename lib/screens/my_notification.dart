import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyNotification extends StatefulWidget {
  @override
  _MyNotificationState createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {

  // Explicit
  String messageString = "";

  // About Firebase
  FirebaseMessaging firebaseMessageing = new FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // for Firbase
    firebaseMessageing.configure(
        onLaunch: (Map<String, dynamic> message) async {
      print('onLanunch ==> $message');
    }, onResume: (Map<String, dynamic> message) async {
      setState(() {
        print('onResume ==> $message');
      });
    }, onMessage: (Map<String, dynamic> message) async {
      setState(() {
        print('onMessage ==> $message');
      });
    });

    firebaseMessageing.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessageing.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('Ios Setting Registed');
    });

    firebaseMessageing.getToken().then((String value) {
      print('Token ==> $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notification'),
      ),
      body: Text('body'),
    );
  }
}