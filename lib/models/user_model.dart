class UserModel {
  int id;
  String user,
      password,
      type,
      Token,
      idCode,
      FirstName,
      LastName,
      Address,
      Phone,
      Lat,
      Lng;

  UserModel(
      this.id,
      this.user,
      this.password,
      this.type,
      this.Token,
      this.idCode,
      this.FirstName,
      this.LastName,
      this.Address,
      this.Phone,
      this.Lat,
      this.Lng);

  UserModel.fromJson(Map<String, dynamic> parseJSON) {
    id = int.parse(parseJSON['id']);
    user = parseJSON['User'];
    password = parseJSON['Password'];
    type = parseJSON['Type'];
    Token = parseJSON['Token'];
    idCode = parseJSON['idCode'];
    FirstName = parseJSON['FirstName'];
    LastName = parseJSON['LastName'];
    Address = parseJSON['Address'];
    Phone = parseJSON['Phone'];
    Lat = parseJSON['Lat'];
    Lng = parseJSON['Lng'];
  }
}