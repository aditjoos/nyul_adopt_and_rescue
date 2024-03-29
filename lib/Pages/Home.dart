import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nyul_adopt_rescue/Pages/Adopsi/Adopsi.dart';
import 'package:nyul_adopt_rescue/Pages/Adopsi/AdopsiDetail.dart';
import 'package:nyul_adopt_rescue/Pages/Dokter/Dokter.dart';
import 'package:nyul_adopt_rescue/Pages/Rescue/Rescue.dart';
import 'package:nyul_adopt_rescue/Pages/Rescue/RescueDetail.dart';
import 'package:nyul_adopt_rescue/components/ContainerAndButtons.dart';
import 'package:nyul_adopt_rescue/components/Dialogs.dart';
import 'package:nyul_adopt_rescue/helper/apiHelper_nyul.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late var _data2;
  bool _isLoadingData2 = true;
  bool _isData2 = false;

  _getRescueDaruratData() {
    Map<String, dynamic> parameters = {
      'urgensi' : '1'
    };

    APIHelperNyul().getData('nyul-codeigniter/index.php/rescue/post_rescue_home', parameters).then((value) {
      if(value['result']) {
        setState(() {
          _data2 = value['data'];
          _isLoadingData2 = false;
          _isData2 = true;
        });
      } else {
        setState(() {
          _isLoadingData2 = false;
          _isData2 = false;
        });

        MyDialogs().simpleDialog(context, 'Kesalahan', '${value['message']}');
      }
    });
  }

  late var _data;
  bool _isLoadingData = true;
  bool _isData = false;

  _getAdopsiData() {
    Map<String, dynamic> parameters = {
      'fungsi' : '1',
    };

    APIHelperNyul().getData('nyul-codeigniter/index.php/adopsi/post_adopt', parameters).then((value) {
      if(value['result']) {
        setState(() {
          _data = value['data'];
          _isLoadingData = false;
          _isData = true;
        });
      } else {
        setState(() {
          _isLoadingData = false;
          _isData = false;
        });

        MyDialogs().simpleDialog(context, 'Kesalahan', '${value['message']}');
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
                      child: Container(
                        width: double.infinity,
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
                      // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EventsPage())),
                      onTap: () => MyDialogs().simpleDialog(context, 'Kesalahan', 'Halaman/fitur ini masih dalam tahap konstruksi, mohon ditunggu ya~ \n^_^)/'),
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
                        // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PetShopPage())),
                        onTap: () => MyDialogs().simpleDialog(context, 'Kesalahan', 'Halaman/fitur ini masih dalam tahap konstruksi, mohon ditunggu ya~ \n^_^)/'),
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
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RescueDetailPage(idPostRescue: _data2[i]['kode_request_rescue'],))),
                      jenisHewan: _data2[i]['Jenis_hewan'],
                      alamat: _data2[i]['alamat_detail'],
                      judul: _data2[i]['judul'],
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
                  height: 320.0,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _data.isEmpty ? 0 : _data.length,
                    itemBuilder: (context, index) => PostAdopsiCard(
                      imgSource: 'assets/images/real-cat.jpg',
                      judul: _data[index]['judul'] == null ? '-' : _data[index]['judul'],
                      jenis: 1,
                      ras: '-',
                      umur: _data[index]['umur'] == null ? '-' : _data[index]['umur'],
                      alamat: _data[index]['alamat'] == null ? '-' : _data[index]['alamat'],
                      metodeAdopsi: int.parse(_data[index]['metode_adopsi'] == null ? '0' : _data[index]['metode_adopsi']),
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
                  height: 320.0,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _data.isEmpty ? 0 : _data.length,
                    itemBuilder: (context, index) => PostAdopsiCard(
                      imgSource: 'assets/images/real-dog.jpg',
                      judul: _data[index]['judul'] == null ? '-' : _data[index]['judul'],
                      jenis: 1,
                      ras: '-',
                      umur: _data[index]['umur'] == null ? '-' : _data[index]['umur'],
                      alamat: _data[index]['alamat'] == null ? '-' : _data[index]['alamat'],
                      metodeAdopsi: int.parse(_data[index]['metode_adopsi'] == null ? '0' : _data[index]['metode_adopsi']),
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
                  height: 320.0,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _data.isEmpty ? 0 : _data.length,
                    itemBuilder: (context, index) => PostAdopsiCard(
                      imgSource: 'assets/images/real-rabbit.jpg',
                      judul: _data[index]['judul'] == null ? '-' : _data[index]['judul'],
                      jenis: 1,
                      ras: '-',
                      umur: _data[index]['umur'] == null ? '-' : _data[index]['umur'],
                      alamat: _data[index]['alamat'] == null ? '-' : _data[index]['alamat'],
                      metodeAdopsi: int.parse(_data[index]['metode_adopsi'] == null ? '0' : _data[index]['metode_adopsi']),
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