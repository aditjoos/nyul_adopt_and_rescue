class DatabaseModel{
  late int _id;
  late String _username;
  late String _password;
  late int _isWelcome;

  DatabaseModel(
    this._id,
    this._username,
    this._password,
    this._isWelcome,
  );

  DatabaseModel.map(dynamic obj){
    this._id = obj["id"];
    this._username = obj["username"];
    this._password = obj["password"];
    this._isWelcome = obj["is_welcome"];
  }

  int get id => _id;
  String get username => _username;
  String get password => _password;
  int get isWelcome => _isWelcome;

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();

    map["id"] = _id;
    map["username"] = _username;
    map["password"] = _password;
    map["is_welcome"] = _isWelcome;

    return map;
  }

  void setId(int id){
    this._id = id;
  }
}