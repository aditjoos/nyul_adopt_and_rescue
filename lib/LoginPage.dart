import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
import 'package:petz_invention_udayana/MainPage.dart';
import 'package:petz_invention_udayana/components/Buttons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';
import 'package:petz_invention_udayana/sqlite/helper.dart';
import 'package:petz_invention_udayana/sqlite/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var db = new DatabaseHelper();

  static String usernameText;
  static String passwordText;
  static int isWelcomeText;

  TextEditingController controllerUsername;
  TextEditingController controllerPassword;

  void myShowDialog(String text){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => FunkyOverlay(text, [
        FlatButton(
          child: Text('OK'),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ])
    );
  }

  void checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('internet connected');
      }
    } on SocketException catch (_) {
      print('internet not connected');
    }
  }

  Future checkUserBaru() async{
    await db.checkUser();
  }

  void getUsername() async{
    List resultArray = await db.getUser();
    usernameText = resultArray[1];
    passwordText = resultArray[2];
    isWelcomeText = resultArray[3];

    setState(() {
      controllerUsername = TextEditingController(text: usernameText);
      controllerPassword = TextEditingController(text: passwordText);
    });
    // print(usernameText);
  }

  Future checkLogin() async{
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => FunkyLoading(),
    );

    String usernameInput = controllerUsername.text;
    String passwordInput = controllerPassword.text;

    String url = 'http://nyul.kumpulan-soal.com/index.php/member_login?username='+usernameInput+'&password='+passwordInput;
    var result = await http.get(Uri.encodeFull(url), headers: { 'accept':'application/json' });
    var content = json.decode(result.body);

    if (result.statusCode == 200){
      if (content['result'] == true){
        var data = content['data'];

        bool id = data[0]['id'] == null ? false : true;
        bool username = data[0]['username'] == null ? false : true;
        bool password = data[0]['password'] == null ? false : true;

        if(id && username && password){
          Navigator.pop(context);

          updateUserLoginCredential(usernameInput, passwordInput);

          Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));
        }else{
          Navigator.pop(context);
          myShowDialog('Username atau Passwordmu salah, periksa kembali.');
        }
      }else if (content['result'] == false){
        Navigator.pop(context);
        myShowDialog('Username atau Passwordmu salah, periksa kembali.');
      }
    }else{
      Navigator.pop(context);
      myShowDialog('Username atau Passwordmu salah, periksa kembali.\n\n ' + content['result'].toString() +', '+ result.statusCode.toString());
    }
  }

  Future updateUserLoginCredential(String username, String password) async {
    var dbModel = new DatabaseModel(1, username, password, isWelcomeText);
    await db.updateUser(dbModel);
  }

  @override
  void initState() {
    super.initState();
    checkConnection();

    checkUserBaru();
    getUsername();
  }

  bool isRegister = false;
  bool isPilihProvinsi = false;
  bool isPilihKota = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: !isRegister ? Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30.0,),
                  SafeArea(child: Image.asset('assets/logo/app.png', width: MediaQuery.of(context).size.width/2,)),
                  SizedBox(height: 15.0,),
                  TextField(
                    controller: controllerUsername,
                    // initialValue: snapshot.hasData ? dbModel[0].user : "",
                    obscureText: false,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        hintText: "Username",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                  ),
                  SizedBox(height: 15.0,),
                  TextField(
                    controller: controllerPassword,
                    obscureText: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        hintText: "Password",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                  ),
                  SizedBox(height: 15.0,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Text('Lupa password? ', style: TextStyle(color: Colors.black54,)),
                  //     GestureDetector(
                  //       onTap: (){},
                  //       child: Text('Dapatkan bantuan. ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[400],)),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 15.0,),
                  MyIconButton(
                    onPressed: (){
                      checkLogin();
                    },
                    backgroundColor: Color(0xFFff971d),
                    color: Colors.white,
                    shadowColorTopLeft: Color(0xFFffffff),
                    shadowColorBottomRight: Color(0xFFa3b1c6),
                    text: 'Masuk',
                    icon: Icon(LineIcons.paper_plane, color: Colors.white,),
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                children: <Widget>[
                  SafeArea(
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 15.0,),
                          Text('Daftar akun baru', style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('Isi data dirimu terlebih dahulu.', style: TextStyle(color: Colors.black54, fontSize: 16))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  TextField(
                    obscureText: false,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        hintText: "Nama",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                  ),
                  SizedBox(height: 15.0,),
                  TextField(
                    obscureText: false,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        hintText: "Email",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                  ),
                  SizedBox(height: 15.0,),
                  TextField(
                    obscureText: false,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        hintText: "No. HP",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                  ),
                  SizedBox(height: 15.0,),
                  TextField(
                    obscureText: false,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        hintText: "Alamat",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                  ),
                  SizedBox(height: 15.0,),
                  MyContainer(
                    width: double.infinity,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => setState(() => isPilihProvinsi = true),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Pilih Provinsi', style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),),
                            Icon(LineIcons.angle_right, color: Colors.orange,)
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
                        onTap: () => setState(() => isPilihKota = true ),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Pilih Kota', style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),),
                            Icon(LineIcons.angle_right, color: Colors.orange,)
                          ],
                        ),),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  TextField(
                    obscureText: false,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        hintText: "Username",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                  ),
                  SizedBox(height: 15.0,),
                  TextField(
                    obscureText: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        hintText: "Password",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                  ),
                  SizedBox(height: 15.0,),
                  TextField(
                    obscureText: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        hintText: "Ketik ulang Password",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
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
                    children: <Widget>[
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
            isPilihProvinsi ? Positioned.fill(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onVerticalDragDown: (update) => setState(() => isPilihProvinsi = false),
                      onTap: () => setState(() => isPilihProvinsi = false),
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                          Text('Batal'),
                          Material(color: Colors.transparent, child: InkWell(
                            onTap: () => setState(() => isPilihProvinsi = false),
                            borderRadius: BorderRadius.circular(25.0),
                            child: Padding(padding: EdgeInsets.all(5.0), child: Icon(LineIcons.close),),
                          ),),
                        ],),
                        Container(
                          height: 250.0,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: <Widget>[
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
                      ],
                    ),
                  )
                ],
              ),
            ) : isPilihKota ? Positioned.fill(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onVerticalDragDown: (update) => setState(() => isPilihKota = false),
                      onTap: () => setState(() => isPilihKota = false),
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                          Text('Batal'),
                          Material(color: Colors.transparent, child: InkWell(
                            onTap: () => setState(() => isPilihKota = false),
                            borderRadius: BorderRadius.circular(25.0),
                            child: Padding(padding: EdgeInsets.all(5.0), child: Icon(LineIcons.close),),
                          ),),
                        ],),
                        Container(
                          height: 250.0,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: <Widget>[
                              ListViewItemsProvinsi(onTap: (){}, text: 'Surabaya',),
                              ListViewItemsProvinsi(onTap: (){}, text: 'Lumajang',),
                              ListViewItemsProvinsi(onTap: (){}, text: 'Jember',),
                              ListViewItemsProvinsi(onTap: (){}, text: 'Kediri',),
                              ListViewItemsProvinsi(onTap: (){}, text: 'Kab. Probolinggo',),
                              ListViewItemsProvinsi(onTap: (){}, text: 'Kab. Pasuruan',),
                              ListViewItemsProvinsi(onTap: (){}, text: 'Kab. Malang',),
                              ListViewItemsProvinsi(onTap: (){}, text: 'Kota Pasuruan',),
                              ListViewItemsProvinsi(onTap: (){}, text: 'Kota Malang',),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}

class ListViewItemsProvinsi extends StatelessWidget {
  ListViewItemsProvinsi({this.onTap, this.text});

  final VoidCallback onTap;
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