import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mariealert/screens/show_detail_image.dart';
import 'package:mariealert/utility/my_constant.dart';
import 'package:mariealert/utility/my_style.dart';
import '../models/news_model.dart';
import '../screens/detail_news.dart';

class NewsListView extends StatelessWidget {
  // Field
  List<NewsModel> newsModels;

  // Constructor
  NewsListView(this.newsModels);

  Widget showName(String nameString) {
    return Container(
      width: 170.0,
      child: Text(nameString,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900])),
    );
  }

  Widget showDetail(String detailString) {
    String detail = detailString;
    if (detailString.length > 100) {
      detail = detailString.substring(0, 100) + '...';
    }

    return Container(
      width: 170.0,
      child: Text(detail),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsModels.length,
      itemBuilder: (context, int index) {
        String urlPicture =
            '${MyConstant().urlDomain}${newsModels[index].picture}';
        return GestureDetector(
          child: Container(
            decoration: index % 2 == 0
                ? BoxDecoration(color: Colors.blue[100])
                : BoxDecoration(color: Colors.blue[200]),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: CachedNetworkImage(
                        imageUrl: urlPicture,
                        placeholder: (BuildContext context, String string) =>
                            MyStyle().showProgress(),
                        errorWidget:
                            (BuildContext context, String string, error) =>
                                MyStyle().showQuestion(),
                      ),
                      constraints:
                          BoxConstraints.expand(width: 150.0, height: 150.0),
                    ),
                    FlatButton(
                      child: Text(
                        'ขยายภาพ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      onPressed: () {
                        MaterialPageRoute materialPageRoute =
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ShowDetailImage(
                            url: '${MyConstant().urlDomain}${newsModels[index].picture}',
                          );
                        });
                        Navigator.of(context).push(materialPageRoute);
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      showName(newsModels[index].name),
                      showDetail(newsModels[index].detail)
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            int idNewsInt = newsModels[index].id;
            // print('You Tap index = $index, idNewsInt = $idNewsInt');
            
            var goToDetailNews = new MaterialPageRoute(
                builder: (BuildContext context) => DetailNews(
                      newsModel: newsModels[index],
                    ));
            Navigator.of(context).push(goToDetailNews);
          },
        );
      },
    );
  }
}