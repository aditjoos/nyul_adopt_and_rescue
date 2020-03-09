import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';

class RescuePage extends StatefulWidget {
  @override
  _RescuePageState createState() => _RescuePageState();
}

class _RescuePageState extends State<RescuePage> {

  List data;
  bool isLoadingData = true;
  bool isData = false;

  Future getRescueData() async {
    final String url = 'http://nyul.kumpulan-soal.com/index.php/Post_rescue';
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
        getRescueData();
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
                        Text('Kembali', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text((isData ? data.length.toString() : 'Tidak ada') + ' unggahan', style: TextStyle(color: Colors.white),),
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
                child: isLoadingData ? Center(child: CircularProgressIndicator(),) : isData ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data == null ? 0 : data.length-1,
                  itemBuilder: (BuildContext contex, int index){
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                      child: MyContainer(
                        padding: EdgeInsets.all(20.0),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: data[index]['urgensi'] == "1" ? Colors.red : data[index]['urgensi'] == "2" ? Colors.yellow[700] : data[index]['urgensi'] == "3" ? Colors.green : Colors.black,
                                  ),
                                  child: Text(data[index]['urgensi'] == "1" ? 'Darurat' : data[index]['urgensi'] == "2" ? 'Sedang' : data[index]['urgensi'] == "3" ? 'Rendah' : '-', style: TextStyle(color: Colors.white)),
                                ),
                                Text(' '+data[index]['judul'], style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Text(data[index]['deskripsi'], style: TextStyle(color: Colors.grey),),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(data[index]['tanggal_posting']),
                                Text(data[index]['alamat_detail']),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ) : Center(child: Text('Tidak ada data.'),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}