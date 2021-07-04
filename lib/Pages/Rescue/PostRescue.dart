import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';
import 'package:petz_invention_udayana/components/forms.dart';
import 'package:petz_invention_udayana/helper/mysqlHelper.dart';
import 'package:petz_invention_udayana/helper/sqliteHelper.dart';

class PostRescuePage extends StatefulWidget {
  @override
  _PostRescuePageState createState() => _PostRescuePageState();
}

class _PostRescuePageState extends State<PostRescuePage> {

  late MySql _mysql;

  bool postAsAnonymous = false;

  void _onChangePostAsAnonymousValue(bool newValue) => setState(() {
    postAsAnonymous = newValue;
  });

  bool _isAmbilGambar = false;
  late File _image;

  late List<Map<String, dynamic>> dataUserLogin;

  _getDataUserLogin() async {
    List<Map<String, dynamic>> data = await SqliteHelper().getData(table: 'login');

    setState(() => dataUserLogin = data);
  }

  TextEditingController _controllerJudulPostingan = new TextEditingController();
  TextEditingController _controllerLokasiTambahan = new TextEditingController();
  TextEditingController _controllerDeskripsiHewan = new TextEditingController();
  TextEditingController _controllerJenisHewan = new TextEditingController();

  int _levelUrgensi = 3;

  _postRescue() {
    String judulPostingan = _controllerJudulPostingan.text;
    String jenisHewan = _controllerJenisHewan.text;
    String deskripsi = _controllerDeskripsiHewan.text;
    String lokasiTambahan = _controllerLokasiTambahan.text;
    String idMember = dataUserLogin[0]['id_member'];

    _mysql.queryProcess('INSERT INTO post_rescue(judul, jenis_hewan, deskripsi, lokasi_map, alamat_detail, x_kode_member) VALUES("$judulPostingan", "$jenisHewan", "$deskripsi", "lokasi", "$lokasiTambahan", "$idMember")').then((value) {
      if(value.affectedRows! > 0){
        Navigator.pop(context);
      } else {
        MyDialogs().simpleDialog(context, 'Kesalahan', 'Gagal membuat postingan.');
      }
    });
  }

  _ambilLokasi() {

  }

  void _checkConnectionThenExecute() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isEmpty && result[0].rawAddress.isEmpty) MyDialogs().simpleDialog(context, 'Kesalahan', 'Ada kesalahan koneksi internet.');
    } on SocketException catch (_) {
      MyDialogs().simpleDialog(context, 'Kesalahan', 'Kamu tidak ada koneksi internet.');
    }
  }

  @override
  void initState() {
    super.initState();

    _mysql = new MySql(context);

    _getDataUserLogin();
    _checkConnectionThenExecute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SafeArea(
                child: Row(
                  children: <Widget>[
                    IconButton(icon: Icon(LineIcons.cross), onPressed: () => MyDialogs().functionDialog(context, 'Konfirmasi', 'Kamu yakin tidak jadi posting?', () {
                      Navigator.pop(context);
                    })),
                    Text('Batal')
                  ],
                ),
              ),
              Center(child: Text('Tambah Posting Rescue', style: TextStyle(fontSize: 20.0),),),
              SizedBox(height: 20.0,),
              _isAmbilGambar ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(_image, fit: BoxFit.fill,)
                ),
              ) : Container(),
              SizedBox(height: 10,),
              MyContainer(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyTextField(
                      controller: _controllerJudulPostingan,
                      hintText: 'Judul Postingan',
                    ),
                    Text('Lokasi', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Row(
                      children: <Widget>[
                        // Auto Wrap
                        Expanded(child: Text('Jl. Hambalaaasng no.13', style: TextStyle(color: Colors.grey))),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15.0),
                            onTap: () => _ambilLokasi(),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                children: <Widget>[
                                  Text('ubah'),
                                  Icon(LineIcons.map)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    MyTextField(
                      controller: _controllerLokasiTambahan,
                      hintText: 'Informasi tambahan dari lokasi',
                    ),
                    SizedBox(height: 15,),
                    MyContainer(
                      width: double.infinity,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(10.0),
                          child: Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Pilih Provinsi', style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),),
                              Icon(LineIcons.angleRight, color: Colors.orange,)
                            ],
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    MyContainer(
                      width: double.infinity,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(10.0),
                          child: Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Pilih Kota', style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),),
                              Icon(LineIcons.angleRight, color: Colors.orange,)
                            ],
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              MyContainer(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Deskripsi hewan', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8.0,),
                      Text('Tulis deskripsi mengenai kenapa hewan ini harus mendapatkan penanganan.', style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 8.0,),
                      MyTextField(
                        controller: _controllerDeskripsiHewan,
                        hintText: 'Deskripsi hewan',
                      ),
                      SizedBox(height: 15,),
                      Text('Tentukan level urgensi penanganan rescue ini.', style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 8.0,),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _levelUrgensi = 3),
                              child: Container(
                                color: _levelUrgensi == 3 ? Colors.orange[300] : Colors.grey[300],
                                padding: EdgeInsets.all(15),
                                child: Center(
                                  child: Text('Ringan'),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _levelUrgensi = 2),
                              child: Container(
                                color: _levelUrgensi == 2 ? Colors.orange[300] : Colors.grey[300],
                                padding: EdgeInsets.all(15),
                                child: Center(
                                  child: Text('Sedang'),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _levelUrgensi = 1),
                              child: Container(
                                color: _levelUrgensi == 1 ? Colors.orange[300] : Colors.grey[300],
                                padding: EdgeInsets.all(15),
                                child: Center(
                                  child: Text('Darurat'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      MyTextField(
                        controller: _controllerJenisHewan,
                        hintText: 'Jenis Hewan',
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: postAsAnonymous,
                        onChanged: (value) => _onChangePostAsAnonymousValue(value!),
                      ),
                      Text('Posting sebagai anonymous')
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => MyDialogs().simpleDialog(context, 'Posting sebagai anonymous ?', 'Jika kamu posting rescue secara anonymous/tanpa identitas, maka kamu tidak akan mendapatkan poin atau rating.'),
                      borderRadius: BorderRadius.circular(30.0),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(LineIcons.questionCircle),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.orange[400]
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () => _postRescue(),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Selesai', style: TextStyle(color: Colors.white),),
                            Icon(LineIcons.check, color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}