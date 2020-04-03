class ChildrenModel {
  String studentId,
      fname,
      studentClass,
      room,
      roomnt,
      score,
      imagePath,
      parents,
      idcode;

  ChildrenModel(this.studentId, this.fname, this.studentClass, this.room,
      this.roomnt, this.score, this.imagePath, this.parents, this.idcode);

  ChildrenModel.objJSON(Map<String, dynamic> parseJSON) {
    studentClass = parseJSON['id'];
    fname = parseJSON['fname'];
    studentClass = parseJSON['class'];
    room = parseJSON['room'];
    roomnt = parseJSON['room_nt'];
    score = parseJSON['score'];
    imagePath = parseJSON['imagePath'];
    parents = parseJSON['parents'];
    idcode = parseJSON['idcode'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'fname => $fname, imagePath => $imagePath';
  }
}