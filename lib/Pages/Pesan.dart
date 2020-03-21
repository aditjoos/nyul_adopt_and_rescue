import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';

class PesanPage extends StatefulWidget {
  @override
  _PesanPageState createState() => _PesanPageState();
}

class _PesanPageState extends State<PesanPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: Color(0xFFFAFAFA),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0,),
            Center(child: Text('Pesan', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),),
            SizedBox(height: 10.0,),
            MyContainer(
              width: MediaQuery.of(context).size.width - 20,
              child: Text('This isContainer'),
            ),
            SizedBox(height: 15.0,),
            SizedBox(height: 120.0,),
          ],
        ),
      ),
    );
  }
}