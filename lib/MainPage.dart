import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/Pages/Adopsi/PostAdopsi.dart';
import 'package:petz_invention_udayana/Pages/Feed.dart';
import 'package:petz_invention_udayana/Pages/Home.dart';
import 'package:petz_invention_udayana/Pages/Rescue/PostRescue.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;
  bool tambahMenuOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: selectedPage == 0 ? HomePage() : selectedPage == 1 ? FeedPage() : Center(child: Text('no page selected'),),
          ),
          tambahMenuOpened ? Positioned.fill(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  tambahMenuOpened = false;
                });
              },
              onVerticalDragStart: (update){
                setState(() {
                  tambahMenuOpened = false;
                });
              },
              child: Material(
                color: Colors.transparent,
              ),
            ),
          ) : Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(),
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
                    title: 'Home',
                    onTap: (){
                      setState(() {
                        tambahMenuOpened = false;
                        selectedPage = 0;
                      });
                    },
                  ),
                  CustomBottomBarButton(
                    backgroundColor: selectedPage == 1 ? Colors.orange[300] : Colors.white,
                    borderColor: Colors.orange[300],
                    icon: Icon(LineIcons.commenting, color: selectedPage == 1 ? Colors.white : Colors.black,),
                    title: 'Feed',
                    onTap: (){
                      setState(() {
                        tambahMenuOpened = false;
                        selectedPage = 1;
                      });
                    },
                  ),
                  CustomBottomBarButton(
                    backgroundColor: Colors.white,
                    borderColor: Colors.orange[300],
                    icon: Icon(LineIcons.plus, color: Colors.black),
                    title: 'Tambah',
                    onTap: (){
                      setState(() {
                        tambahMenuOpened = true;
                      });
                    },
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
          tambahMenuOpened ? Positioned(
            bottom: 10,
            child: Container(
              // color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInCirc,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  width: (MediaQuery.of(context).size.width/5)-10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.orange[300],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 10.0,
                        spreadRadius: 1.0
                      )
                    ]
                  ),
                  child: Column(
                    children: <Widget>[
                      CustomBottomBarButton2(
                        backgroundColor: Colors.white,
                        borderColor: Colors.orange[300],
                        icon: Icon(LineIcons.shield, color: Colors.black),
                        title: 'Rescue',
                        textAndButtonPadding: 5.0,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => PostRescuePage()));

                          setState(() {
                            tambahMenuOpened = false;
                          });
                        },
                      ),SizedBox(height: 5.0,),
                      CustomBottomBarButton2(
                        backgroundColor: Colors.white,
                        borderColor: Colors.orange[300],
                        icon: Icon(LineIcons.paw, color: Colors.black),
                        title: 'Adopsi',
                        textAndButtonPadding: 5.0,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => PostAdopsiPage()));

                          setState(() {
                            tambahMenuOpened = false;
                          });
                        },
                      ),SizedBox(height: 5.0,),
                      CustomBottomBarButton2(
                        backgroundColor: Colors.orange[300],
                        borderColor: Colors.orange[300],
                        icon: Icon(LineIcons.plus, color: Colors.white),
                        title: 'Tambah',
                        textAndButtonPadding: 10.0,
                        onTap: (){
                          setState(() {
                            tambahMenuOpened = false;
                          });
                        },
                      ),
                    ],
                  )
                )
              ),
            )
          ) : Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(),
          )
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

class CustomBottomBarButton2 extends StatefulWidget {
  CustomBottomBarButton2({
    this.icon,
    this.title,
    this.backgroundColor,
    this.borderColor,
    this.onTap,
    this.textAndButtonPadding
  });

  final Icon icon;
  final String title;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onTap;
  final double textAndButtonPadding;

  @override
  CustomBottomBarButton2State createState() => CustomBottomBarButton2State();
}

class CustomBottomBarButton2State extends State<CustomBottomBarButton2> {
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
          SizedBox(height: widget.textAndButtonPadding,),
          Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
        ],
      ),
      onTap: widget.onTap,
    );
  }
}