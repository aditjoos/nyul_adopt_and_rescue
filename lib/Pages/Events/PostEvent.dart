import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';

class PostEventPage extends StatefulWidget {
  @override
  _PostEventPageState createState() => _PostEventPageState();
}

class _PostEventPageState extends State<PostEventPage> {

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    super.initState();
  }

  int jumlahAnggota = 1;
  int jumlahAnggotaFix = 0;
  bool isJumlahAnggotaMenuOpened = false;
  bool isJamMenuOpened = false;

  void ubahJumlahAnggota(bool isIncrease) {
    if (isIncrease) {
      if (jumlahAnggota != 20) setState(() {
        jumlahAnggota = jumlahAnggota + 1;
      });
    } else {
      if (jumlahAnggota != 1) setState(() {
        jumlahAnggota = jumlahAnggota - 1;
      });
    }
  }

  int jam = 0;
  String menit = '00';
  String jamFix = '0:00';

  void ubahJam(bool isIncrease) {
    if (isIncrease) {
      if (jam != 24) setState(() {
        jam = jam + 1;
      });
    } else {
      if (jam != 0) setState(() {
        jam = jam - 1;
      });
    }
  }

  void ubahMenit() {
    setState(() {
      if (menit == '00') {
        menit = '30';
      } else {
        menit = '00';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Row(
                      children: <Widget>[
                        IconButton(icon: Icon(LineIcons.close), onPressed: () => showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => FunkyDialog(
                            Center(
                              child: Padding(padding: EdgeInsets.only(top: 15.0), child: Text('Yakin batal?'),),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FlatButton(onPressed: () => Navigator.pop(context), child: Text('Tidak')),
                                  FlatButton(onPressed: (){
                                    for (var i = 0; i < 2; i++) {
                                      Navigator.pop(context);
                                    }
                                  }, child: Text('Ya')),
                                ],
                              ),
                            ),
                            MainAxisSize.min
                          )
                        )),
                        Text('Batal')
                      ],
                    ),
                  ),
                  Center(child: Text('Tambah Posting Feeding', style: TextStyle(fontSize: 20.0),),),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: MyContainer(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Judul', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8.0,),
                            TextField(
                              // controller: controllerUsername,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                hintText: "Judul postingan",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                              ),
                            ),
                            SizedBox(height: 8.0,),
                            Text('Deskripsi', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8.0,),
                            Text('Tulis deskripsi mengenai postingan ini atau kondisi.', style: TextStyle(color: Colors.grey)),
                            SizedBox(height: 8.0,),
                            TextField(
                              // controller: controllerUsername,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                hintText: "Deskripsi postingan",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: MyContainer(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Lokasi', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                            Row(
                              children: <Widget>[
                                // Auto Wrap
                                Expanded(child: Text('Jl. blabla blabla 666', style: TextStyle(color: Colors.grey))),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15.0),
                                    onTap: (){},
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Row(
                                        children: <Widget>[
                                          Text('ubah'),
                                          Icon(LineIcons.map)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextField(
                              // controller: controllerUsername,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                hintText: "Informasi lokasi tambahan",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: MyContainer(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Anggota', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8.0,),
                            Text('Tentukan banyaknya anggota yang dapat hadir pada kegiatan ini. Sesuaikan dengan kondisi di lapangan. Maksimal 20 anggota.', style: TextStyle(color: Colors.grey)),
                            SizedBox(height: 8.0,),
                            Row(
                              children: <Widget>[
                                // Auto Wrap
                                Expanded(child: Text(jumlahAnggotaFix == 0 ? 'Tentukan jumlah' : jumlahAnggotaFix.toString()+' Anggota', style: TextStyle(color: Colors.grey))),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15.0),
                                    onTap: () => setState(() => isJumlahAnggotaMenuOpened = true),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text('ubah'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0,),
                            Text('Tanggal', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                            Row(
                              children: <Widget>[
                                // Auto Wrap
                                Expanded(child: Text("${selectedDate.toLocal()}".split(' ')[0], style: TextStyle(color: Colors.grey))),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15.0),
                                    onTap: () => _selectDate(context),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text('ubah'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0,),
                            Text('Jam', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                            Row(
                              children: <Widget>[
                                // Auto Wrap
                                Expanded(child: Text(jamFix, style: TextStyle(color: Colors.grey))),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15.0),
                                    onTap: () => setState(() => isJamMenuOpened = true),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text('ubah'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.orange[400]
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: (){},
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Selesai', style: TextStyle(color: Colors.white),),
                                Icon(LineIcons.check, color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          isJumlahAnggotaMenuOpened ? Positioned.fill(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onVerticalDragDown: (update) => setState(() => isJumlahAnggotaMenuOpened = false),
                    onTap: () => setState(() => isJumlahAnggotaMenuOpened = false),
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                        Text('Batal'),
                        Material(color: Colors.transparent, child: InkWell(
                          onTap: () => setState(() => isJumlahAnggotaMenuOpened = false),
                          borderRadius: BorderRadius.circular(25.0),
                          child: Padding(padding: EdgeInsets.all(5.0), child: Icon(LineIcons.close),),
                        ),),
                      ],),
                      IconButton(icon: Icon(LineIcons.caret_up), onPressed: () => ubahJumlahAnggota(true)),
                      Text(jumlahAnggota.toString()),
                      IconButton(icon: Icon(LineIcons.caret_down), onPressed: () => ubahJumlahAnggota(false)),
                      SizedBox(height: 10.0,),
                      FlatButton(onPressed: () => setState(() {
                        jumlahAnggotaFix = jumlahAnggota;
                        isJumlahAnggotaMenuOpened = false;
                      }), child: Text('Selesai'))
                    ],
                  ),
                )
              ],
            ),
          ) : isJamMenuOpened ? Positioned.fill(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onVerticalDragDown: (update) => setState(() => isJamMenuOpened = false),
                    onTap: () => setState(() => isJamMenuOpened = false),
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                        Text('Batal'),
                        Material(color: Colors.transparent, child: InkWell(
                          onTap: () => setState(() => isJamMenuOpened = false),
                          borderRadius: BorderRadius.circular(25.0),
                          child: Padding(padding: EdgeInsets.all(5.0), child: Icon(LineIcons.close),),
                        ),),
                      ],),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              IconButton(icon: Icon(LineIcons.caret_up), onPressed: () => ubahJam(true)),
                              Text(jam.toString()),
                              IconButton(icon: Icon(LineIcons.caret_down), onPressed: () => ubahJam(false)),
                            ],
                          ),
                          Text(':'),
                          Column(
                            children: <Widget>[
                              IconButton(icon: Icon(LineIcons.caret_up), onPressed: () => ubahMenit()),
                              Text(menit),
                              IconButton(icon: Icon(LineIcons.caret_down), onPressed: () => ubahMenit()),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0,),
                      FlatButton(onPressed: () => setState(() {
                        jamFix = jam.toString()+':'+menit;
                        isJamMenuOpened = false;
                      }), child: Text('Selesai'))
                    ],
                  ),
                )
              ],
            ),
          ) : Container(),
        ],
      ),
    );
  }
}