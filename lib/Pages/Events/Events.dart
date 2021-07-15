import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nyul_adopt_rescue/Pages/Events/EventDetail.dart';
import 'package:nyul_adopt_rescue/Pages/Events/PostEvent.dart';
import 'package:nyul_adopt_rescue/Pages/Pesan/PesanUser.dart';
import 'package:nyul_adopt_rescue/components/ContainerAndButtons.dart';
import 'package:nyul_adopt_rescue/components/Dialogs.dart';
import 'package:nyul_adopt_rescue/components/WidgetBuilder.dart';
import 'package:nyul_adopt_rescue/helper/apiHelper.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with SingleTickerProviderStateMixin {

  late List data;
  bool isLoadingData = true;
  bool isData = false;

  // Future getFeedMeData() async {
  //   final String url = 'http://nyul.kumpulan-soal.com/index.php/feedme/Post_feedme';
  //   var result = await http.get(Uri.encodeFull(url), headers: { 'accept':'application/json' });

  //   setState(() {
  //     if(result.statusCode == 200){
  //       var content = json.decode(result.body);
  //       if(content['result'] = true){
  //         data = content['data'];
  //         isData = true;
  //       }
  //     }
  //     isLoadingData = false;
  //   });
  // }

  _checkConnectionThenExecute() async {
    try {
      final result = await InternetAddress.lookup(APIHelper().baseUrl);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) _getData();
    } on SocketException catch (_) {
      MyDialogs().simpleDialog(context, 'Tidak ada Koneksi', 'Sepertinya kamu tidak ada koneksi internet, periksa dulu ya.. \n(´。＿。｀)');
    }
  }

  _getData() {
    APIHelper().getData('index.php/feedme/Post_feedme').then((value) {
      if(value['result']) {
        setState(() {
          data = value['data'];
          isData = true;
          isLoadingData = false;
        });
      } else MyDialogs().simpleDialog(context, 'Kesalahan', '${value['data']} | ${value['message']}');
    });
  }

  @override
  void initState() {
    super.initState();
    _checkConnectionThenExecute();
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
                  textDirection: TextDirection.ltr,
                  itemCount: data.isEmpty ? 0 : data.length + 1,
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
                                      Icon(LineIcons.mapSigns),
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
                                      Icon(LineIcons.clock),
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
                                  TextButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PesanUser())), child: Text('Chat')),
                                  TextButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => EventDetailPage())), child: Text('Lihat')),
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