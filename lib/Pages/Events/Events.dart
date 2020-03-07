import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/WidgetBuilder.dart';
import 'package:http/http.dart' as http;

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with SingleTickerProviderStateMixin {

  TabController _tabController;

  List data;
  bool isLoadingData = true;
  bool isData = false;

  Future getFeedMeData() async {
    final String url = 'http://nyul.kumpulan-soal.com/index.php/Post_feedme';
    var result = await http.get(Uri.encodeFull(url), headers: { 'accept':'application/json' });

    setState(() {
      if(result.statusCode == 200){
        var content = json.decode(result.body);
        if(content['result'] = true){
          data = content['data'];
          isData = true;
        }
      }
      isLoadingData = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getFeedMeData();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.orange[400],
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: Row(
                    children: <Widget>[
                      IconButton(icon: Icon(LineIcons.arrow_left), onPressed: () => Navigator.pop(context)),
                      Text('Kembali')
                    ],
                  ),
                ),
                Center(child: Text('Events', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),),
                SizedBox(height: 10.0,),
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  tabs: <Widget>[
                    Tab(
                      child: Text('Feed Me'),
                    ),
                    Tab(
                      child: Text('Events'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0,),
          Expanded(
            child: Container(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                controller: _tabController,
                children: <Widget>[
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: isLoadingData ? Center(
                      child: CircularProgressIndicator(),
                    ) : isData ? ColumnBuilder(
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (BuildContext context, int index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: MyContainer(
                            width: MediaQuery.of(context).size.width - 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(data[index]['judul'], style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      Text(data[index]['deskripsi'], style: TextStyle(color: Colors.grey),),
                                      Row(
                                        children: <Widget>[
                                          Icon(LineIcons.map_signs),
                                          Text(data[index]['alamat'], style: TextStyle(color: Colors.grey),),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(LineIcons.calendar),
                                          Text(data[index]['tanggal'], style: TextStyle(color: Colors.grey),),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(LineIcons.clock_o),
                                          Text(data[index]['jam'], style: TextStyle(color: Colors.grey),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 5.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      FlatButton(onPressed: (){}, child: Text('Chat')),
                                      FlatButton(onPressed: (){}, child: Text('Join')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ) : Center(child: Text('Tidak ada data'),),
                  ),
                  Container(
                    child: Center(
                      child: Icon(LineIcons.automobile),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(LineIcons.plus, color: Colors.white,),
      ),
    );
  }
}