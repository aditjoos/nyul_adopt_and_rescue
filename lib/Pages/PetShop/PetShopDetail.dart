import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nyul_adopt_rescue/Pages/Pesan/PesanUser.dart';
import 'package:nyul_adopt_rescue/components/ContainerAndButtons.dart';

class PetShopDetailPage extends StatefulWidget {
  @override
  _PetShopDetailPageState createState() => _PetShopDetailPageState();
}

class _PetShopDetailPageState extends State<PetShopDetailPage> {
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
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Search Bar
                        Container(
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(LineIcons.arrowLeft, color: Colors.white,),
                                onPressed: () => Navigator.pop(context),
                                splashColor: Colors.black26,
                                focusColor: Colors.black38,
                                highlightColor: Colors.black12,
                              ),
                              Text('Kembali', style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),

                        //Actions Bar
                        Row(
                          children: <Widget>[
                            Icon(LineIcons.share, color: Colors.white,),
                            SizedBox(width: 10.0,),
                            Icon(LineIcons.verticalEllipsis, color: Colors.white,),
                            SizedBox(width: 10.0,),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          height: 100.0,
                          child: Hero(
                            tag: 'petshop_image',
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundImage: NetworkImage('https://images.template.net/wp-content/uploads/2017/03/23054017/Free-Business-Company-Logo3.jpg'),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Pet Abadi Jaya', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(LineIcons.mapMarker, size: 15.0, color: Colors.white,),
                                Text(' Malang', style: TextStyle(color: Colors.white),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(LineIcons.check, size: 15.0, color: Colors.white,),
                                Text(' Terpercaya', style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          color: Colors.white,
                          textColor: Colors.black87,
                          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PesanUser())),
                          child: Text('Chat')
                        ),
                        SizedBox(width: 25.0,),
                        FlatButton(
                          color: Colors.white,
                          textColor: Colors.black87,
                          onPressed: (){},
                          child: Text('Map')
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyContainer(
                        padding: EdgeInsets.all(10.0),
                        child: Center(child: Text('Makanan')),
                        width: MediaQuery.of(context).size.width / 3 - 20.0,
                        height: 50.0,
                      ),
                      MyContainer(
                        padding: EdgeInsets.all(10.0),
                        child: Center(child: Text('Peralatan')),
                        width: MediaQuery.of(context).size.width / 3 - 20.0,
                        height: 50.0,
                      ),
                      MyContainer(
                        padding: EdgeInsets.all(10.0),
                        child: Center(child: Text('Kesehatan')),
                        width: MediaQuery.of(context).size.width / 3 - 20.0,
                        height: 50.0,
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyContainer(
                        padding: EdgeInsets.all(10.0),
                        child: Center(child: Text('Penitipan')),
                        width: MediaQuery.of(context).size.width / 3 - 20.0,
                        height: 50.0,
                      ),
                      MyContainer(
                        padding: EdgeInsets.all(10.0),
                        child: Center(child: Text('Grooming')),
                        width: MediaQuery.of(context).size.width / 3 - 20.0,
                        height: 50.0,
                      ),
                      MyContainer(
                        padding: EdgeInsets.all(10.0),
                        child: Center(child: Text('PetCare')),
                        width: MediaQuery.of(context).size.width / 3 - 20.0,
                        height: 50.0,
                      ),
                    ],
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