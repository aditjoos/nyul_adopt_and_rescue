import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/Pages/Pesan/PesanUser.dart';
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
        padding: EdgeInsets.all(15.0),
        color: Color(0xFFFAFAFA),
        child: Column(
          children: <Widget>[
            SafeArea(child: Center(child: Text('Pesan Terbaru', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),)),
            SizedBox(height: 10.0,),
            MyContainer(
              width: double.infinity,
              child: Material(
                color: Colors.transparent,
                child: ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PesanUser())),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage('https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/66/66adceda7ade28d229597b106eda2735d15f8c27_full.jpg'),
                  ),
                  title: Text('Felix Kohln'),
                  subtitle: Text('lorem ipsum dolor sit amet.'),
                  dense: false,
                  trailing: Text('15:00'),
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            MyContainer(
              width: double.infinity,
              child: Material(
                color: Colors.transparent,
                child: ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PesanUser())),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage('https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/66/66adceda7ade28d229597b106eda2735d15f8c27_full.jpg'),
                  ),
                  title: Text('Felix Kohln'),
                  subtitle: Text('lorem ipsum dolor sit amet.'),
                  dense: false,
                  trailing: Text('15:00'),
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            MyContainer(
              width: double.infinity,
              child: Material(
                color: Colors.transparent,
                child: ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PesanUser())),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage('https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/66/66adceda7ade28d229597b106eda2735d15f8c27_full.jpg'),
                  ),
                  title: Text('Felix Kohln'),
                  subtitle: Text('lorem ipsum dolor sit amet.'),
                  dense: false,
                  trailing: Text('15:00'),
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            MyContainer(
              width: double.infinity,
              child: Material(
                color: Colors.transparent,
                child: ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PesanUser())),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage('https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/66/66adceda7ade28d229597b106eda2735d15f8c27_full.jpg'),
                  ),
                  title: Text('Felix Kohln'),
                  subtitle: Text('lorem ipsum dolor sit amet.'),
                  dense: false,
                  trailing: Text('15:00'),
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            MyContainer(
              width: double.infinity,
              child: Material(
                color: Colors.transparent,
                child: ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PesanUser())),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage('https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/66/66adceda7ade28d229597b106eda2735d15f8c27_full.jpg'),
                  ),
                  title: Text('Felix Kohln'),
                  subtitle: Text('lorem ipsum dolor sit amet.'),
                  dense: false,
                  trailing: Text('15:00'),
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            MyContainer(
              width: double.infinity,
              child: Material(
                color: Colors.transparent,
                child: ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PesanUser())),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage('https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/66/66adceda7ade28d229597b106eda2735d15f8c27_full.jpg'),
                  ),
                  title: Text('Felix Kohln'),
                  subtitle: Text('lorem ipsum dolor sit amet.'),
                  dense: false,
                  trailing: Text('15:00'),
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            SizedBox(height: 120.0,),
          ],
        ),
      ),
    );
  }
}