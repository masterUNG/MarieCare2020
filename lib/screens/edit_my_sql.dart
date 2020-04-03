import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditMySQL extends StatefulWidget {
  @override
  _EditMySQLState createState() => _EditMySQLState();
}

class _EditMySQLState extends State<EditMySQL> {
  // Field

  // Method
  @override
  void initState() {
    super.initState();
    // getAllStudent();
  }

  Future<void> getAllStudent() async {
    String urlStudent = 'http://tscore.net/App/getAllStudent.php';

    try {
      http.Response response = await http.get(urlStudent);
      var result = json.decode(response.body);

      for (var map in result) {
        String id = map['id'];
        String imagePath = map['imagePath'];

        if (imagePath.length != 0) {
          List<String> list = imagePath.split('/');
          // print('list[4] = ${list[4]}');

          if (list[4] != null) {
            
            List<String> list2 = list[4].split('.');
            // print('list2[0] = ${list2[0]}');

            imagePath = 'msgrade/stu_pic/${list2[0]}.jpg';
            // print('imagePath = $imagePath');

            String url =
                'http://tscore.net/App/editMsStudentWhereId.php?isAdd=true&id=$id&imagePath=$imagePath';

                http.Response response = await http.get(url);

          }
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Work'),
      ),
    );
  }
}