import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyContainer extends StatelessWidget {
  MyContainer({
    this.width,
    this.height,
    required this.child,
    this.padding = const EdgeInsets.all(0),
    this.color = Colors.white,
  });

  final Widget child;
  final Color color;
  final EdgeInsets padding;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(0.0, 2.0),
            blurRadius: 10.0,
            spreadRadius: 1.0
          )
        ],
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
      child: child,
    );
  }
}

class PostAdopsiCard extends StatelessWidget {
  PostAdopsiCard({
    required this.imgSource,
    this.judul = 'Judul',
    this.jenis = 1,
    required this.ras,
    required this.umur,
    required this.alamat,
    required this.metodeAdopsi,
    required this.onTap,
  });

  final String imgSource;
  final String judul;
  final int jenis;
  final String ras;
  final String umur;
  final String alamat;
  final int metodeAdopsi;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
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
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  height: MediaQuery.of(context).size.width / 2 - 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(imgSource, fit: BoxFit.fill,)
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(judul, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text(ras+', '+umur),
                      Text(alamat),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.orange.shade400,
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