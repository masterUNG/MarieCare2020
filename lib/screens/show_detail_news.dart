import 'package:flutter/material.dart';
import '../models/news_model.dart';

class ShowDetailNews extends StatelessWidget {

  List<NewsModel> newsModels = [];
  ShowDetailNews(this.newsModels);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(newsModels[0].detail.toString()),
    );
  }
}