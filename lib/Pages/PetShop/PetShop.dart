import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/Pages/PetShop/PetShopDetail.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';

class PetShopPage extends StatefulWidget {
  @override
  _PetShopPageState createState() => _PetShopPageState();
}

class _PetShopPageState extends State<PetShopPage> {
  
  List data;
  bool isLoadingData = true;
  bool isData = false;

  Future getListDokter() async {
    final String url = 'http://nyul.kumpulan-soal.com/index.php/member/?tipe=4';
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
                        Text(data != null ? data.length.toString() + ' PetShop' : (0).toString() + ' PetShop', style: TextStyle(color: Colors.white),),
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
                    return PetShopContainer(
                      foto: 'https://images.template.net/wp-content/uploads/2017/03/23054017/Free-Business-Company-Logo3.jpg',
                      nama: data[index]['nama'],
                      alamat: data[index]['alamat'],
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

class PetShopContainer extends StatelessWidget {
  PetShopContainer({this.foto, this.nama, this.alamat});

  final String foto;
  final String nama;
  final String alamat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
      child: MyContainer(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PetShopDetailPage())),
            child: Row(
              children: <Widget>[
                Container(
                  width: 60.0,
                  height: 60.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(foto, fit: BoxFit.fill,)
                  ),
                ),
                SizedBox(width: 10.0,),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(nama, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(alamat, style: TextStyle(color: Colors.grey),),
                    // Text('Kota Malang', style: TextStyle(color: Colors.grey),),
                  ],
                )
              ],
            ),
          ),
        ),
        width: double.infinity,
      ),
    );
  }
}