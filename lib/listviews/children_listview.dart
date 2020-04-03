import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mariealert/screens/show_news_list.dart';
import 'package:mariealert/screens/show_score_list.dart';
import 'package:mariealert/utility/my_constant.dart';
import 'package:mariealert/utility/my_style.dart';
import '../models/children_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChildrenListView extends StatelessWidget {
  // Explicit
  List<ChildrenModel> childrenModels;
  List<String> idCodeList = [];
  ChildrenListView(this.childrenModels);
  Widget widget;

  // Method

  Widget showButtonScore(BuildContext context, int index) {
    return Container(
      child: FlatButton.icon(
        color: MyStyle().mainColors,
        icon: Icon(
          Icons.score,
          color: Colors.white,
        ),
        label: Text(
          'แสดง คะแนน',
          style: TextStyle(color: Colors.white),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () {
          moveToDetail(context, index);
        },
      ),
    );
  }

  Widget showDelete(int index, BuildContext context) {
    return Container(
      child: FlatButton.icon(
        color: Colors.red[700],
        icon: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        label: Text(
          'ลบบุตร',
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(30.0)),
        onPressed: () {
          myAlert(index, context);
        },
      ),
    );
  }

  void myAlert(int index, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(Icons.access_alarms),
              title: Text(
                'ผู้ปกครองแน่ใจนะ ?',
                style: TextStyle(
                    color: Colors.red[700], fontWeight: FontWeight.bold),
              ),
            ),
            content: Text(
                'คุณผู้ปกครอง ต้องการลบ ${childrenModels[index].fname} ออกจาก บุตรหลาน ของท่าน'),
            actions: <Widget>[
              cancleButton(context),
              okButton(context, index),
            ],
          );
        });
  }

  Widget okButton(BuildContext context, int index) {
    return FlatButton(
      child: Text(
        'ลบเลย',
        style: TextStyle(color: Colors.red[700]),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        deleteChildrent(index, context);
      },
    );
  }

  Future<void> deleteChildrent(int index, BuildContext context) async {
    try {
      String idCodeDelete = childrenModels[index].idcode;
      idCodeList.removeWhere((items) => (items == idCodeDelete));
      print('new idCodeList ==========>>>>>>>>> $idCodeList');

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      int idLogin = sharedPreferences.getInt('id');

      String urlString =
          '${MyConstant().urlDomain}App/editUserMariaWhereId.php?isAdd=true&id=$idLogin&idCode=${idCodeList.toString()}';
      print('url = $urlString');

      // var response = await get(urlString);

      await http.get(urlString).then((value) {
        routeToListNew(context);
      });
    } catch (e) {
      print('Error ==>>>> ${e.toString()}');
      routeToListNew(context);
    }
  }

  void routeToListNew(BuildContext context) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (value) => ShowNewsList(),
    );
    Navigator.of(context).pushAndRemoveUntil(route, (value) => false);
  }

  Widget cancleButton(BuildContext context) {
    return FlatButton(
      child: Text('อย่าพึ่งลบ'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget showButton(BuildContext context, int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        children: <Widget>[
          Expanded(
            child: showButtonScore(context, index),
          ),
          Expanded(
            child: showDelete(index, context),
          ),
        ],
      ),
    );
  }

  Widget showImage(int index) {
    String urlImage =
        '${MyConstant().urlDomain}${childrenModels[index].imagePath.toString()}';

    return Container(
      height: 200.0,
      child: CachedNetworkImage(
        imageUrl: urlImage,
        placeholder: (BuildContext context, String string) =>
            MyStyle().showProgress(),
        errorWidget: (BuildContext context, String string, object) =>
            MyStyle().showQuestion(),
      ),
    );
  }

  Widget showName(int index) {
    print('fname ==> ${childrenModels[index].fname}');
    return Text(
      childrenModels[index].fname,
      style: TextStyle(fontSize: 24.0, color: Colors.white),
    );
  }

  Widget showRoom(int index) {
    return Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment(0, 0),
              child: Text(
                '${childrenModels[index].studentClass}',
                style: TextStyle(fontSize: 18.0, color: Colors.blue[800]),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment(0, 0),
              child: Text(
                'ห้อง  ${childrenModels[index].room}',
                style: TextStyle(fontSize: 18.0, color: Colors.blue[800]),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget showList() {
    for (var value in childrenModels) {
      // print('value ==> $value');
      idCodeList.add(value.idcode);
    }
    print('idCodeList = $idCodeList');
    return ListView.builder(
      itemCount: childrenModels.length,
      itemBuilder: (context, int index) {
        return GestureDetector(
          child: Container(
            child: Column(
              children: <Widget>[
                showImage(index),
                showName(index),
                showRoom(index),
                showButton(context, index),
              ],
            ),
          ),
          onTap: () {
            moveToDetail(context, index);
          },
        );
      },
    );
  }

  void moveToDetail(BuildContext context, int index) {
    String idCode = childrenModels[index].idcode;
    print('Click idCode ==> $idCode');

    var showScoreRoute = MaterialPageRoute(
        builder: (BuildContext context) => ShowScoreList(
              idCode: idCode,
            ));
    Navigator.of(context).push(showScoreRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
              radius: 2.0,
              colors: [Colors.white, Colors.blue],
              center: Alignment(1, 1))),
      child: showList(),
    );
  }
}