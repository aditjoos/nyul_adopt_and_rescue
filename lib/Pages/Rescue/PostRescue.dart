import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';

class PostRescuePage extends StatefulWidget {
  @override
  _PostRescuePageState createState() => _PostRescuePageState();
}

class _PostRescuePageState extends State<PostRescuePage> {

  File _image;

  Future getImage(bool chosenIsCamera) async {
    File image;
    if(chosenIsCamera) image = await ImagePicker.pickImage(source: ImageSource.camera);
    else image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();

    if(_image == null) getImage(true);
  }

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
              Center(child: Text('Tambah Posting Rescue', style: TextStyle(fontSize: 20.0),),),
              SizedBox(height: 20.0,),
              _image != null ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(_image, fit: BoxFit.fill,)
                ),
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}