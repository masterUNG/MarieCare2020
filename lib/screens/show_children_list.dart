import 'package:flutter/material.dart';
import 'package:mariealert/utility/my_constant.dart';
import 'package:mariealert/utility/my_style.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import '../models/user_model.dart';
import '../listviews/children_listview.dart';
import '../models/children_model.dart';

class ShowChildrenList extends StatefulWidget {
  @override
  _ShowChildrenListState createState() => _ShowChildrenListState();
}

class _ShowChildrenListState extends State<ShowChildrenList>
    with WidgetsBindingObserver {
  String titleAppBar = 'บุตรหลานของ ท่าน';
  int idLogin;
  List<String> idCodeLists = [];
  List<ChildrenModel> childrenModels = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getSharePreferance();
  }

  Future<void> getSharePreferance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    idLogin = sharedPreferences.getInt('id');

    String urlString =
        '${MyConstant().urlDomain}App/getUserWhereId.php?isAdd=true&id=$idLogin';
    var respense = await get(urlString);
    var result = json.decode(respense.body);
    print('result show_children_list ===>>> $result');

    for (var objJson in result) {
      UserModel userModel = UserModel.fromJson(objJson);
      String idCodeString = userModel.idCode.toString();
      idCodeString = idCodeString.substring(1, ((idCodeString.length) - 1));

      idCodeLists = idCodeString.split(',');
      print('idCodeList ==> $idCodeLists');

      if (idCodeLists[0] == '') {
        idCodeLists.removeAt(0);
        print('idCodeList after ==> $idCodeLists');
      }

      getChildrenFromIdCode();
    }
  }

  Future<void> getChildrenFromIdCode() async {
    for (var idCode in idCodeLists) {
      idCode = idCode.trim();
      // print('idCode ==> $idCode');
      String urlString =
          '${MyConstant().urlDomain}App/getStudentWhereQR.php?isAdd=true&idcode=$idCode';
      var response = await get(urlString);
      var result = json.decode(response.body);
      // print('result ==> $result');
      ChildrenModel childrenModel;
      for (var objJSON in result) {
        childrenModel = ChildrenModel.objJSON(objJSON);
      }

      // print('childrenModel ==> ${childrenModel.toString()}');
      setState(() {
        childrenModels.add(childrenModel);
        // print('childrenModels.length ==> ${childrenModels.length}');
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      _notification = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("_appLiftcycleState ==> $_notification");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().mainColors,
        title: Text(titleAppBar),
      ),
      body: ChildrenListView(childrenModels),
    );
  }
}
