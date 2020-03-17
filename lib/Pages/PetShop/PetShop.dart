import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';

class PetShopPage extends StatefulWidget {
  @override
  _PetShopPageState createState() => _PetShopPageState();
}

class _PetShopPageState extends State<PetShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.orange[300],
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
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              // width: MediaQuery.of(context).size.width - 100,
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
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('5 PetShop didekatmu', style: TextStyle(color: Colors.white),),
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
                  padding: EdgeInsets.all(10.0),
                  children: <Widget>[
                    MyContainer(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: (){},
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 60.0,
                                height: 60.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network('https://images.template.net/wp-content/uploads/2017/03/23054017/Free-Business-Company-Logo3.jpg', fit: BoxFit.fill,)
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Pet Abadi Jaya', style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text('Jl. Merdaka 45', style: TextStyle(color: Colors.grey),),
                                  Text('Kota Malang', style: TextStyle(color: Colors.grey),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      width: double.infinity,
                    ),
                    SizedBox(height: 10.0,),
                    MyContainer(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: (){},
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 60.0,
                                height: 60.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network('https://images.template.net/wp-content/uploads/2017/03/23054017/Free-Business-Company-Logo3.jpg', fit: BoxFit.fill,)
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Pet Abadi Jaya', style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text('Jl. Merdaka 45', style: TextStyle(color: Colors.grey),),
                                  Text('Kota Malang', style: TextStyle(color: Colors.grey),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      width: double.infinity,
                    ),
                    SizedBox(height: 10.0,),
                    MyContainer(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: (){},
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 60.0,
                                height: 60.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network('https://images.template.net/wp-content/uploads/2017/03/23054017/Free-Business-Company-Logo3.jpg', fit: BoxFit.fill,)
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Pet Abadi Jaya', style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text('Jl. Merdaka 45', style: TextStyle(color: Colors.grey),),
                                  Text('Kota Malang', style: TextStyle(color: Colors.grey),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      width: double.infinity,
                    ),
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