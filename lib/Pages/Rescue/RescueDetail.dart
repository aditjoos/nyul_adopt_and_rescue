import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nyul_adopt_rescue/Pages/Pesan/PesanUser.dart';
import 'package:nyul_adopt_rescue/Pages/Rescue/RescueEdit.dart';
import 'package:nyul_adopt_rescue/Pages/Rescue/RescueProcess.dart';
import 'package:nyul_adopt_rescue/components/ContainerAndButtons.dart';
import 'package:nyul_adopt_rescue/components/Dialogs.dart';
import 'package:nyul_adopt_rescue/helper/apiHelper_nyul.dart';

class RescueDetailPage extends StatefulWidget {
  RescueDetailPage({
    required this.idPostRescue
  });

  final String idPostRescue;

  @override
  _RescueDetailPageState createState() => _RescueDetailPageState();
}

class _RescueDetailPageState extends State<RescueDetailPage> {

  late var data;
  bool isLoadingData = true;

  _getDetailRescue() {
    Map<String, dynamic> parameters = {
      'kode_request_rescue' : widget.idPostRescue
    };

    APIHelperNyul().getData('nyul-codeigniter/index.php/rescue/Post_rescue_home_klik', parameters).then((value) {
      if(value['result']) {
        setState(() {
          isLoadingData = false;
          data = value['data'];
        });
      } else MyDialogs().simpleDialog(context, 'Kesalahan', value['message']);
    });
  }

  @override
  void initState() {
    super.initState();

    _getDetailRescue();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: isLoadingData ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(width: MediaQuery.of(context).size.width, child: Image.asset('assets/images/rescue_mika_brandt.png', fit: BoxFit.fill,)),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: SafeArea(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  IconButton(icon: Icon(LineIcons.arrowLeft, color: Colors.white), onPressed: () => Navigator.pop(context)),
                                  Text('Kembali', style: TextStyle(color: Colors.white),)
                                ],),
                                Row(children: <Widget>[
                                  IconButton(icon: Icon(LineIcons.pen, color: Colors.white), onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => EditRescuePage(idPostRescue: widget.idPostRescue,))).then((value) {
                                      _getDetailRescue();
                                    });
                                  }),
                                  IconButton(icon: Icon(LineIcons.trash, color: Colors.white), onPressed: () {
                                    APIHelperNyul().deleteData('nyul-codeigniter/index.php/rescue/Post_rescue_home_klik/${widget.idPostRescue}').then((value) {
                                      Navigator.pop(context);
                                    });
                                  }),
                                ],),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                    child: MyContainer(
                      padding: EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(data[0]['judul'], style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5.0,),
                          Text('Deskripsi'),
                          Text(data[0]['deskripsi'], style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 5.0,),
                          Text('Alamat'),
                          Text(data[0]['lokasi_map'], style: TextStyle(color: Colors.grey)),
                          Text(data[0]['alamat_detail'], style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                    child: MyContainer(
                      padding: EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Thread Starter', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5.0,),
                          Text('Mohamad Rizky.', style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 5.0,),
                          Row(
                            children: <Widget>[
                              Text('Tanggal posting : '),
                              Text(data[0]['tanggal_posting'], style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,)
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Colors.grey.shade300,
                  style: BorderStyle.solid
                )
              )
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange.shade400
                    ),
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PesanUser())),
                    child: Text('Chat',style: TextStyle(color: Colors.white))
                  )
                ),
                SizedBox(width: 10.0,),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange.shade400
                    ),
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RescueProcessPage())),
                    child: Text('Rescue!', style: TextStyle(color: Colors.white))
                  )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}