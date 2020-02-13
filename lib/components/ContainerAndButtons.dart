import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyContainer extends StatelessWidget {
  MyContainer({this.child, this.color, this.padding});

  final Widget child;
  final Color color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            offset: Offset(0.0, 2.0),
            blurRadius: 10.0,
            spreadRadius: 1.0
          )
        ],
        borderRadius: BorderRadius.circular(10.0),
        color: color == null ? Colors.white : color,
      ),
      child: child,
    );
  }
}

class PostAdopsiCard extends StatelessWidget {
  PostAdopsiCard({
    this.imgSource,
    this.judul,
    this.jenis,
    this.ras,
    this.umur,
    this.alamat,
    this.metodeAdopsi,
  });

  final String imgSource;
  final String judul;
  final int jenis;
  final String ras;
  final String umur;
  final String alamat;
  final int metodeAdopsi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              offset: Offset(0.0, 2.0),
              blurRadius: 10.0,
              spreadRadius: 1.0
            )
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: (){},
            child: Column(
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(imgSource, fit: BoxFit.fill,)
                  ),
                ),
                Container(
                  width: 150.0,
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(judul, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(ras+', '+umur),
                      Text(alamat),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.orange[400],
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Text(metodeAdopsi == 1 ? 'Paid' : 'Free', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),)
                          ), // v rabbit
                          Icon(jenis == 1 ? FontAwesomeIcons.cat : jenis == 2 ? FontAwesomeIcons.dog : FontAwesomeIcons.cat, size: 15,)
                        ],
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}