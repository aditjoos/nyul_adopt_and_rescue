import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nyul_adopt_rescue/components/ContainerAndButtons.dart';
import 'package:nyul_adopt_rescue/components/Dialogs.dart';

class EventDetailPage extends StatefulWidget {
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {

  @override
  void initState() {
    super.initState();
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
                    IconButton(icon: Icon(LineIcons.arrowLeft), onPressed: () => Navigator.pop(context)),
                    Text('Kembali')
                  ],
                ),
              ),
              Center(child: Text('Detail Event', style: TextStyle(fontSize: 20.0),),),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: MyContainer(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('2 Kucing sebelah supermarket', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8.0,),
                        Text('Ada 2 kucing didekat perumahan, terlihat sangat kurus dan tidak terurus. bantu saya memberi makan.', style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 8.0,),
                        Text('Lokasi', style: TextStyle(fontSize: 18.0,)),
                        SizedBox(height: 8.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(LineIcons.map),
                            SizedBox(width: 8.0,),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Jl. blabla No.000', style: TextStyle(color: Colors.grey)),
                                  Text('sebelah supermarket dan gudang warna merah', style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8.0,),
                        Text('Waktu', style: TextStyle(fontSize: 18.0,)),
                        SizedBox(height: 8.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(LineIcons.clock),
                            SizedBox(width: 8.0,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('2020-05-05', style: TextStyle(color: Colors.grey)),
                                Text('13:00', style: TextStyle(color: Colors.grey)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 8.0,),
                        Text('Member', style: TextStyle(fontSize: 18.0,)),
                        SizedBox(height: 8.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(LineIcons.users),
                            SizedBox(width: 8.0,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Maksimal anggota : 15', style: TextStyle(color: Colors.grey)),
                                Text('Anggota terdaftar : 10', style: TextStyle(color: Colors.grey)),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Text('Saat berada ditempat, admin event akan melakukan presensi member dan member akan mendapatkan poin.', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 10.0,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.orange[400]
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Text('Ikut', style: TextStyle(color: Colors.white),),
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