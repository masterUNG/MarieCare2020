class NotiModel {
  
  String title, body;

  NotiModel(this.title, this.body);

  NotiModel.fromJSON(Map<dynamic, dynamic> parseJSON){
    title = parseJSON['title'];
    body = parseJSON['body'];
  }

  NotiModel.fromOBJECT(Map<String, dynamic> parseOBJECT) {
    Map map = parseOBJECT['data'];
    title = map['title'];
    body = map['body'];
  }

  NotiModel.fromDATA(Map<String, dynamic> parseDATA){
    Map map = parseDATA['data'];
    title = map['title'];
    body = map['body'];
  }

}