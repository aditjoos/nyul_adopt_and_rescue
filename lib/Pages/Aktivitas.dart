import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';

class AktivitasPage extends StatefulWidget {
  @override
  _AktivitasPageState createState() => _AktivitasPageState();
}

class _AktivitasPageState extends State<AktivitasPage> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFAFAFA),
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              child: Material(
                color: Colors.transparent,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.orange,
                  labelColor: Colors.black54,
                  tabs: <Widget>[
                    Tab(
                      child: Text('Adopsi'),
                    ),
                    Tab(
                      child: Text('Rescue'),
                    ),
                    Tab(
                      child: Text('Feeding'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                controller: _tabController,
                children: <Widget>[
                  // tab 1
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        AdopsiContainer(
                          img: 'assets/images/cat-feedpage.png',
                          title: 'Kucing lokal',
                          pemilikLama: 'Bagus Aditama',
                          tanggal: '2020-05-05',
                          status: 1,
                        ),
                        AdopsiContainer(
                          img: 'assets/images/cat-feedpage.png',
                          title: 'Kucing anggora',
                          pemilikLama: 'Mohammad Ryzky Reynaldy',
                          tanggal: '2020-05-05',
                          status: 2,
                        ),
                        SizedBox(height: 120.0,)
                      ],
                    ),
                  ),
                  // tab 2
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        RescueContainer(
                          img: 'assets/images/cat-feedpage.png',
                          title: 'Tetangga memelihara cheetah',
                          diselamatkanOleh: 1,
                          tanggal: '2020-05-05',
                        ),
                        RescueContainer(
                          img: 'assets/images/cat-feedpage.png',
                          title: 'Singa masuk perkampungan',
                          diselamatkanOleh: 2,
                          tanggal: '2020-05-05',
                        ),
                      ],
                    ),
                  ),
                  // tab 3
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        FeedingContainer(
                          title: 'street feeding bululawang',
                          alamat: 'pasar bululawang',
                          tanggal: '2020-05-05',
                          jam: '13:00',
                        ),
                        FeedingContainer(
                          title: '2 Kucing sebelah al**mart',
                          alamat: 'Jl. blabla no 000',
                          tanggal: '2020-05-05',
                          jam: '13:00',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AdopsiContainer extends StatelessWidget {
  AdopsiContainer({
    required this.img, 
    required this.title, 
    required this.pemilikLama, 
    required this.tanggal, 
    required this.status
  });

  final String img;
  final String title;
  final String pemilikLama;
  final String tanggal;
  final int status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: MyContainer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 70.0,
              height: 70.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(img, fit: BoxFit.fill,)
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold),maxLines: 3,)),
                            Text(tanggal)
                          ],
                        ),
                        Text(pemilikLama, style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Status : '),
                        Container(
                          decoration: BoxDecoration(
                            color: status == 1 ? Colors.orange[400] : Colors.green[400],
                            borderRadius: BorderRadius.circular(8.0)
                          ),
                          padding: EdgeInsets.all(5.0),
                          child: Text(status == 1 ? 'Diproses' : 'Selesai', style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        width: double.infinity,
      ),
    );
  }
}

class RescueContainer extends StatelessWidget {
  RescueContainer({
    required this.img, 
    required this.title, 
    required this.diselamatkanOleh, 
    required this.tanggal
  });

  final String img;
  final String title;
  final int diselamatkanOleh;
  final String tanggal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: MyContainer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 70.0,
              height: 70.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(img, fit: BoxFit.fill,)
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold),maxLines: 3,)),
                            Text(tanggal)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Diselamatkan oleh : '),
                            Text(diselamatkanOleh == 1 ? 'saya sendiri' : 'orang lain', style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        width: double.infinity,
      ),
    );
  }
}

class FeedingContainer extends StatelessWidget {
  FeedingContainer({
    required this.title, 
    required this.alamat, 
    required this.tanggal, 
    required this.jam
  });

  final String title;
  final String alamat;
  final String tanggal;
  final String jam;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: MyContainer(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(fontWeight: FontWeight.bold),maxLines: 3,),
            Text(alamat, maxLines: 3,),
            Text(tanggal),
            Text(jam),
          ],
        ),
        width: double.infinity,
      ),
    );
  }
}