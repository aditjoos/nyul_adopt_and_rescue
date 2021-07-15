import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nyul_adopt_rescue/Pages/Pesan/PesanUser.dart';
import 'package:nyul_adopt_rescue/Pages/Rescue/RescueProcess.dart';
import 'package:nyul_adopt_rescue/components/ContainerAndButtons.dart';

class RescueDetailPage extends StatefulWidget {
  @override
  _RescueDetailPageState createState() => _RescueDetailPageState();
}

class _RescueDetailPageState extends State<RescueDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(width: MediaQuery.of(context).size.width, child: Image.asset('assets/images/rescue_mika_brandt.png', fit: BoxFit.fill,)),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: SafeArea(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  IconButton(icon: Icon(LineIcons.arrowLeft, color: Colors.white), onPressed: () => Navigator.pop(context)),
                                  Text('Kembali', style: TextStyle(color: Colors.white),)
                                ],),
                                Row(children: <Widget>[
                                  IconButton(icon: Icon(LineIcons.share, color: Colors.white), onPressed: (){}),
                                  IconButton(icon: Icon(LineIcons.dotCircle, color: Colors.white), onPressed: (){}),
                                ],),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                    child: MyContainer(
                      padding: EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Orang memelihara harimau', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5.0,),
                          Text('Deskripsi'),
                          Text('Tolong selamatkan harimau yang dipelihara tetangga saya, dan keberadaan harimau tersebut sangat meresahkan warga.', style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 5.0,),
                          Text('Alamat'),
                          Text('Kab. Malang', style: TextStyle(color: Colors.grey)),
                          Text('Blambangan, Krebet.', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                    child: MyContainer(
                      padding: EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Thread Starter', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5.0,),
                          Text('Bagus Muhaiminul Azis.', style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 5.0,),
                          Row(
                            children: <Widget>[
                              Text('Tanggal posting : '),
                              Text('2020-05-05', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,)
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Colors.grey.shade300,
                  style: BorderStyle.solid
                )
              )
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange.shade400
                    ),
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PesanUser())),
                    child: Text('Chat',style: TextStyle(color: Colors.white))
                  )
                ),
                SizedBox(width: 10.0,),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange.shade400
                    ),
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RescueProcessPage())),
                    child: Text('Rescue!', style: TextStyle(color: Colors.white))
                  )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}