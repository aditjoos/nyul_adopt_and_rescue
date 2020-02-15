import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                          Icon(LineIcons.envelope, color: Colors.white,),
                          Icon(LineIcons.heart, color: Colors.white,),
                          Icon(LineIcons.bell, color: Colors.white,),
                        ],
                      ),
                    )
                    
                    //text

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
          Text('Eksplorasi.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Color(0xFF606060)),),
          Row(
            children: <Widget>[
              MainFeatureCard(
                assetImage: 'assets/images/adoptme-bublee.png',
                title: 'Adopt Me',
                onTap: (){},
              ),
              MainFeatureCard(
                assetImage: 'assets/images/saveme-bublee.png',
                title: 'Save Me',
                onTap: (){},
              ),
              MainFeatureCard(
                assetImage: 'assets/images/feedme-bublee.png',
                title: 'Feed Me',
                onTap: (){},
              ),
            ],
          ),
          SizedBox(height: 15.0,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                SizedBox(width: 20.0,),
                CustomIconButtonWithTitle(
                  backgroundColor: Colors.white,
                  borderColor: Colors.orange[300],
                  icon: Icon(FontAwesomeIcons.briefcaseMedical),
                  onTap: (){},
                  title: 'Dokter',
                ),
                SizedBox(width: 20.0,),
                CustomIconButtonWithTitle(
                  backgroundColor: Colors.white,
                  borderColor: Colors.orange[300],
                  icon: Icon(FontAwesomeIcons.shoppingBag),
                  onTap: (){},
                  title: 'Pet Shop',
                ),
                SizedBox(width: 20.0,),
                CustomIconButtonWithTitle(
                  backgroundColor: Colors.white,
                  borderColor: Colors.orange[300],
                  icon: Icon(FontAwesomeIcons.archive),
                  onTap: (){},
                  title: 'Shelter',
                ),
                SizedBox(width: 20.0,),
                CustomIconButtonWithTitle(
                  backgroundColor: Colors.white,
                  borderColor: Colors.orange[300],
                  icon: Icon(FontAwesomeIcons.cat),
                  onTap: (){},
                  title: 'Cattery',
                ),
                SizedBox(width: 20.0,),
                CustomIconButtonWithTitle(
                  backgroundColor: Colors.white,
                  borderColor: Colors.orange[300],
                  icon: Icon(FontAwesomeIcons.fileContract),
                  onTap: (){},
                  title: 'Riwayat',
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                // Urgent Rescue Card
                UrgentRescueCard(
                  tipeHewan: 1,
                  alamat: 'Jl. Bululawang 666',
                  deskripsi: 'Terkapar setelah tertabrak angin',
                ),
                UrgentRescueCard(
                  tipeHewan: 2,
                  alamat: 'Jl. Arjosari 666',
                  deskripsi: 'Ditikung temen, anjing emang.',
                ),
                UrgentRescueCard(
                  tipeHewan: 3,
                  alamat: 'Jl. Kepanjen 666',
                  deskripsi: 'Hilang impian setelah bangun tidur.',
                ),
              ],
            ),
          ),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                PostAdopsiCard(
                  imgSource: 'assets/images/tom.jpg',
                  judul: 'Kucing Himalaya',
                  jenis: 1,
                  ras: 'British',
                  umur: '1 Tahun',
                  alamat: 'Tidar, Malang',
                  metodeAdopsi: 1,
                ),
                PostAdopsiCard(
                  imgSource: 'assets/images/tom.jpg',
                  judul: 'Kucing India',
                  jenis: 1,
                  ras: 'Persia',
                  umur: '5 Bulan',
                  alamat: 'Arjosari, Malang',
                  metodeAdopsi: 2,
                ),
                PostAdopsiCard(
                  imgSource: 'assets/images/tom.jpg',
                  judul: 'Kucing Manja',
                  jenis: 1,
                  ras: 'Lokal',
                  umur: '2 Tahun',
                  alamat: 'Blimbing, Malang',
                  metodeAdopsi: 1,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Anjing', style: TextStyle(fontWeight: FontWeight.bold),),
            alignment: Alignment.centerLeft,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                PostAdopsiCard(
                  imgSource: 'assets/images/dog.jpg',
                  judul: 'Anjing Nakal',
                  jenis: 2,
                  ras: 'Bulldog',
                  umur: '1 Tahun',
                  alamat: 'Tidar, Malang',
                  metodeAdopsi: 2,
                ),
                PostAdopsiCard(
                  imgSource: 'assets/images/dog.jpg',
                  judul: 'Anjing gatau Diri',
                  jenis: 2,
                  ras: 'Bulldog',
                  umur: '5 Bulan',
                  alamat: 'Arjosari, Malang',
                  metodeAdopsi: 1,
                ),
                PostAdopsiCard(
                  imgSource: 'assets/images/dog.jpg',
                  judul: 'Anjing Kau',
                  jenis: 2,
                  ras: 'Bulldog',
                  umur: '2 Tahun',
                  alamat: 'Blimbing, Malang',
                  metodeAdopsi: 1,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Kelinci', style: TextStyle(fontWeight: FontWeight.bold),),
            alignment: Alignment.centerLeft,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                PostAdopsiCard(
                  imgSource: 'assets/images/rabbit.jpeg',
                  judul: 'Kelinci Playboy',
                  jenis: 2,
                  ras: '-',
                  umur: '1 Tahun',
                  alamat: 'Tidar, Malang',
                  metodeAdopsi: 2,
                ),
                PostAdopsiCard(
                  imgSource: 'assets/images/rabbit.jpeg',
                  judul: 'Kelinci Pendek',
                  jenis: 2,
                  ras: '-',
                  umur: '5 Bulan',
                  alamat: 'Arjosari, Malang',
                  metodeAdopsi: 2,
                ),
                PostAdopsiCard(
                  imgSource: 'assets/images/rabbit.jpeg',
                  judul: 'Kelinci loncat2',
                  jenis: 2,
                  ras: '-',
                  umur: '2 Tahun',
                  alamat: 'Blimbing, Malang',
                  metodeAdopsi: 1,
                ),
              ],
            ),
          ),
          SizedBox(height: 120.0,)
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

class UrgentRescueCard extends StatefulWidget {
  UrgentRescueCard({
    this.tipeHewan,
    this.alamat,
    this.deskripsi,
  });

  final int tipeHewan;
  final String alamat;
  final String deskripsi;

  @override
  _UrgentRescueCardState createState() => _UrgentRescueCardState();
}

class _UrgentRescueCardState extends State<UrgentRescueCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: (){},
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
                        Text(widget.tipeHewan == 1 ? 'Kucing' : widget.tipeHewan == 2 ? 'Anjing' : widget.tipeHewan == 3 ? 'Kelinci' : 'Tidak diketahui', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white)),
                        Text(widget.alamat, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.white)),
                        Text(widget.deskripsi, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.white))
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