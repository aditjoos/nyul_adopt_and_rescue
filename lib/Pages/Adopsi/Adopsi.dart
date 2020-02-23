import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';

class AdopsiPage extends StatefulWidget {
  @override
  _AdopsiPageState createState() => _AdopsiPageState();
}

class _AdopsiPageState extends State<AdopsiPage> {
  
  List data = [1,2,3,4,5];
  bool isLoadingData = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoadingData = false;
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
                          icon: Icon(LineIcons.arrow_left, color: Colors.white,),
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
                        Text('${data.length} unggahan', style: TextStyle(color: Colors.white),),
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
                child: !isLoadingData ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.660
                  ),
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext contex, int index){
                    return PostAdopsiCard(
                      imgSource: 'assets/images/rabbit.jpeg',
                      judul: 'Kelinci loncat2',
                      jenis: 2,
                      ras: '-',
                      umur: '2 Tahun',
                      alamat: 'Blimbing, Malang',
                      metodeAdopsi: 1,
                    );
                  },
                ) : Center(child: CircularProgressIndicator(),),
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