import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 40.0,),
          Center(child: Text('Feed', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),),
          SizedBox(height: 10.0,),
          MyContainer(
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    radius: 20.0,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/100'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Bagus Muhaiminul Aziz'),
                  subtitle: Text('1 jam yang lalu.'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                  child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset('assets/images/cat-feedpage.png', fit: BoxFit.fill,)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(onTap: (){}, child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(children: <Widget>[Icon(LineIcons.thumbs_up, size: 12,), Text('Suka', style: TextStyle(fontSize: 12),)],),
                        )),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(onTap: (){}, child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(children: <Widget>[Icon(LineIcons.comment, size: 12,), Text('Komentar', style: TextStyle(fontSize: 12),)],),
                        )),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(onTap: (){}, child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(children: <Widget>[Icon(LineIcons.share, size: 12,), Text('Bagikan', style: TextStyle(fontSize: 12),)],),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0,),
          MyContainer(
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    radius: 20.0,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/100'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Bagus Muhaiminul Aziz'),
                  subtitle: Text('1 jam yang lalu.'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                  child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset('assets/images/cat-feedpage.png', fit: BoxFit.fill,)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(onTap: (){}, child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(children: <Widget>[Icon(LineIcons.thumbs_up, size: 12,), Text('Suka', style: TextStyle(fontSize: 12),)],),
                        )),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(onTap: (){}, child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(children: <Widget>[Icon(LineIcons.comment, size: 12,), Text('Komentar', style: TextStyle(fontSize: 12),)],),
                        )),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(onTap: (){}, child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(children: <Widget>[Icon(LineIcons.share, size: 12,), Text('Bagikan', style: TextStyle(fontSize: 12),)],),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 120.0,),
        ],
      ),
    );
  }
}