import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';

class AdopsiDetailPage extends StatefulWidget {
  @override
  _AdopsiDetailPageState createState() => _AdopsiDetailPageState();
}

class _AdopsiDetailPageState extends State<AdopsiDetailPage> {

  int _currentSlide = 0;
  List imgList = [
    'assets/images/cat-feedpage.png',
    'assets/images/cat-feedpage.png',
    'assets/images/cat-feedpage.png',
    'assets/images/cat-feedpage.png',
    'assets/images/cat-feedpage.png',
  ];

  //Image Indicator
  List<T> map<T>(List list, Function handler){
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  bool isFavorite = false;

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
                          child: CarouselSlider(
                            height: MediaQuery.of(context).size.width,
                            viewportFraction: 1.0,
                            aspectRatio: MediaQuery.of(context).size.aspectRatio,
                            initialPage: _currentSlide,
                            reverse: false,
                            enableInfiniteScroll: false,
                            onPageChanged: (index){
                              setState(() {
                                _currentSlide = index;
                              });
                            },
                            items: imgList.map((imgUrl){
                              return Container(width: MediaQuery.of(context).size.width, child: Image.asset(imgUrl, fit: BoxFit.fill,));
                            }).toList(),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: SafeArea(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  IconButton(icon: Icon(LineIcons.arrow_left, color: Colors.white), onPressed: () => Navigator.pop(context)),
                                  Text('Kembali', style: TextStyle(color: Colors.white),)
                                ],),
                                Row(
                                  children: map<Widget>(imgList, (index, url){
                                    return Container(
                                      width: 5.0,
                                      height: 5.0,
                                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentSlide == index ? Colors.white : Colors.white38
                                      ),
                                    );
                                  }),
                                ),
                                Row(children: <Widget>[
                                  IconButton(icon: Icon(LineIcons.share, color: Colors.white), onPressed: (){}),
                                  IconButton(icon: Icon(LineIcons.dot_circle_o, color: Colors.white), onPressed: (){}),
                                ],),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Lenna Ming', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(FontAwesomeIcons.cat, color: Colors.white, size: 10.0),
                                        SizedBox(width: 3.0),
                                        Text('Persia', style: TextStyle(color: Colors.white),),
                                      ],
                                    ),
                                  ],
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20.0),
                                    onTap: (){
                                      if (isFavorite) {
                                        setState(() {
                                          isFavorite = false;
                                        });
                                      }else{
                                        setState(() {
                                          isFavorite = true;
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: Colors.white24,
                                      ),
                                      padding: EdgeInsets.all(5.0),
                                      child: Row(
                                        children: <Widget>[
                                          Text(' Favorit ', style: TextStyle(color: Colors.white),),
                                          Icon(isFavorite ? LineIcons.heart : LineIcons.heart_o, color: isFavorite ? Colors.orange : Colors.white),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
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
                          Text('Identitas pemilik', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5.0,),
                          Row(children: <Widget>[
                            Icon(LineIcons.user, color: Colors.grey, size: 15,),
                            Text('Mohamad Rizky Reynaldy', style: TextStyle(color: Colors.grey)),
                          ]),
                          Row(children: <Widget>[
                            Icon(LineIcons.map_marker, color: Colors.grey, size: 15,),
                            Text('Malang kota', style: TextStyle(color: Colors.grey)),
                          ]),
                          SizedBox(height: 5.0,),
                          Text('Alamat lengkap'),
                          Text('Jl. Teluk Kartini No. 666, Arjosari', style: TextStyle(color: Colors.grey)),
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
                          Text('Detail hewan', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5.0,),
                          Row(
                            children: <Widget>[
                              Text('Metode adopsi : '),
                              Container(
                                padding: EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.orange[400],
                                    style: BorderStyle.solid,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0)
                                ),
                                child: Text('Paid', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),)
                              ), 
                            ],
                          ),
                          SizedBox(height: 5.0,),
                          Text('Deskripsi'),
                          Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 5.0,),
                          Text('Umur'),
                          Text('10 bulan', style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 5.0,),
                          Text('Jenis kelamin'),
                          Text('Jantan', style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 5.0,),
                          Text('Vaksin'),
                          Text('Ya', style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 5.0,),
                          Text('Steril'),
                          Text('Ya', style: TextStyle(color: Colors.grey)),
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
                  color: Colors.grey[350],
                  style: BorderStyle.solid
                )
              )
            ),
            child: Row(
              children: <Widget>[
                Expanded(child: FlatButton(color: Colors.orange[400], onPressed: (){}, child: Text('Chat Pemilik', style: TextStyle(color: Colors.white)))),
                SizedBox(width: 10.0,),
                Expanded(child: FlatButton(color: Colors.orange[400], onPressed: (){}, child: Text('Adopsi Sekarang', style: TextStyle(color: Colors.white)))),
              ],
            ),
          )
        ],
      ),
    );
  }
}