import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';

class PostRescuePage extends StatefulWidget {
  @override
  _PostRescuePageState createState() => _PostRescuePageState();
}

class _PostRescuePageState extends State<PostRescuePage> {

  bool postAsAnonymous = false;

  void _onChangePostAsAnonymousValue(bool newValue) => setState(() {
    postAsAnonymous = newValue;

    if (postAsAnonymous) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  });

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
                            Expanded(child: Text('Jl. Hambalang no.13', style: TextStyle(color: Colors.grey))),
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
                        Text('Deskripsi hewan', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8.0,),
                        Text('Tulis deskripsi mengenai kenapa hewan ini harus mendapatkan penanganan.', style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 8.0,),
                        TextField(
                          // controller: controllerUsername,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                            hintText: "Deskripsi hewan",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: postAsAnonymous,
                        onChanged: _onChangePostAsAnonymousValue,
                      ),
                      Text('Posting sebagai anonymous')
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => FunkyDialog(
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Posting sebagai anonymous ?', style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                            child: Text('Jika kamu posting rescue secara anonymous/tanpa identitas, maka kamu tidak akan mendapatkan poin atau rating.'),
                          ),
                          MainAxisSize.min
                        ),
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(LineIcons.question_circle),
                      ),
                    ),
                  )
                ],
              ),
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
    );
  }
}