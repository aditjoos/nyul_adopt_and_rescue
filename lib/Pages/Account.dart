import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/Pages/AccountTambah.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.orange[400],
          child: Column(
            children: <Widget>[
              SafeArea(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Search Bar
                    Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Akun', style: TextStyle(color: Colors.white),),
                    ),

                    //Actions Bar
                    Row(
                      children: <Widget>[
                        Icon(LineIcons.heart, color: Colors.white,),
                        SizedBox(width: 10.0,),
                        Icon(LineIcons.bell, color: Colors.white,),
                        SizedBox(width: 10.0,),
                      ],
                    )
                  ],
                ),
              ),
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    child: Text('Akun Personal'),
                  ),
                  Tab(
                    child: Text('Tambah Akun'),
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 15.0,),
                        Text('Data diri', style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 15.0,),
                        MyContainer(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage:
                                        NetworkImage('https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/66/66adceda7ade28d229597b106eda2735d15f8c27_full.jpg'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  SizedBox(width: 10.0,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Bella Negara'),
                                      Row(
                                        children: <Widget>[
                                          Text('Verified Account', style: TextStyle(color: Colors.grey),),
                                          Icon(LineIcons.check_circle_o, color: Colors.blue,),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10.0,),
                              Text('bella.negara@email.com', style: TextStyle(color: Colors.grey),),
                              Text('081009xxxxxx', style: TextStyle(color: Colors.grey),),
                              Text('Jl. Teluk Buntu 001', style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        Text('Keamanan', style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 15.0,),
                        MyContainer(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            children: <Widget>[
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: (){},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(LineIcons.key),
                                        Text(' Ganti kata sandi')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: (){},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(LineIcons.plus_square),
                                        Text(' Tambah PIN')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: (){},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(LineIcons.check),
                                        Text(' Verifikasi data')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          width: double.infinity,
                        ),
                        SizedBox(height: 120.0,),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(LineIcons.user_plus, size: 55.0, color: Colors.blue),
                      SizedBox(height: 10.0,),
                      Text('Mulai atur aktivitasmu!', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0),),
                      SizedBox(height: 10.0,),
                      Text('nyuL memiliki 6 tipe akun dengan fitur \nyang berbeda-beda.', textAlign: TextAlign.center,),
                      SizedBox(height: 20.0,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.orange[400]
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AccountTambahPage())),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Center(
                                child: Text('Tambah Akun', style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 120.0,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}