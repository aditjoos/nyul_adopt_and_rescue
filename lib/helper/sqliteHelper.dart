import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class SqliteHelper{
  static final SqliteHelper _instance = SqliteHelper.internal();
  SqliteHelper.internal();

  factory SqliteHelper() => _instance;

  static Database? _db;

  // cek jika database ada maka digunakan
  // jika tidak ada maka buat database baru
  Future<Database> get db async {
    if(_db != null) return _db!;
    _db = await setDB();
    return _db!;
  }

  // fungsi membuat file db sqlite baru
  setDB() async {
    // direktori untuk menyimpan file db
    io.Directory directory = await getApplicationDocumentsDirectory();
    // menggabungkan direktori dengan nama file tujuan
    // 
    // disini nama file adalah "db"
    String path = join(directory.path, "db");
    // saat file db baru selesai dibuat maka akan memanggil fungsi _onCreate
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    // jika selesai maka mengembalikan sebuah Database
    return db;
  }

  void _onCreate(Database db, int version) async {
    // script membuat table
    // 
    // bisa juga membuat banyak table sekaligus
    await db.execute("CREATE TABLE login(id INTEGER PRIMARY KEY, is_login INTEGER, id_member TEXT)");
  }

  void insertData({required Map<String, dynamic> data, required String table}) async {
    // mengambil referensi database.
    final Database dbClient = await db;

    // menambah data ke tabel database
    // `conflictAlgorithm` digunakan jika ada kasus data sama
    //
    // di kasus ini menggantikan data yang ada sebelumnya
    await dbClient.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getData({required String table}) async {
    // mengambil referensi database.
    final Database dbClient = await db;

    // query untuk mengambil semua data pada table
    return await dbClient.query(table);
  }

  void updateData({required Map<String, dynamic> data, required String table}) async {
    // mengambil referensi database.
    final dbClient = await db;

    // mengubah data pada tabel dengan data
    await dbClient.update(
      table,
      data,
      // pastikan data mempunyai id yang sesuai.
      where: "id = ?",
      // ambil id dari data sebagai whereArg untuk mencegah SQL injection.
      whereArgs: [data['id']],
    );
  }

  void deleteData(int id, String table) async {
    // mengambil referensi database.
    final dbClient = await db;

    // menghapus row dari tabel
    await dbClient.delete(
      table,
      // gunakan where Clause untuk menghapus row yang sesuai
      where: "id = ?",
      // ambil id dari model sebagai whereArg untuk mencegah SQL injection.
      whereArgs: [id],
    );
  }

  

  logout() {
    Map<String, dynamic> data = {
      'id' : 1,
      'is_login' : 0,
      'id_member' : '',
    };

    updateData(table: 'login', data: data);
  }
}