import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';

class MySql {

  late BuildContext context;

  MySql(BuildContext context) {
    this.context = context;
  }

  Future getConnection() async {
    try{
      ConnectionSettings settings = new ConnectionSettings(
        host: '192.168.42.57',
        port: 3306,
        user: 'root',
        db: 'nyul'
      );

      return await MySqlConnection.connect(settings);
    } on MySqlException catch (e) {
      MyDialogs().simpleDialog(context, 'Kesalahan', e.message);
    } on SocketException {
      MyDialogs().simpleDialog(context, 'Kesalahan', 'Tidak dapat menjangkau server.');
    }
  }

  Future<Results> queryProcess(String query) async {
    MySqlConnection conn = await getConnection();

    Results results = await conn.query(query);
    
    conn.close();
    return results;
  }
}