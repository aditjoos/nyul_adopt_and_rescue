import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nyul_adopt_rescue/Pages/Rescue/RescueDetail.dart';
import 'package:nyul_adopt_rescue/components/ContainerAndButtons.dart';
import 'package:nyul_adopt_rescue/components/Dialogs.dart';
import 'package:nyul_adopt_rescue/helper/apiHelper_nyul.dart';

class RescuePage extends StatefulWidget {
  @override
  _RescuePageState createState() => _RescuePageState();
}

class _RescuePageState extends State<RescuePage> {

  late List _data;
  bool _isLoadingData = true;
  bool _isData = false;

  _getRescueData() {
    setState(() {
      _data = [];
      _isLoadingData = true;
      _isData = false;
    });
    
    APIHelperNyul().getData('nyul-codeigniter/index.php/rescue/post_rescue').then((value) {
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

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) _getRescueData();
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

  bool filterOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Column(
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
                        Center(child: Text('Rescue', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text((_isData ? _data.length.toString() : 'Tidak ada') + ' unggahan', style: TextStyle(color: Colors.white),),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(5.0),
                                    onTap: () => setState(() => filterOpened = true),
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
                      child: _isLoadingData ? Center(child: CircularProgressIndicator(),) : _isData ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _data.isEmpty ? 0 : _data.length,
                        itemBuilder: (BuildContext contex, int index){
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                            child: MyContainer(
                              width: double.infinity,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10.0),
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RescueDetailPage(idPostRescue: _data[index]['kode_request_rescue'],))).then((value) {
                                    _getRescueData();
                                  }),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 100.0,
                                        height: 100.0,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Image.asset('assets/images/rescue_mika_brandt.png', fit: BoxFit.fill,)
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  color: _data[index]['urgensi'] == "1" ? Colors.red : _data[index]['urgensi'] == "2" ? Colors.yellow[700] : _data[index]['urgensi'] == "3" ? Colors.green : Colors.black,
                                                ),
                                                child: Text(_data[index]['urgensi'] == "1" ? 'Darurat' : _data[index]['urgensi'] == "2" ? 'Sedang' : _data[index]['urgensi'] == "3" ? 'Rendah' : '-', style: TextStyle(color: Colors.white)),
                                              ),
                                              SizedBox(height: 10.0,),
                                              Text(_data[index]['judul']?? 'Test', style: TextStyle(fontWeight: FontWeight.bold),),
                                              SizedBox(height: 10.0,),
                                              Text(_data[index]['deskripsi']?? 'Test', style: TextStyle(color: Colors.grey),),
                                              SizedBox(height: 10.0,),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text(_data[index]['tanggal_posting']?? DateFormat('yyyy-MM-dd').format(DateTime.now())),
                                                  Text(_data[index]['alamat_detail']?? 'Test'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
          ),
          filterOpened ? Positioned.fill(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  color: Colors.white,
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        RescueFilterLevelButton(
                          color: Colors.green.shade300,
                          onTap: () => setState((){
                            filterOpened = false;
                          }),
                          text: 'Rendah',
                        ),
                        RescueFilterLevelButton(
                          color: Colors.orange.shade300,
                          onTap: () => setState((){
                            filterOpened = false;
                          }),
                          text: 'Sedang',
                        ),
                        RescueFilterLevelButton(
                          color: Colors.red.shade300,
                          onTap: () => setState((){
                            filterOpened = false;
                          }),
                          text: 'Urgent',
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('Tutup'),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => setState(() {
                                  filterOpened = false;
                                }),
                                borderRadius: BorderRadius.circular(25.0),
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(LineIcons.cross),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => filterOpened = false),
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ) : Container()
        ],
      ),
    );
  }
}

class RescueFilterLevelButton extends StatelessWidget {
  RescueFilterLevelButton({
    required this.onTap, 
    required this.color, 
    required this.text
  });

  final VoidCallback onTap;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color
        ),
        child: Material(color: Colors.transparent, child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: onTap, child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child: Center(child: Text(text, style: TextStyle(color: Colors.white),)),
          ),
        ),),
      ),
    );
  }
}