import 'package:flutter/material.dart';

import '../models/news_model.dart';
import '../listviews/detail_listview.dart';


class DetailNews extends StatefulWidget {
  final NewsModel newsModel;
  DetailNews({Key key, this.newsModel}) : super(key: key);

  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  @override
  void initState() {
    
    super.initState();
    // int id = widget.idNewsInt;
    // getNewsFromJSON(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียด'),
      ),
      body: DetailListView(widget.newsModel),
    );
  }
}