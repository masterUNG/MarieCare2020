class NewsModel {
  int id;
  String name, detail, picture;

  NewsModel(this.id, this.name, this.detail, this.picture);

  NewsModel.fromJSON(Map<String, dynamic> parseJSON) {
    id = int.parse(parseJSON['id']);
    name = parseJSON['Name'];
    detail = parseJSON['Detail'];
    picture = parseJSON['Picture'];
  }
}