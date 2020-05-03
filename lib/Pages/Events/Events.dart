import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/Pages/Events/EventDetail.dart';
import 'package:petz_invention_udayana/Pages/Events/PostEvent.dart';
import 'package:petz_invention_udayana/Pages/Pesan/PesanUser.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';
import 'package:petz_invention_udayana/components/WidgetBuilder.dart';
import 'package:http/http.dart' as http;

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with SingleTickerProviderStateMixin {

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

  void checkConnectionThenExecuteLoadDataFunction() async {
    try {
      final result = await InternetAddress.lookup('nyul.kumpulan-soal.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        getFeedMeData();
      }
    } on SocketException catch (_) {
      showDialog(barrierDismissible: true, context: context, builder: (_) => FunkyOverlay('Sepertinya kamu tidak ada koneksi internet, periksa dulu ya.. \n(´。＿。｀)', [FlatButton(onPressed: () => Navigator.pop(context), child: Text('OK'))]));
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnectionThenExecuteLoadDataFunction();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                        Text('Kembali', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                  Center(child: Text('Feeding', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text((isData ? data.length.toString() : 'Tidak ada') + ' unggahan', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15.0,),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: isLoadingData ? Center(
                  child: CircularProgressIndicator(),
                ) : isData ? ColumnBuilder(
                  itemCount: data == null ? 0 : data.length + 1,
                  itemBuilder: (BuildContext context, int index){
                    return index != data.length ? Padding(
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
                                  FlatButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PesanUser())), child: Text('Chat')),
                                  FlatButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => EventDetailPage())), child: Text('Lihat')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ) : SizedBox(height: 80.0,);
                  },
                ) : Center(child: Text('Tidak ada data'),),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PostEventPage())),
        child: Icon(LineIcons.plus, color: Colors.white,),
      ),
    );
  }
}