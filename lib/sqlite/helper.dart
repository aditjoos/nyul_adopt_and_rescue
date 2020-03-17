import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:petz_invention_udayana/sqlite/model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  // cek jika database ada, maka digunakan
  // jika tidak ada, maka buat database baru
  Future<Database> get db async{
    if(_db != null) return _db;
    _db = await setDB();
    print("[OK] DB diambil");
    return _db;
  }

  setDB() async{
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "nyul_db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    print("[OK] DB dibuat");
    return db;
  }

  void _onCreate(Database db, int version) async{
    // script untuk CREATE Table dan strukturnya
    await db.execute("CREATE TABLE login(id INTEGER PRIMARY KEY, username TEXT, password TEXT, is_welcome INTEGER)");
    print("[OK] Table dibuat");
  }

  // proses tambah data
  Future<int> addUser(DatabaseModel dbModel) async{
    // ambil database
    var dbClient = await db;
    int res = await dbClient.insert("login", dbModel.toMap());
    // print("[OK] Data berhasil ditambahkan.");
    print("[OK] User ditambah");
    return res;
  }

  // ambil data
  Future<List> getUser() async{
    // if(_db != null) {
      var resultArray = List(4);

      var dbClient = await db;
      List<Map> list = await dbClient.rawQuery("SELECT id, username, password, is_welcome FROM login");
      List<DatabaseModel> userData = new List();

      for(int i = 0; i < list.length; i++){
        var data = new DatabaseModel(list[i]["id"], list[i]["username"], list[i]["password"], list[i]["is_welcome"]);
        data.setId(list[i]["id"]);
        userData.add(data);
      }

      resultArray[0] = userData[0].id;
      resultArray[1] = userData[0].username;
      resultArray[2] = userData[0].password;
      resultArray[3] = userData[0].isWelcome;

      print("debug : "+resultArray[0].toString());
      print("debug : "+resultArray[1]);
      print("debug : "+resultArray[2]);
      print("debug : "+resultArray[3].toString());

      return resultArray;
    // }else{
    //   print("[ER] DB null");
    //   return null;
    // }
  }

  Future<int> updateUser(DatabaseModel dbModel) async{
    var dbClient = await db;
    int res = await dbClient.update("login", dbModel.toMap(), where: "id=1");
    print("[OK] User diupdate");
    return res;
  }

  // cek pertamakali apakah user ada atau tidak
  Future checkUser() async{
    // ambil database
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM login WHERE id = 1");
    //
    // inisialisasi data nama kosong/null untuk pertamakali
    DatabaseModel model = new DatabaseModel(1,"","",1);
    // jika data result kosong (result.isEmpty), maka addUser dengan inisialisasi data model diatas
    //
    if(result.isEmpty) addUser(model);
    else print("[OK] Data sudah ada");
  }
}