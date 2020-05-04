import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
import 'package:petz_invention_udayana/Pages/Rescue/RescueDetail.dart';
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
        // Lakukan getRescueData ketika ada internet
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
                        Center(child: Text('Rescue', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),),
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
                      child: isLoadingData ? Center(child: CircularProgressIndicator(),) : isData ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: data == null ? 0 : data.length,
                        itemBuilder: (BuildContext contex, int index){
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                            child: MyContainer(
                              width: double.infinity,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10.0),
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RescueDetailPage())), // TODO
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 100.0,
                                        height: 100.0,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Image.asset('assets/images/real-cat.jpg', fit: BoxFit.fill,)
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
                                                  color: data[index]['urgensi'] == "1" ? Colors.red : data[index]['urgensi'] == "2" ? Colors.yellow[700] : data[index]['urgensi'] == "3" ? Colors.green : Colors.black,
                                                ),
                                                child: Text(data[index]['urgensi'] == "1" ? 'Darurat' : data[index]['urgensi'] == "2" ? 'Sedang' : data[index]['urgensi'] == "3" ? 'Rendah' : '-', style: TextStyle(color: Colors.white)),
                                              ),
                                              SizedBox(height: 10.0,),
                                              Text(data[index]['judul'], style: TextStyle(fontWeight: FontWeight.bold),),
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
                          color: Colors.green[300],
                          onTap: () => setState((){
                            filterOpened = false;
                          }),
                          text: 'Rendah',
                        ),
                        RescueFilterLevelButton(
                          color: Colors.orange[300],
                          onTap: () => setState((){
                            filterOpened = false;
                          }),
                          text: 'Sedang',
                        ),
                        RescueFilterLevelButton(
                          color: Colors.red[300],
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
                                  child: Icon(LineIcons.close),
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
  RescueFilterLevelButton({this.onTap, this.color, this.text});

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