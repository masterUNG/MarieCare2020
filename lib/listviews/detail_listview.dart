import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mariealert/screens/show_detail_image.dart';
import 'package:mariealert/utility/my_constant.dart';
import '../models/news_model.dart';

class DetailListView extends StatelessWidget {
  NewsModel newsModel;
  String urlPicture;

  DetailListView(this.newsModel);

  Widget showPicture() {
    return CachedNetworkImage(
      imageUrl: urlPicture,
      placeholder: (BuildContext context, String string) =>
          CircularProgressIndicator(),
      errorWidget: (BuildContext context, String string, object) =>
          Image.asset('images/question.png'),
    );
  }

  Widget showTitle() {
    return Text(
      newsModel.name.toString(),
      style: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.blue[900]),
    );
  }

  Widget showDetail() {
    return Container(
        margin: EdgeInsets.all(15.0), child: Text(newsModel.detail.toString()));
  }

  @override
  Widget build(BuildContext context) {
    urlPicture = '${MyConstant().urlDomain}${newsModel.picture.toString()}';
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(30.0),
          alignment: Alignment(0, -1),
          child: Container(
            height: 200,
            child: showPicture(),
          ),
        ),
        FlatButton(
          child: Text(
            'ขยายภาพ',
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            MaterialPageRoute materialPageRoute =
                MaterialPageRoute(builder: (BuildContext context) {
              return ShowDetailImage(
                url: newsModel.picture,
              );
            });
            Navigator.of(context).push(materialPageRoute);
          },
        ),
        Container(
          alignment: Alignment(0, -1),
          child: showTitle(),
        ),
        showDetail()
      ],
    );
  }
}