import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/Pages/Feed.dart';
import 'package:petz_invention_udayana/Pages/Home.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: selectedPage == 0 ? HomePage() : selectedPage == 1 ? FeedPage() : Center(child: Text('no page selected'),),
          ),
          // Custom Bottom Navigation Bar
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            // width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 10.0,
                    spreadRadius: 1.0
                  )
                ]
              ),
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // Buttons
                  CustomBottomBarButton(
                    backgroundColor: selectedPage == 0 ? Colors.orange[300] : Colors.white,
                    borderColor: Colors.orange[300],
                    icon: Icon(LineIcons.home, color: selectedPage == 0 ? Colors.white : Colors.black,),
                    title: 'Beranda',
                    onTap: (){
                      setState(() {
                        selectedPage = 0;
                      });
                    },
                  ),
                  CustomBottomBarButton(
                    backgroundColor: selectedPage == 1 ? Colors.orange[300] : Colors.white,
                    borderColor: Colors.orange[300],
                    icon: Icon(LineIcons.home, color: selectedPage == 1 ? Colors.white : Colors.black,),
                    title: 'Feed',
                    onTap: (){
                      setState(() {
                        selectedPage = 1;
                      });
                    },
                  ),
                  CustomBottomBarButton(
                    backgroundColor: Colors.white,
                    borderColor: Colors.orange[300],
                    icon: Icon(LineIcons.plus, color: Colors.black),
                    title: 'Tambah',
                    onTap: (){},
                  ),
                  CustomBottomBarButton(
                    backgroundColor: Colors.white,
                    borderColor: Colors.orange[300],
                    icon: Icon(LineIcons.paw, color: Colors.black),
                    title: 'My Pet',
                    onTap: (){},
                  ),
                  CustomBottomBarButton(
                    backgroundColor: Colors.white,
                    borderColor: Colors.orange[300],
                    icon: Icon(LineIcons.user, color: Colors.black),
                    title: 'Akun',
                    onTap: (){},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  .------------------.
// | Custom Components |=-----------------------------------------------------
// '------------------'

class CustomBottomBarButton extends StatefulWidget {
  CustomBottomBarButton({
    this.icon,
    this.title,
    this.backgroundColor,
    this.borderColor,
    this.onTap
  });

  final Icon icon;
  final String title;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  CustomBottomBarButtonState createState() => CustomBottomBarButtonState();
}

class CustomBottomBarButtonState extends State<CustomBottomBarButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: widget.icon,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              border: Border.all(
                color: widget.borderColor,
                style: BorderStyle.solid,
                width: 2
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          SizedBox(height: 10.0,),
          Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
      onTap: widget.onTap,
    );
  }
}