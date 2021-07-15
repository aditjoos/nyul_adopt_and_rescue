import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nyul_adopt_rescue/components/ContainerAndButtons.dart';
import 'package:nyul_adopt_rescue/components/Dialogs.dart';

class PostAdopsiPage extends StatefulWidget {
  @override
  _PostAdopsiPageState createState() => _PostAdopsiPageState();
}

class _PostAdopsiPageState extends State<PostAdopsiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SafeArea(
                child: Row(
                  children: <Widget>[
                    IconButton(icon: Icon(LineIcons.times), onPressed: () {
                      // showDialog(
                      //   barrierDismissible: false,
                      //   context: context,
                      //   builder: (BuildContext context) => FunkyDialog(
                      //     Center(
                      //       child: Padding(padding: EdgeInsets.only(top: 15.0), child: Text('Yakin batal?'),),
                      //     ),
                      //     Container(
                      //       padding: EdgeInsets.all(10.0),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: <Widget>[
                      //           FlatButton(onPressed: () => Navigator.pop(context), child: Text('Tidak')),
                      //           FlatButton(onPressed: (){
                      //             for (var i = 0; i < 2; i++) {
                      //               Navigator.pop(context);
                      //             }
                      //           }, child: Text('Ya')),
                      //         ],
                      //       ),
                      //     ),
                      //     MainAxisSize.min
                      //   )
                      // )
                    }),
                    Text('Batal')
                  ],
                ),
              ),
              Center(child: Text('Tambah Posting Adopsi', style: TextStyle(fontSize: 20.0),),),
              SizedBox(height: 20.0,),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset('assets/images/rabbit.jpeg', fit: BoxFit.fill,)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset('assets/images/rabbit.jpeg', fit: BoxFit.fill,)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset('assets/images/rabbit.jpeg', fit: BoxFit.fill,)
                        ),
                      ),
                    ),
                    IconButton(icon: Icon(LineIcons.plus), onPressed: (){})
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                // controller: controllerUsername,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Judul",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(height: 10.0,),
              TextField(
                // controller: controllerUsername,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Nama Hewan",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(height: 10.0,),
              MyContainer(
                child: ListTile(
                  title: Text('Jenis Hewan'),
                  trailing: Icon(Icons.keyboard_arrow_down, color: Colors.orange,),
                  onTap: (){
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) => FunkyDialog(
                    //     MyDialogTitle(title: 'Pilih Jenis Hewan', backgroundColor: Colors.orange[300], titleColor: Colors.white,),
                    //     Container(
                    //       child: Center(
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: <Widget>[
                    //             FlatButton(
                    //               child: Container(width: MediaQuery.of(context).size.width / 2, child: Center(child: Text('Kucing'))),
                    //               onPressed: (){
                    //                 setState(() {
                    //                   Navigator.pop(context);
                    //                 });
                    //               },
                    //             ),
                    //             FlatButton(
                    //               child: Container(width: MediaQuery.of(context).size.width / 2, child: Center(child: Text('Anjing'))),
                    //               onPressed: (){
                    //                 setState(() {
                    //                   Navigator.pop(context);
                    //                 });
                    //               },
                    //             ),
                    //             FlatButton(
                    //               child: Container(width: MediaQuery.of(context).size.width / 2, child: Center(child: Text('Kelinci'))),
                    //               onPressed: (){
                    //                 setState(() {
                    //                   Navigator.pop(context);
                    //                 });
                    //               },
                    //             ),
                    //             FlatButton(
                    //               child: Container(width: MediaQuery.of(context).size.width / 2, child: Center(child: Text('Lainnya'))),
                    //               onPressed: (){
                    //                 setState(() {
                    //                   Navigator.pop(context);
                    //                 });
                    //               },
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     MainAxisSize.min
                    //   )
                    // );
                  },
                ),
              ),
              SizedBox(height: 10.0,),
              MyContainer(
                child: ListTile(
                  title: Text('Ras Hewan'),
                  trailing: Icon(Icons.keyboard_arrow_down, color: Colors.orange,),
                  onTap: (){
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) => FunkyDialog(
                    //     MyDialogTitle(title: 'Pilih Jenis Hewan', backgroundColor: Colors.orange[300], titleColor: Colors.white,),
                    //     Container(
                    //       child: Center(
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: <Widget>[
                    //             FlatButton(
                    //               child: Container(width: MediaQuery.of(context).size.width / 2, child: Center(child: Text('Ras 1'))),
                    //               onPressed: (){
                    //                 setState(() {
                    //                   Navigator.pop(context);
                    //                 });
                    //               },
                    //             ),
                    //             FlatButton(
                    //               child: Container(width: MediaQuery.of(context).size.width / 2, child: Center(child: Text('Ras 2'))),
                    //               onPressed: (){
                    //                 setState(() {
                    //                   Navigator.pop(context);
                    //                 });
                    //               },
                    //             ),
                    //             FlatButton(
                    //               child: Container(width: MediaQuery.of(context).size.width / 2, child: Center(child: Text('Ras 3'))),
                    //               onPressed: (){
                    //                 setState(() {
                    //                   Navigator.pop(context);
                    //                 });
                    //               },
                    //             ),
                    //             FlatButton(
                    //               child: Container(width: MediaQuery.of(context).size.width / 2, child: Center(child: Text('Lainnya'))),
                    //               onPressed: (){
                    //                 setState(() {
                    //                   Navigator.pop(context);
                    //                 });
                    //               },
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     MainAxisSize.min
                    //   )
                    // );
                  },
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                // controller: controllerUsername,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Input ras (opsional)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(height: 10.0,),
              MyContainer(
                child: ListTile(
                  title: Text('Jenis Kelamin'),
                  trailing: Icon(Icons.keyboard_arrow_down, color: Colors.orange,),
                  onTap: (){
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) => FunkyDialog(
                    //     MyDialogTitle(title: 'Pilih Jenis Kelamin Hewan', backgroundColor: Colors.orange[300], titleColor: Colors.white,),
                    //     Container(
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //         children: <Widget>[
                    //           FlatButton(
                    //             child: Text('Jantan'),
                    //             onPressed: (){
                    //               setState(() {
                    //                 Navigator.pop(context);
                    //               });
                    //             },
                    //           ),
                    //           FlatButton(
                    //             child: Text('Betina'),
                    //             onPressed: (){
                    //               setState(() {
                    //                 Navigator.pop(context);
                    //               });
                    //             },
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     MainAxisSize.min
                    //   )
                    // );
                  },
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                // controller: controllerUsername,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Umur",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(height: 10.0,),
              MyContainer(
                child: ListTile(
                  title: Text('Vaksin | Pilih'),
                  trailing: Icon(Icons.keyboard_arrow_down, color: Colors.orange,),
                  onTap: (){
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) => FunkyDialog(
                    //     MyDialogTitle(title: 'Vaksin ?', backgroundColor: Colors.orange[300], titleColor: Colors.white,),
                    //     Container(
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //         children: <Widget>[
                    //           FlatButton(
                    //             child: Text('Ya'),
                    //             onPressed: (){
                    //               setState(() {
                    //                 Navigator.pop(context);
                    //               });
                    //             },
                    //           ),
                    //           FlatButton(
                    //             child: Text('Tidak'),
                    //             onPressed: (){
                    //               setState(() {
                    //                 Navigator.pop(context);
                    //               });
                    //             },
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     MainAxisSize.min
                    //   )
                    // );
                  },
                ),
              ),
              SizedBox(height: 10.0,),
              MyContainer(
                child: ListTile(
                  title: Text('Steril | Pilih'),
                  trailing: Icon(Icons.keyboard_arrow_down, color: Colors.orange,),
                  onTap: (){
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) => FunkyDialog(
                    //     MyDialogTitle(title: 'Steril ?', backgroundColor: Colors.orange[300], titleColor: Colors.white,),
                    //     Container(
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //         children: <Widget>[
                    //           FlatButton(
                    //             child: Text('Ya'),
                    //             onPressed: (){
                    //               setState(() {
                    //                 Navigator.pop(context);
                    //               });
                    //             },
                    //           ),
                    //           FlatButton(
                    //             child: Text('Tidak'),
                    //             onPressed: (){
                    //               setState(() {
                    //                 Navigator.pop(context);
                    //               });
                    //             },
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     MainAxisSize.min
                    //   )
                    // );
                  },
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                // controller: controllerUsername,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Alasan diadopsikan",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(height: 10.0,),
              TextField(
                // controller: controllerUsername,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Deskripsi",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(height: 10.0,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.orange[400]
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15.0),
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Kirim', style: TextStyle(color: Colors.white),),
                            Icon(LineIcons.paperPlane, color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}