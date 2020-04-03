class ScoreModel {
  String id,
      idcode,
      remark,
      score_plus,
      score_del,
      user_chk,
      lasupdate,
      status,
      class_id,
      room,
      score_from,
      img_Path;

  ScoreModel(
      this.id,
      this.idcode,
      this.remark,
      this.score_plus,
      this.score_del,
      this.user_chk,
      this.lasupdate,
      this.status,
      this.class_id,
      this.room,
      this.score_from,
      this.img_Path);

  ScoreModel.fromJson(Map<String, dynamic> parseJson) {
    id = parseJson['id'];
    idcode = parseJson['idcode'];
    remark = parseJson['remark'];
    score_plus = parseJson['score_plus'];
    score_del = parseJson['score_del'];
    user_chk = parseJson['user_chk'];
    lasupdate = parseJson['lasupdate'];
    status = parseJson['status'];
    class_id = parseJson['class_id'];
    room = parseJson['room'];
    score_from = parseJson['score_from'];
    img_Path = parseJson['img_Path'];
  }
}