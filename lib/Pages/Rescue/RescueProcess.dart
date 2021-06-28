import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';

class RescueProcessPage extends StatefulWidget {
  @override
  _RescueProcessPageState createState() => _RescueProcessPageState();
}

class _RescueProcessPageState extends State<RescueProcessPage> {

  DateTime selectedDate = DateTime.now();

  late File _image;

  // Future getImage(bool chosenIsCamera) async {
  //   File image;
  //   if(chosenIsCamera) image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   else image = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _image = image;
  //   });
  // }

  int diselamatkanOleh = 0; // 0=init, 1=saya 2=orang lain

  bool isPilihProvinsi = false;
  bool isPilihKota = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    SafeArea(
                      child: Row(
                        children: <Widget>[
                          IconButton(icon: Icon(LineIcons.arrowLeft), onPressed: () => Navigator.pop(context)),
                          Text('Kembali')
                        ],
                      ),
                    ),
                    Center(child: Text('Konfirmasi Rescue', style: TextStyle(fontSize: 20.0),),),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: MyContainer(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Diselamatkan oleh?', style: TextStyle(fontSize: 18.0,)),
                              SizedBox(height: 8.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: diselamatkanOleh == 1 ? Colors.orange[400] : Colors.white,
                                        border: Border.all(
                                          color: Colors.orange,
                                          style: BorderStyle.solid,
                                          width: 0.5
                                        ),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0))
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => setState(() => diselamatkanOleh = 1),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                            child: Center(child: Text('Saya sendiri', style: TextStyle(color: diselamatkanOleh == 1 ? Colors.white : Colors.black),)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: diselamatkanOleh == 2 ? Colors.orange[400] : Colors.white,
                                        border: Border.all(
                                          color: Colors.orange,
                                          style: BorderStyle.solid,
                                          width: 0.5
                                        ),
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => setState(() => diselamatkanOleh = 2),
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                            child: Center(child: Text('Orang lain', style: TextStyle(color: diselamatkanOleh == 2 ? Colors.white : Colors.black),)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0,),
                              Text('Detail penyelamatan', style: TextStyle(fontSize: 18.0,)),
                              SizedBox(height: 5.0,),
                              Text('Ceritakan bagaimana hewan tersebut telah diselamatkan.', style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 5.0,),
                              TextField(
                                // controller: controllerUsername,
                                obscureText: false,
                                maxLines: 5,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                              ),
                              SizedBox(height: 8.0,),
                              Text('Tanggal penyelamatan', style: TextStyle(fontSize: 18.0,)),
                              Text("${selectedDate.toLocal()}".split(' ')[0], style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 8.0,),
                              Text('Lokasi penyelamatan', style: TextStyle(fontSize: 18.0,)),
                              SizedBox(height: 5.0,),
                              TextField(
                                // controller: controllerUsername,
                                obscureText: false,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                              ),
                              SizedBox(height: 8.0,),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Pilih Provinsi'),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => setState(() => isPilihProvinsi = true),
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Padding(padding: EdgeInsets.all(10.0), child: Text('Ubah')),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 8.0,),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Pilih Kota'),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => setState(() => isPilihKota = true),
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Padding(padding: EdgeInsets.all(10.0), child: Text('Ubah')),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Text('Tambahkan foto sebagai bukti hewan telah diselamatkan.', style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 10.0,),
                    _image != null ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.file(_image, fit: BoxFit.fill,)
                            ),
                          ),
                          Positioned(
                            top: 10.0,
                            right: 10.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15.0)
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  // onTap: () => getImage(true),
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(25.0),
                                  splashColor: Colors.black26,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text('Ganti foto ', style: TextStyle(color: Colors.white),),
                                        Icon(LineIcons.camera, color: Colors.white,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ) : IconButton(
                      icon: Icon(LineIcons.camera),
                      // onPressed: () => getImage(true),
                      onPressed: () {},
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
                              child: Text('Konfirmasi sekarang', style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          isPilihProvinsi ? Positioned.fill(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onVerticalDragDown: (update) => setState(() => isPilihProvinsi = false),
                    onTap: () => setState(() => isPilihProvinsi = false),
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
                          onTap: () => setState(() => isPilihProvinsi = false),
                          borderRadius: BorderRadius.circular(25.0),
                          child: Padding(padding: EdgeInsets.all(5.0), child: Icon(LineIcons.cross),),
                        ),),
                      ],),
                      Container(
                        height: 250.0,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                            ListViewItemsProvinsi(onTap: (){}, text: 'Jakarta Barat',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Jakarta Pusat',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Jakarta Tengah',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Jakarta Selatan',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Tangerang',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Jawa Barat',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Jawa Tengan',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Jawa Timur',),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ) : isPilihKota ? Positioned.fill(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onVerticalDragDown: (update) => setState(() => isPilihKota = false),
                    onTap: () => setState(() => isPilihKota = false),
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
                          onTap: () => setState(() => isPilihKota = false),
                          borderRadius: BorderRadius.circular(25.0),
                          child: Padding(padding: EdgeInsets.all(5.0), child: Icon(LineIcons.cross),),
                        ),),
                      ],),
                      Container(
                        height: 250.0,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                            ListViewItemsProvinsi(onTap: (){}, text: 'Surabaya',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Lumajang',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Jember',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Kediri',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Kab. Probolinggo',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Kab. Pasuruan',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Kab. Malang',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Kota Pasuruan',),
                            ListViewItemsProvinsi(onTap: (){}, text: 'Kota Malang',),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ) : Container()
        ],
      ),
    );
  }
}

class ListViewItemsProvinsi extends StatelessWidget {
  ListViewItemsProvinsi({
    required this.onTap, 
    required this.text
  });

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent, child: InkWell(
      onTap: onTap, child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        child: Center(child: Text(text)),
      ),
    ),);
  }
}