import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/Pages/Dokter/DokterDetail.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';

class DokterPage extends StatefulWidget {
  @override
  _DokterPageState createState() => _DokterPageState();
}

class _DokterPageState extends State<DokterPage> {

  List data;
  bool isLoadingData = true;
  bool isData = false;

  Future getListDokter() async {
    final String url = 'http://nyul.kumpulan-soal.com/index.php/member/?tipe=3';
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
        getListDokter();
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
                  Center(child: Text('Dokter Hewan', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Text((isData ? data.length.toString() : 'Tidak ada') + ' unggahan', style: TextStyle(color: Colors.white),),
                        Text(data != null ? data.length.toString() + ' Dokter' : (0).toString() + ' Dokter', style: TextStyle(color: Colors.white),),
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
                child: isLoadingData ? Center(child: CircularProgressIndicator(),) : isData ?  ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index){
                    return DokterContainer(
                      foto: 'https://tecnobella.com/wp-content/uploads/2018/11/our-team-04.jpg',
                      nama: data[index]['nama'],
                      email: data[index]['email'],
                      kab: data[index]['alamat'],
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

class DokterContainer extends StatelessWidget {
  DokterContainer({this.foto, this.nama, this.email, this.kab});

  final String foto;
  final String nama;
  final String email;
  final String kab;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              backgroundImage: NetworkImage(foto),
            ),
            title: Text(nama, style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(email, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(LineIcons.map_marker, size: 15.0,),
                    Text(kab),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}