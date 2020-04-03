import 'package:flutter/material.dart';

class ShowNotificationMessage extends StatefulWidget {
  final String messageString;
  ShowNotificationMessage({Key key, this.messageString}) : super(key: key);

  @override
  _ShowNotificationMessageState createState() =>
      _ShowNotificationMessageState();
}

class _ShowNotificationMessageState extends State<ShowNotificationMessage> {
  String msgString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    msgString = widget.messageString;
  }

  Widget showMessage() {
    return Text(msgString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue[900],
          title: Text('Notificagion Message'),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue[900], Colors.white],
                  begin: Alignment(-1, -1))),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                      width: 1.0,
                      color: Colors.grey,
                      style: BorderStyle.solid)),
              margin: EdgeInsets.only(left: 50.0, right: 50.0),
              child: showMessage(),
            ),
          ),
        ));
  }
}