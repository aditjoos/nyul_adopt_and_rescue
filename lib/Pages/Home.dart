import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Variable for Get Adopt
  List data;
  bool isLoadingData = true;
  bool isData = false;

  //Variable for Get Rescue
  List data2;
  bool isLoadingData2 = true;
  bool isData2 = false;

  Future getRescueDaruratData() async {
    final String url = 'http://http://192.168.43.58/nyul-codeigniter/index.php/rescue/post_rescue_home?urgensi=1';
    var result = await http.get(Uri.encodeFull(url), headers: { 'accept':'application/json' });

    setState(() {
      if(result.statusCode == 200){
        var content = json.decode(result.body);
        if(content['result'] = true){
          data2 = content['data'];
          isData2 = true;
          // print(data2);
        }else if(content['result'] = false){
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) => FunkyOverlay(
              content['data'],
              [
                FlatButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
              ]
            )
          );
        }
      }
      isLoadingData2 = false;
    });
  }

  //TODO :
  //belum pakai where jenis hewan 
  Future getAdopsiData() async {
    final String url = 'http://http://192.168.43.58/nyul-codeigniter/index.php/adopsi/post_adopt?fungsi=1';
    var result = await http.get(Uri.encodeFull(url), headers: { 'accept':'application/json' });

    setState(() {
      if(result.statusCode == 200){
        var content = json.decode(result.body);
        if(content['result'] = true){
          data = content['data'];
          isData = true;
        }else if(content['result'] = false){
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) => FunkyOverlay(
              content['data'],
              [
                FlatButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
              ]
            )
          );
        }
      }
      isLoadingData = false;
    });
  }

  void checkConnectionThenExecuteLoadDataFunction() async {
    try {
      final result = await InternetAddress.lookup('http://192.168.43.58/nyul-codeigniter/');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //TODO :
        //manggil banyak function
        // 1. get adopsi jenis kucing
        // 2. get adopsi jenis anjing
        // 3. get adopsi jenis kelinci
        getRescueDaruratData();
        getAdopsiData();
      }
    } on SocketException catch (_) {
      showDialog(barrierDismissible: true, context: context, builder: (_) => FunkyOverlay('Sepertinya kamu tidak ada koneksi internet, periksa dulu ya.. \n(´。＿。｀)', [FlatButton(onPressed: () => Navigator.pop(context), child: Text('OK'))]));
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
                        borderColor: Colors.orange[300],
                        icon: Icon(FontAwesomeIcons.briefcaseMedical),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DokterPage())),
                        title: 'Dokter',
                      ),
                      SizedBox(width: 20.0,),
                      CustomIconButtonWithTitle(
                        backgroundColor: Colors.white,
                        borderColor: Colors.orange[300],
                        icon: Icon(FontAwesomeIcons.shoppingBag),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PetShopPage())),
                        title: 'Pet Shop',
                      ),
                      SizedBox(width: 20.0,),
                      CustomIconButtonWithTitle(
                        backgroundColor: Colors.white,
                        borderColor: Colors.orange[300],
                        icon: Icon(FontAwesomeIcons.archive),
                        onTap: () => showDialog(barrierDismissible: true, context: context, builder: (_) => FunkyOverlay('Halaman/fitur ini masih dalam tahap konstruksi, mohon ditunggu ya~ \n^_^)/', [FlatButton(onPressed: () => Navigator.pop(context), child: Text('OK'))])),
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
                isLoadingData2 ? Center(child: CircularProgressIndicator(),) : isData2 ? SizedBox(
                  height: 120.0,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: data2 == null ? 0 : data2.length,
                    itemBuilder: (BuildContext context, int index){
                      return UrgentRescueCard(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RescueDetailPage())),
                        jenisHewan: data2[index]['Jenis_hewan'],
                        alamat: data2[index]['alamat_detail'],
                        judul: data2[index]['judul'],
                        // jenisHewan: 'test',
                        // alamat: 'test',
                        // judul: 'test',
                      );
                    },
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
                isLoadingData ? Center(child: CircularProgressIndicator(),) : isData ? SizedBox(
                  height: 250.0,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: data == null ? 0 : data.length,
                    itemBuilder: (BuildContext context, int index){
                      return PostAdopsiCard(
                        imgSource: 'assets/images/real-cat.jpg',
                        judul: data[index]['judul'],
                        jenis: 1,
                        ras: '-',
                        umur: data[index]['umur'],
                        alamat: data[index]['alamat'],
                        metodeAdopsi: int.parse(data[index]['metode_adopsi']),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdopsiDetailPage())),
                      );
                    },
                  ),
                ) : Center(child: Text('Tidak ada data.'),),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Anjing', style: TextStyle(fontWeight: FontWeight.bold),),
                  alignment: Alignment.centerLeft,
                ),
                isLoadingData ? Center(child: CircularProgressIndicator(),) : isData ? SizedBox(
                  height: 250.0,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: data == null ? 0 : data.length,
                    itemBuilder: (BuildContext context, int index){
                      return PostAdopsiCard(
                        imgSource: 'assets/images/real-dog.jpg',
                        judul: data[index]['judul'],
                        jenis: 1,
                        ras: '-',
                        umur: data[index]['umur'],
                        alamat: data[index]['alamat'],
                        metodeAdopsi: int.parse(data[index]['metode_adopsi']),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdopsiDetailPage())),
                      );
                    },
                  ),
                ) : Center(child: Text('Tidak ada data.'),),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Kelinci', style: TextStyle(fontWeight: FontWeight.bold),),
                  alignment: Alignment.centerLeft,
                ),
                isLoadingData ? Center(child: CircularProgressIndicator(),) : isData ? SizedBox(
                  height: 250.0,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: data == null ? 0 : data.length,
                    itemBuilder: (BuildContext context, int index){
                      return PostAdopsiCard(
                        imgSource: 'assets/images/real-rabbit.jpg',
                        judul: data[index]['judul'],
                        jenis: 1,
                        ras: '-',
                        umur: data[index]['umur'],
                        alamat: data[index]['alamat'],
                        metodeAdopsi: int.parse(data[index]['metode_adopsi']),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdopsiDetailPage())),
                      );
                    },
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
    this.icon,
    this.title,
    this.backgroundColor,
    this.borderColor,
    this.onTap
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
    this.assetImage,
    this.title,
    this.onTap,
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
                color: Colors.grey[200],
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
    this.onTap,
    this.jenisHewan,
    this.alamat,
    this.judul,
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
                    child: Icon(LineIcons.warning, size: 50.0, color: Colors.white,),
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