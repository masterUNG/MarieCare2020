import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mariealert/screens/home.dart';
import 'package:mariealert/utility/my_constant.dart';
import 'package:mariealert/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news_model.dart';
import '../models/noti_model.dart';
import '../models/user_model.dart';
import '../listviews/news_listview.dart';
import 'dart:async';
import './show_children_list.dart';
import './add_children.dart';

class ShowNewsList extends StatefulWidget {
  @override
  _ShowNewsListState createState() => _ShowNewsListState();
}

class _ShowNewsListState extends State<ShowNewsList> {
  String titleAppbar = 'ข่าวสาร น่ารู้';
  String titleTooltip = 'ออกจากผู้ใช้';
  String titleNotification = 'ข้อความจาก มาลี';

  List<NewsModel> newModels = [];
  List<NotiModel> notiModels = [];

  String myToken;
  String textValue = 'Show News List';
  bool rememberBool;
  int idLoginInt;
  String typeString;

  //  Abour Firebase
  FirebaseMessaging firebaseMessageing = new FirebaseMessaging();

  SharedPreferences sharePreferances;

  @override
  void initState() {
    // Get Data From Json for Create ListView
    getAllDataFromJson();

    // Load Config Setting from SharePreferance
    getCredectial();

    firebaseMessageing.configure(onLaunch: (Map<String, dynamic> msg) {
      print('onLaunch Call: ==> $msg');
      setState(() {
        var notimodel = NotiModel.fromDATA(msg);
        notiModels.add(notimodel);
      });
    }, onResume: (Map<String, dynamic> msg) {
      setState(() {
        setState(() {
          print('onResume Call: ==> $msg');
          var notiModel = NotiModel.fromOBJECT(msg);
          _showDialog(notiModel.title.toString(), notiModel.body.toString());
        });
      });
    }, onMessage: (Map<String, dynamic> msg) {
      setState(() {
        print('onMessage Call: ==> $msg');
        var notiModel = NotiModel.fromOBJECT(msg);
        _showDialog(notiModel.title.toString(), notiModel.body.toString());
      });
    });

    firebaseMessageing.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));

    firebaseMessageing.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('Ios Setting Registed');
    });

    // Find Token
    firebaseMessageing.getToken().then((token) {
      myToken = token;
      print('myToken ==##############>>> $myToken');
      updateToken(token);
    });
  } // initial

  void _showDialog(String title, String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getAllDataFromJson() async {
    var response = await http.get(MyConstant().urlGetAllNews);
    var result = json.decode(response.body);
    // print(result);
    for (var objJson in result) {
      NewsModel newsModel = NewsModel.fromJSON(objJson);

      String url = newsModel.picture;
      print('url ====>>> $url');

      // List<String> urls = url.split('/');
      // print('urls[2] ===>>> ${urls[3]}${urls[4]}${urls[5]}');
      //  String urlEditPic = 'http://192.168.64.2/marie/editNewsWhereId.php?isAdd=true&id=${newsModel.id}&Picture=${urls[3]}/${urls[4]}/${urls[5]}';
      //  editNewsPicture(urlEditPic);

      setState(() {
        newModels.add(newsModel);
      });
    }
  }

  Future<void> editNewsPicture(String url) async {
    await http.get(url);
  }

  Future<void> getCredectial() async {
    sharePreferances = await SharedPreferences.getInstance();
    setState(() {
      rememberBool = sharePreferances.getBool('Remember');
      idLoginInt = sharePreferances.getInt('id');
      typeString = sharePreferances.getString('Type');
      print('idLoginInt ==> $idLoginInt, currentToken ==> $myToken');
    });
  }

  Future<void> updateToken(String token) async {
    String currentToken = token;
    String urlPHP =
        '${MyConstant().urlDomain}App/editTokenMariaWhereId.php?isAdd=true&id=$idLoginInt&Token=$currentToken';
    var response = await http.get(urlPHP);
    var result = json.decode(response.body);
    print('result edit Token ==> ' + result.toString());

    // Read idCode
    String urlPHP2 =
        '${MyConstant().urlDomain}App/getUserWhereId.php?isAdd=true&id=$idLoginInt';
    var response2 = await http.get(urlPHP2);
    var result2 = json.decode(response2.body);

    for (var jsonValue in result2) {
      UserModel userModel = UserModel.fromJson(jsonValue);
      String idCodeUser = userModel.idCode.toString();

      idCodeUser = idCodeUser.substring(1, (idCodeUser.length - 1));

      List<String> idCodeList = idCodeUser.split(',');

      for (var idCodeString in idCodeList) {
        print(idCodeString);
        String urlPHP3 =
            '${MyConstant().urlDomain}App/editParentsStudentWhereIdCode.php?isAdd=true&idCode=${idCodeString.trim()}&parents=$currentToken';
        var response3 = await http.get(urlPHP3);
        var result3 = json.decode(response3.body);
        print('Edit Token on Student $idCodeString ==> $result3');
      }
    }
  }

  Widget exitApp() {
    return IconButton(
      tooltip: titleTooltip,
      icon: Icon(Icons.close),
      onPressed: () {
        exit(0);
      },
    );
  }

  Widget menuShowChildren() {
    return ListTile(
      leading: Icon(
        Icons.child_friendly,
        color: MyStyle().mainColors,
        size: 48.0,
      ),
      title: Text(
        'บุตรหลานของ ท่าน',
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: MyStyle().mainColors),
      ),
      subtitle: Text(
        'ดูบุตรหลาน ที่อยู่ในการดูแลของท่านผู้ปกครอง',
        style: TextStyle(color: MyStyle().textColors),
      ),
      onTap: () {
        print('Click Memu1');
        var showChildrenListRoute = MaterialPageRoute(
            builder: (BuildContext context) => ShowChildrenList());
        Navigator.of(context).pop();
        Navigator.of(context).push(showChildrenListRoute);
      },
    );
  }

  Widget menuAddChildren() {
    return ListTile(
      title: Text(
        'เพิ่ม บุตร หลาน ของท่าน',
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: MyStyle().mainColors),
      ),
      subtitle: Text(
        'เพิ่มบุตรหลาน ที่อยู่ในการดูแลของท่านผู้ปกครอง',
        style: TextStyle(color: MyStyle().textColors),
      ),
      leading: Icon(
        Icons.group_add,
        color: MyStyle().mainColors,
        size: 48.0,
      ),
      onTap: () {
        var addChildrenRoute =
            MaterialPageRoute(builder: (BuildContext context) => AddChildren());
        Navigator.of(context).pop();
        Navigator.of(context).push(addChildrenRoute);
      },
    );
  }

  Widget menuLogOut() {
    return ListTile(
      leading: Icon(
        Icons.sync,
        size: 48.0,
        color: MyStyle().mainColors,
      ),
      title: Text(
        'Log Out',
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: MyStyle().mainColors),
      ),
      subtitle: Text(
        'การออกจาก User นี่ เพื่อ Login ใหม่',
        style: TextStyle(color: MyStyle().textColors),
      ),
      onTap: () {
        clearSharePreferance(context);
      },
    );
  }

  Widget menuExitApp() {
    return ListTile(
      leading: Icon(
        Icons.close,
        size: 48.0,
        color: Colors.red,
      ),
      title: Text(
        'ออกจาก Application',
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: MyStyle().mainColors),
      ),
      subtitle: Text(
        'ออกจาก App แต่ยังจดจำ User',
        style: TextStyle(color: MyStyle().textColors),
      ),
      onTap: () {
        exit(0);
      },
    );
  }

  Widget menuDrawer(BuildContext context) {
    String titleH1 = 'โรงเรียนมารีย์อนุสรณ์';
    String titleH2 = 'อำเภอเมือง จังหวัดบุรีรัมย์';
    return Drawer(
      child: ListView(
        children: <Widget>[
          showHeadDrawer(titleH1, titleH2),
          menuShowChildren(),
          Divider(),
          menuAddChildren(),
          Divider(),
          menuLogOut(),
          Divider(),
          menuExitApp(),
        ],
      ),
    );
  }

  DrawerHeader showHeadDrawer(String titleH1, String titleH2) {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: <Color>[Colors.white, MyStyle().mainColors],
          radius: 1.0,
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 70.0,
              height: 70.0,
              child: MyStyle().showLogo,
            ),
            Text(
              titleH1,
              style: TextStyle(
                color: MyStyle().textColors,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              titleH2,
              style: TextStyle(color: MyStyle().textColors),
            )
          ],
        ),
      ),
    );
  }

  void clearSharePreferance(BuildContext context) async {
    sharePreferances = await SharedPreferences.getInstance();
    setState(() {
      sharePreferances.clear();
      print('Remember ===>> ${sharePreferances.getBool('Remember')}');
      if (sharePreferances.getBool('Remember') == null) {
        var backHomeRoute =
            MaterialPageRoute(builder: (BuildContext context) => Home());
        Navigator.of(context)
            .pushAndRemoveUntil(backHomeRoute, (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: MyStyle().mainColors,
        title: Text(titleAppbar),
        actions: <Widget>[exitApp()],
      ),
      body: NewsListView(newModels),
      drawer: menuDrawer(context),
    );
  }
}