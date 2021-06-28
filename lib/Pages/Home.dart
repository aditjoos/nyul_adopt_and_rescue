import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mysql1/mysql1.dart';
import 'package:petz_invention_udayana/Pages/Adopsi/Adopsi.dart';
import 'package:petz_invention_udayana/Pages/Adopsi/AdopsiDetail.dart';
import 'package:petz_invention_udayana/Pages/Adopsi/AdopsiFavorites.dart';
import 'package:petz_invention_udayana/Pages/Dokter/Dokter.dart';
import 'package:petz_invention_udayana/Pages/Events/Events.dart';
import 'package:petz_invention_udayana/Pages/PetShop/PetShop.dart';
import 'package:petz_invention_udayana/Pages/Rescue/Rescue.dart';
import 'package:petz_invention_udayana/Pages/Rescue/RescueDetail.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';
import 'package:petz_invention_udayana/database/mysqlHelper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late MySql _mysql;

  late List<ResultRow> _data2;
  bool _isLoadingData2 = true;
  bool _isData2 = false;

  _getRescueDaruratData() {
    _mysql.getData('SELECT kode_request_rescue, judul, jenis_hewan, alamat_detail FROM post_rescue WHERE urgensi = 1').then((value) {
      if(value.isNotEmpty) {
        setState(() {
          _data2 = value;
          _isLoadingData2 = false;
          _isData2 = true;

          print(_data2[0][0]);
        });
      } else {
        setState(() {
          _isLoadingData2 = false;
          _isData2 = false;
        });
      }
    });
  }

  late List _data;
  bool _isLoadingData = true;
  bool _isData = false;

  _getAdopsiData() {
    _mysql.getData('SELECT judul, umur, alamat, metode_adopsi FROM post_adopt LIMIT 5').then((value) {
      if(value.isNotEmpty) {
        setState(() {
          _data = value;
          _isLoadingData = false;
          _isData = true;

          print(_data[0][0]);
        });
      } else {
        setState(() {
          _isLoadingData = false;
          _isData = false;
        });
      }
    });
  }

  void checkConnectionThenExecuteLoadDataFunction() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _getRescueDaruratData();
        _getAdopsiData();
      } else MyDialogs().simpleDialog(context, 'Kesalahan', 'Ada kesalahan koneksi internet.');
    } on SocketException catch (_) {
      MyDialogs().simpleDialog(context, 'Kesalahan', 'Kamu tidak ada koneksi internet.');
    }
  }

  @override
  void initState() {
    super.initState();

    _mysql = new MySql(context);

    checkConnectionThenExecuteLoadDataFunction();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 250.0,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Search Bar
                          Container(
                            width: MediaQuery.of(context).size.width/1.5,
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Cari ', style: TextStyle(fontWeight: FontWeight.bold),),
                                Icon(LineIcons.search)
                              ],
                            ),
                          ),

                          //Actions Bar
                          IconButton(icon: Icon(LineIcons.heart, color: Colors.white,), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdopsiFavoritesPage()))),
                          Icon(LineIcons.bell, color: Colors.white,),
                        ],
                      ),
                    ),
                    //text
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 35, 8.0, 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('They are people too!', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),),
                          Text('Hidup mereka berat, bukan cuma hidup kita! Bangun skuy, jangan cuma rebahan! Mereka membutuhkan kita.', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                    //sub text -> scroll view horizontal
                  ],
                ),
                color: Colors.orange[400],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
                  ),
                ),
              )
            ],
          ),
          Container(
            color: Color(0xFFFAFAFA),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Eksplorasi.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Color(0xFF606060)),),
                Row(
                  children: <Widget>[
                    MainFeatureCard(
                      assetImage: 'assets/images/adoptme-bublee.png',
                      title: 'Adoption',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdopsiPage())),
                    ),
                    MainFeatureCard(
                      assetImage: 'assets/images/saveme-bublee.png',
                      title: 'Rescue',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RescuePage())),
                    ),
                    MainFeatureCard(
                      assetImage: 'assets/images/feedme-bublee.png',
                      title: 'Feeding',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EventsPage())),
                    ),
                  ],
                ),
                SizedBox(height: 15.0,),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 20.0,),
                      CustomIconButtonWithTitle(
                        backgroundColor: Colors.white,
                        borderColor: Colors.orange.shade300,
                        icon: Icon(FontAwesomeIcons.briefcaseMedical),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DokterPage())),
                        title: 'Dokter',
                      ),
                      SizedBox(width: 20.0,),
                      CustomIconButtonWithTitle(
                        backgroundColor: Colors.white,
                        borderColor: Colors.orange.shade300,
                        icon: Icon(FontAwesomeIcons.shoppingBag),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PetShopPage())),
                        title: 'Pet Shop',
                      ),
                      SizedBox(width: 20.0,),
                      CustomIconButtonWithTitle(
                        backgroundColor: Colors.white,
                        borderColor: Colors.orange.shade300,
                        icon: Icon(FontAwesomeIcons.archive),
                        onTap: () => MyDialogs().simpleDialog(context, 'Kesalahan', 'Halaman/fitur ini masih dalam tahap konstruksi, mohon ditunggu ya~ \n^_^)/'),
                        title: 'Shelter',
                      ),
                      SizedBox(width: 20.0,),
                    ],
                  ),
                ),
                SizedBox(height: 15.0,),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Hewan kondisi darurat disekitarmu', style: TextStyle(fontWeight: FontWeight.bold),),
                  alignment: Alignment.centerLeft,
                ),
                _isLoadingData2 ? Center(child: CircularProgressIndicator(),) : _isData2 ? SizedBox(
                  height: 120.0,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _data2.isEmpty ? 0 : _data2.length,
                    itemBuilder: (context, i) => UrgentRescueCard(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RescueDetailPage())),
                      judul: _data2[i][1],
                      jenisHewan: _data2[i][2],
                      alamat: _data2[i][3],
                      // jenisHewan: 'test',
                      // alamat: 'test',
                      // judul: 'test',
                    ),
                  ),
                ) : Center(child: Text('Tidak ada data.'),),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                  color: Colors.orange[400],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Postingan adopsi terbaru', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),),
                      Icon(LineIcons.paw, color: Colors.white),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Kucing', style: TextStyle(fontWeight: FontWeight.bold),),
                  alignment: Alignment.centerLeft,
                ),
                _isLoadingData ? Center(child: CircularProgressIndicator(),) : _isData ? SizedBox(
                  height: 250.0,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _data.isEmpty ? 0 : _data.length,
                    itemBuilder: (context, index) => PostAdopsiCard(
                      imgSource: 'assets/images/real-cat.jpg',
                      judul: _data[index][0],
                      jenis: 1,
                      ras: '-',
                      umur: _data[index][1].toString(),
                      alamat: _data[index][2],
                      metodeAdopsi: _data[index][3],
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdopsiDetailPage())),
                    ),
                  ),
                ) : Center(child: Text('Tidak ada data.'),),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Anjing', style: TextStyle(fontWeight: FontWeight.bold),),
                  alignment: Alignment.centerLeft,
                ),
                _isLoadingData ? Center(child: CircularProgressIndicator(),) : _isData ? SizedBox(
                  height: 250.0,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _data.isEmpty ? 0 : _data.length,
                    itemBuilder: (context, index) => PostAdopsiCard(
                      imgSource: 'assets/images/real-dog.jpg',
                      judul: _data[index][0],
                      jenis: 1,
                      ras: '-',
                      umur: _data[index][1].toString(),
                      alamat: _data[index][2],
                      metodeAdopsi: _data[index][3],
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdopsiDetailPage())),
                    ),
                  ),
                ) : Center(child: Text('Tidak ada data.'),),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Kelinci', style: TextStyle(fontWeight: FontWeight.bold),),
                  alignment: Alignment.centerLeft,
                ),
                _isLoadingData ? Center(child: CircularProgressIndicator(),) : _isData ? SizedBox(
                  height: 250.0,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _data.isEmpty ? 0 : _data.length,
                    itemBuilder: (context, index) => PostAdopsiCard(
                      imgSource: 'assets/images/real-rabbit.jpg',
                      judul: _data[index][0],
                      jenis: 1,
                      ras: '-',
                      umur: _data[index][1].toString(),
                      alamat: _data[index][2],
                      metodeAdopsi: _data[index][3],
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdopsiDetailPage())),
                    ),
                  ),
                ) : Center(child: Text('Tidak ada data.'),),
                SizedBox(height: 120.0,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIconButtonWithTitle extends StatefulWidget {
  CustomIconButtonWithTitle({
    required this.icon,
    required this.title,
    required this.backgroundColor,
    required this.borderColor,
    required this.onTap
  });

  final Icon icon;
  final String title;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  _CustomIconButtonWithTitleState createState() => _CustomIconButtonWithTitleState();
}

class _CustomIconButtonWithTitleState extends State<CustomIconButtonWithTitle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: widget.icon,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              border: Border.all(
                color: widget.borderColor,
                style: BorderStyle.solid,
                width: 5
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          SizedBox(height: 10.0,),
          Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
      onTap: widget.onTap,
    );
  }
}

class MainFeatureCard extends StatefulWidget {
  MainFeatureCard({
    required this.assetImage,
    required this.title,
    required this.onTap,
  });

  final String assetImage;
  final String title;
  final VoidCallback onTap;

  @override
  _MainFeatureCardState createState() => _MainFeatureCardState();
}

class _MainFeatureCardState extends State<MainFeatureCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width/3,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(0.0, 2.0),
                blurRadius: 10.0,
                spreadRadius: 1.0
              )
            ]
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset(widget.assetImage, height: 100.0,),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UrgentRescueCard extends StatelessWidget {
  UrgentRescueCard({
    required this.onTap,
    required this.jenisHewan,
    required this.alamat,
    required this.judul,
  });

  final VoidCallback onTap;
  final String jenisHewan;
  final String alamat;
  final String judul;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red[400],
            borderRadius: BorderRadius.circular(15.0),
          ),
          width: 250.0,
          height: 100.0,
          child: Stack(
            children: <Widget>[
              Image.asset('assets/images/BG1.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(LineIcons.exclamationTriangle, size: 50.0, color: Colors.white,),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(jenisHewan, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white)),
                        Text(alamat, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.white)),
                        Text(judul, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.white))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}