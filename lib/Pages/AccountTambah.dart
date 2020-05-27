import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';

class AccountTambahPage extends StatefulWidget {
  @override
  _AccountTambahPageState createState() => _AccountTambahPageState();
}

class _AccountTambahPageState extends State<AccountTambahPage> {

  int _radioGroup = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SafeArea(
                child: Row(
                  children: <Widget>[
                    IconButton(icon: Icon(LineIcons.arrow_left), onPressed: () => Navigator.pop(context)),
                    Text('Kembali')
                  ],
                ),
              ),
              Center(child: Text('Tambah Akun', style: TextStyle(fontSize: 20.0),),),
              SizedBox(height: 10.0,),
              ExpansionTile(
                leading: Radio(value: 1, groupValue: _radioGroup, onChanged: (T){
                  setState(() {
                    _radioGroup = T;
                  });
                }),
                title: Text('Dokter hewan'),
                trailing: Icon(Icons.chevron_right),
                children: <Widget>[
                  SizedBox(height: 5.0,),
                  Text('Pilih ini jika kamu ingin membantu hewan-hewan yang butuh pertolongan diluar sana.', textAlign: TextAlign.center,),
                  SizedBox(height: 5.0,),
                ],
              ),
              SizedBox(height: 10.0,),
              ExpansionTile(
                leading: Radio(value: 2, groupValue: _radioGroup, onChanged: (T){
                  setState(() {
                    _radioGroup = T;
                  });
                }),
                title: Text('Shelter'),
                trailing: Icon(Icons.chevron_right),
                children: <Widget>[
                  SizedBox(height: 5.0,),
                  Text('Berikan tempat tinggal kepada hewan-hewan diluar, mereka akan menunggu majikan baru.', textAlign: TextAlign.center,),
                  SizedBox(height: 5.0,),
                ],
              ),
              SizedBox(height: 10.0,),
              ExpansionTile(
                leading: Radio(value: 3, groupValue: _radioGroup, onChanged: (T){
                  setState(() {
                    _radioGroup = T;
                  });
                }),
                title: Text('Petshop'),
                trailing: Icon(Icons.chevron_right),
                children: <Widget>[
                  SizedBox(height: 5.0,),
                  Text('Mereka ingin beli-beli, ajak belanja aja.', textAlign: TextAlign.center,),
                  SizedBox(height: 5.0,),
                ],
              ),
              SizedBox(height: 10.0,),
              ExpansionTile(
                leading: Radio(value: 4, groupValue: _radioGroup, onChanged: (T){
                  setState(() {
                    _radioGroup = T;
                  });
                }),
                title: Text('Cattery'),
                trailing: Icon(Icons.chevron_right),
                children: <Widget>[
                  SizedBox(height: 5.0,),
                  Text('Hidup berpasangan yang romantis, uh So Sweet~', textAlign: TextAlign.center,),
                  SizedBox(height: 5.0,),
                ],
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
                    onTap: () => showDialog(barrierDismissible: true, context: context, builder: (_) => FunkyOverlay('Halaman/fitur ini masih dalam tahap konstruksi, mohon ditunggu ya~ \n^_^)/', [FlatButton(onPressed: () => Navigator.pop(context), child: Text('OK'))])),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Text('Selanjutnya', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}