import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nyul_adopt_rescue/Pages/Adopsi/AdopsiDetail.dart';
import 'package:nyul_adopt_rescue/components/ContainerAndButtons.dart';
import 'package:nyul_adopt_rescue/components/Dialogs.dart';
import 'package:nyul_adopt_rescue/helper/apiHelper_nyul.dart';

class AdopsiPage extends StatefulWidget {
  @override
  _AdopsiPageState createState() => _AdopsiPageState();
}

class _AdopsiPageState extends State<AdopsiPage> {
  
  late List _data;
  bool _isLoadingData = true;
  bool _isData = false;
  
  _getAdopsiData() {
    Map<String, dynamic> parameters = {
      'fungsi' : '1'
    };
    APIHelperNyul().getData('nyul-codeigniter/index.php/adopsi/post_adopt', parameters).then((value) {
      if(value['result']) {
        setState(() {
          _data = value['data'];
          _isLoadingData = false;
          _isData = true;
        });
      } else {
        setState(() {
          _isLoadingData = false;
          _isData = false;
        });

        MyDialogs().simpleDialog(context, 'Kesalahan', '${value['message']}');
      }
    });
  }

  _checkConnectionThenExecuteLoadDataFunction() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) _getAdopsiData();
      else MyDialogs().simpleDialog(context, 'Kesalahan', 'Ada kesalahan koneksi internet.');
    } on SocketException catch (_) {
      MyDialogs().simpleDialog(context, 'Kesalahan', 'Kamu tidak ada koneksi internet.');
    }
  }

  @override
  void initState() {
    super.initState();

    _checkConnectionThenExecuteLoadDataFunction();
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
                        Text((_isData ? (_data.length-1).toString() : 'Tidak ada') + ' unggahan', style: TextStyle(color: Colors.white),),
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
                child: _isLoadingData ? Center(child: CircularProgressIndicator(),) : _isData ? GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.660
                  ),
                  itemCount: _data.isEmpty ? 0 : _data.length,
                  itemBuilder: (BuildContext contex, int index){
                    return PostAdopsiCard(
                      imgSource: 'assets/images/real-cat.jpg',
                      judul: _data[index]['judul'],
                      jenis: 1,
                      ras: '-',
                      umur: _data[index]['umur']?? '-',
                      alamat: _data[index]['alamat']?? '-',
                      metodeAdopsi: int.parse(_data[index]['metode_adopsi']?? '1'),
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