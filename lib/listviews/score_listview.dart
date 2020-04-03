import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mariealert/models/score_model.dart';
import 'package:mariealert/screens/show_detail_image.dart';
import 'package:mariealert/utility/my_constant.dart';
import 'package:mariealert/utility/my_style.dart';

class ScoreListView extends StatelessWidget {
  List<ScoreModel> scoreModels = [];
  ScoreListView(this.scoreModels);

  Widget showDate(int index, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: <Widget>[showTitleDate(), showContentDate(index)],
      ),
    );
  }

  Container showContentDate(int index) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            scoreModels[index].lasupdate,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Container showTitleDate() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        'วันที่ :',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget showRemark(int index) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'หมายเหตุ:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            scoreModels[index].remark,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    );
  }

  Widget showUserCheck(int index) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'บันทึกโดย :',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(scoreModels[index].user_chk),
        )
      ],
    );
  }

  Widget showScore(int index) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'รับคะแนนเพิ่ม',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  scoreModels[index].score_plus,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.green[800],
                  ),
                ),
              )
            ],
          ),
        ),
        // Expanded(
        //   child: Column(
        //     children: <Widget>[
        //       Container(
        //         alignment: Alignment.topRight,
        //         child: Text(
        //           'หักคะแนน',
        //           style: TextStyle(fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //       Container(
        //         alignment: Alignment.topRight,
        //         child: Text(
        //           scoreModels[index].score_del,
        //           style: TextStyle(
        //               fontSize: 25.0,
        //               fontWeight: FontWeight.bold,
        //               color: Colors.red[600]),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget myDivider() {
    return Divider(
      height: 5.0,
      color: Colors.blue[900],
    );
  }

  Widget showImageAnExpand(int index, BuildContext context) {
    String url = '${MyConstant().urlDomain}${scoreModels[index].img_Path}';
    print('urlImageExpand ==> $url');
    return Column(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: url,
          placeholder: (BuildContext context, String string) =>
              MyStyle().showProgress(),
          errorWidget: (BuildContext context, String string, object) =>
              MyStyle().showQuestion(),
        ),
        FlatButton(
          child: Text(
            'ขยายภาพ',
            style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            MaterialPageRoute materialPageRoute =
                MaterialPageRoute(builder: (BuildContext context) {
              return ShowDetailImage(
                url: scoreModels[index].img_Path,
              );
            });
            Navigator.of(context).push(materialPageRoute);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: scoreModels.length,
      itemBuilder: (context, int index) {
        return Container(
          padding: EdgeInsets.all(8.0),
          decoration: index % 2 == 0
              ? BoxDecoration(color: Colors.blue[100])
              : BoxDecoration(color: Colors.blue[200]),
          child: Row(
            children: <Widget>[
              Container(
                // color: Colors.grey,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  children: <Widget>[
                    showDate(index, context),
                    showRemark(index),
                    showUserCheck(index),
                    showScore(index),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width * 0.5 - 16,
                child: scoreModels[index].img_Path.length != 0
                    ? showImageAnExpand(index, context)
                    : Text(''),
              )
            ],
          ),
        );
      },
    );
  }
}