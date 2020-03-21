import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/Pages/Adopsi/AdopsiDetail.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';

class AdopsiPage extends StatefulWidget {
  @override
  _AdopsiPageState createState() => _AdopsiPageState();
}

class _AdopsiPageState extends State<AdopsiPage> {
  
  List data;
  bool isLoadingData = true;
  bool isData = false;

  Future getAdopsiData() async {
    final String url = 'http://nyul.kumpulan-soal.com/index.php/post_adopt?fungsi=1';
    var result = await http.get(Uri.encodeFull(url), headers: { 'accept':'application/json' });

    setState(() {
      if(result.statusCode == 200){
        var content = json.decode(result.body);
        if(content['result'] = true){
          data = content['data'];
          isData = true;
        }else if(content['result'] = false){
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) => FunkyOverlay(
              content['data'],
              [
                FlatButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
              ]
            )
          );
        }
      }
      isLoadingData = false;
    });
  }

  void checkConnectionThenExecuteLoadDataFunction() async {
    try {
      final result = await InternetAddress.lookup('nyul.kumpulan-soal.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        getAdopsiData();
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
                        Text((isData ? (data.length-1).toString() : 'Tidak ada') + ' unggahan', style: TextStyle(color: Colors.white),),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black12,
                            //     offset: Offset(0.0, 2.0),
                            //     blurRadius: 10.0,
                            //     spreadRadius: 1.0
                            //   )
                            // ]
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
                child: isLoadingData ? Center(child: CircularProgressIndicator(),) : isData ? GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.660
                  ),
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext contex, int index){
                    return PostAdopsiCard(
                      imgSource: 'assets/images/real-cat.jpg',
                      judul: data[index]['judul'],
                      jenis: 1,
                      ras: '-',
                      umur: data[index]['umur'],
                      alamat: data[index]['alamat'],
                      metodeAdopsi: int.parse(data[index]['metode_adopsi']),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdopsiDetailPage())),
                    );
                  },
                ) : Center(child: Text('Tidak ada data.'),),
              ),
            ),
          ),
          // Positioned(
          //   child: Container(
          //     child: SingleChildScrollView(
          //       //
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}