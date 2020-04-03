import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowDetailImage extends StatefulWidget {
  final String url;
  ShowDetailImage({Key key, this.url}) : super(key: key);
  @override
  _ShowDetailImageState createState() => _ShowDetailImageState();
}

class _ShowDetailImageState extends State<ShowDetailImage> {
  String urlImage;

  @override
  void initState() {
    super.initState();
    setState(() {
      urlImage = widget.url;
    });
  }

  Widget showImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: CachedNetworkImage(
        imageUrl: urlImage,
        errorWidget: (BuildContext context, String string, object) =>
            Image.asset('images/question.png'),
      ),
    );
  }

  Widget showText() {
    return Center(
      child: Text('ไม่มีรูปภาพแสดง คะ'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ขยายภาพ'),
      ),
      body: urlImage != null ? showImage() : showText(),
    );
  }
}