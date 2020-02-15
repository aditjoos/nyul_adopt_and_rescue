import 'package:flutter/material.dart';
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
          SizedBox(height: 25.0,),
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
                )
              ],
            ),
          ),
          SizedBox(height: 120.0,),
        ],
      ),
    );
  }
}