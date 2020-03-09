import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/Pages/Dokter/DokterDetail.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';

class DokterPage extends StatefulWidget {
  @override
  _DokterPageState createState() => _DokterPageState();
}

class _DokterPageState extends State<DokterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.orange[400],
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(LineIcons.arrow_left, color: Colors.white,),
                          onPressed: () => Navigator.pop(context),
                          splashColor: Colors.black26,
                          focusColor: Colors.black38,
                          highlightColor: Colors.black12,
                        ),
                        Text('Kembali', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Text((isData ? data.length.toString() : 'Tidak ada') + ' unggahan', style: TextStyle(color: Colors.white),),
                        Text('5 Dokter', style: TextStyle(color: Colors.white),),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5.0),
                              onTap: (){},
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(LineIcons.filter, size: 15.0,),
                                    Text(' Filter', style: TextStyle(fontSize: 15.0),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.orange[300],
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
                ),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                      child: MyContainer(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Material(
                          color: Colors.transparent,
                          child: ListTile(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DokterDetailPage())),
                            leading: CircleAvatar(
                              radius: 20.0,
                              backgroundImage: NetworkImage('https://tecnobella.com/wp-content/uploads/2018/11/our-team-04.jpg'),
                            ),
                            title: Text('Megumi Kobayashi', style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('[Deskripsi] Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', style: TextStyle(color: Colors.grey)),
                                SizedBox(height: 10.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(LineIcons.map_marker, size: 15.0,),
                                    Text('Malang'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}