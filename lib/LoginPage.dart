import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/MainPage.dart';
import 'package:petz_invention_udayana/components/Buttons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';
import 'package:petz_invention_udayana/components/forms.dart';
import 'package:petz_invention_udayana/database/mysqlHelper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController controllerUsername = TextEditingController(text: '');
  TextEditingController controllerPassword = TextEditingController(text: '');

  void checkConnectionThenExecuteLoadDataFunction() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) _checkLogin();
      else MyDialogs().simpleDialog(context, 'Kesalahan', 'Ada kesalahan koneksi internet.');
    } on SocketException catch (_) {
      MyDialogs().simpleDialog(context, 'Kesalahan', 'Kamu tidak ada koneksi internet.');
    }
  }

  late MySql _mysql;

  bool isLoading = true;

  _checkLogin() {
    String username = controllerUsername.text;
    String password = controllerPassword.text;

    _mysql.getData('SELECT kode_member FROM member_login WHERE username = "$username" AND password = "$password"').then((value) {
      if(value.isNotEmpty) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainPage()));
      } else {
        MyDialogs().simpleDialog(context, 'Tidak Sesuai', 'Username atau Password kamu tidak sesuai atau tidak ada.');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _mysql = new MySql(context);

    checkConnectionThenExecuteLoadDataFunction();
  }

  bool isRegister = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: !isRegister ? Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.0,),
                  SafeArea(child: Image.asset('assets/logo/app.png', width: MediaQuery.of(context).size.width/2,)),
                  SizedBox(height: 15.0,),
                  MyTextField(
                    controller: controllerUsername,
                    hintText: 'Username',
                  ),
                  SizedBox(height: 15.0,),
                  MyTextField(
                    controller: controllerPassword,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 15.0,),
                  MyIconButton(
                    onPressed: (){
                      // checkLogin();
                      _checkLogin();
                    },
                    backgroundColor: Color(0xFFff971d),
                    color: Colors.white,
                    shadowColorTopLeft: Color(0xFFffffff),
                    shadowColorBottomRight: Color(0xFFa3b1c6),
                    text: 'Masuk',
                    icon: Icon(LineIcons.paperPlane, color: Colors.white,),
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Belum punya akun? ', style: TextStyle(color: Colors.black54,)),
                      InkWell(
                        onTap: () => setState(() => isRegister = true),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                          child: Text('Buat akun baru.', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[400],))
                        ),
                      )
                    ],
                  ),
                ],
              ) : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SafeArea(
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.0,),
                          Text('Daftar akun baru', style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('Isi data dirimu terlebih dahulu.', style: TextStyle(color: Colors.black54, fontSize: 16))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  MyTextField(
                    hintText: 'Nama',
                  ),
                  SizedBox(height: 15.0,),
                  MyTextField(
                    hintText: 'Email',
                  ),
                  SizedBox(height: 15.0,),
                  MyTextField(
                    hintText: 'No. HP',
                  ),
                  SizedBox(height: 15.0,),
                  MyTextField(
                    hintText: 'Alamat',
                  ),
                  SizedBox(height: 15.0,),
                  MyContainer(
                    width: double.infinity,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (contect) => MyBottomSheet(
                            title: 'Pilih Kota',
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jakarta Barat',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jakarta Pusat',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jakarta Tengah',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jakarta Selatan',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Tangerang',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jawa Barat',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jawa Tengan',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jawa Timur',),
                              ],
                            ),
                          )
                        ),
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
                  SizedBox(height: 15.0,),
                  MyContainer(
                    width: double.infinity,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (contect) => MyBottomSheet(
                            title: 'Pilih Kota',
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jakarta Barat',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jakarta Pusat',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jakarta Tengah',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jakarta Selatan',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Tangerang',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jawa Barat',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jawa Tengan',),
                                ListViewItemsProvinsi(onTap: (){}, text: 'Jawa Timur',),
                              ],
                            ),
                          )
                        ),
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
                  SizedBox(height: 15.0,),
                  MyTextField(
                    hintText: 'Username',
                  ),
                  SizedBox(height: 15.0,),
                  MyTextField(
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 15.0,),
                  MyTextField(
                    hintText: 'Ketik Ulang Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 15.0,),
                  MyIconButton(
                    onPressed: (){},
                    backgroundColor: Color(0xFFff971d),
                    color: Colors.white,
                    shadowColorTopLeft: Color(0xFFffffff),
                    shadowColorBottomRight: Color(0xFFa3b1c6),
                    text: 'Daftar',
                    icon: Icon(LineIcons.check, color: Colors.white,),
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sudah punya akun? ', style: TextStyle(color: Colors.black54,)),
                      InkWell(
                        onTap: () => setState(() => isRegister = false),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                          child: Text('Login.', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[400],))
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15.0,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListViewItemsProvinsi extends StatelessWidget {
  ListViewItemsProvinsi({this.onTap, required this.text});

  final VoidCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent, child: InkWell(
      onTap: onTap, child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        child: Center(child: Text(text)),
      ),
    ),);
  }
}