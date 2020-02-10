import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 250.0,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // Search Bar
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.5,
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

                                  //Actions Bar
                                  Icon(LineIcons.envelope, color: Colors.white,),
                                  Icon(LineIcons.heart, color: Colors.white,),
                                  Icon(LineIcons.bell, color: Colors.white,),
                                ],
                              ),
                            )
                            
                            //text

                            //sub text -> scroll view horizontal
                          ],
                        ),
                        color: Colors.orange[400],
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
                          ),
                        ),
                      )
                    ],
                  ),
                  Text('Eksplorasi.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Color(0xFF606060)),),
                  Row(
                    children: <Widget>[
                      MainFeatureCard(
                        assetImage: 'assets/images/adoptme-bublee.png',
                        title: 'Feed Me',
                        onTap: (){},
                      ),
                      MainFeatureCard(
                        assetImage: 'assets/images/saveme-bublee.png',
                        title: 'Feed Me',
                        onTap: (){},
                      ),
                      MainFeatureCard(
                        assetImage: 'assets/images/feedme-bublee.png',
                        title: 'Feed Me',
                        onTap: (){},
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 20.0,),
                        CustomIconButtonWithTitle(
                          backgroundColor: Colors.white,
                          borderColor: Colors.orange[300],
                          icon: Icon(FontAwesomeIcons.briefcaseMedical),
                          onTap: (){},
                          title: 'Dokter',
                        ),
                        SizedBox(width: 20.0,),
                        CustomIconButtonWithTitle(
                          backgroundColor: Colors.white,
                          borderColor: Colors.orange[300],
                          icon: Icon(FontAwesomeIcons.shoppingBag),
                          onTap: (){},
                          title: 'Pet Shop',
                        ),
                        SizedBox(width: 20.0,),
                        CustomIconButtonWithTitle(
                          backgroundColor: Colors.white,
                          borderColor: Colors.orange[300],
                          icon: Icon(FontAwesomeIcons.archive),
                          onTap: (){},
                          title: 'Shelter',
                        ),
                        SizedBox(width: 20.0,),
                        CustomIconButtonWithTitle(
                          backgroundColor: Colors.white,
                          borderColor: Colors.orange[300],
                          icon: Icon(FontAwesomeIcons.cat),
                          onTap: (){},
                          title: 'Cattery',
                        ),
                        SizedBox(width: 20.0,),
                        CustomIconButtonWithTitle(
                          backgroundColor: Colors.white,
                          borderColor: Colors.orange[300],
                          icon: Icon(FontAwesomeIcons.handPaper),
                          onTap: (){},
                          title: 'Riwayat',
                        ),
                        SizedBox(width: 20.0,),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                        child: Text('Hewan kondisi darurat didekatmu', style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        // Request Rescue Card
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: (){},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red[400],
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFD0D0D0),
                                    offset: Offset(0, 0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0
                                  ),
                                ]
                              ),
                              width: 250.0,
                              height: 100.0,
                              child: Stack(
                                children: <Widget>[
                                  Image.asset('assets/images/BG1.png'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(LineIcons.warning, size: 50.0, color: Colors.white,),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text('Kucing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white)),
                                            Text('Jl. Kepanjen 666', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.white)),
                                            Text('Terkapar setelah tertabrak angin.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.white))
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: (){},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red[400],
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFD0D0D0),
                                    offset: Offset(0, 0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0
                                  ),
                                ]
                              ),
                              width: 250.0,
                              height: 100.0,
                              child: Stack(
                                children: <Widget>[
                                  Image.asset('assets/images/BG1.png'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(LineIcons.warning, size: 50.0, color: Colors.white,),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text('Kucing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white)),
                                            Text('Jl. Kepanjen 666', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.white)),
                                            Text('Terkapar setelah tertabrak angin.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.white))
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 120.0,)
                ],
              ),
            )
          ),
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
                    color: Color(0xFFa3b1c6),
                    offset: Offset(0, 0),
                    blurRadius: 3.0,
                    spreadRadius: 0
                  ),
                ]
              ),
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // Buttons
                  CustomBottomBarButton(
                    backgroundColor: Colors.orange[300],
                    borderColor: Colors.orange[300],
                    icon: Icon(LineIcons.home, color: Colors.white,),
                    title: 'Beranda',
                    onTap: (){},
                  ),
                  CustomBottomBarButton(
                    backgroundColor: Colors.white,
                    borderColor: Colors.orange[300],
                    icon: Icon(LineIcons.comments, color: Colors.black),
                    title: 'Feed',
                    onTap: (){},
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

class CustomIconButtonWithTitle extends StatefulWidget {
  CustomIconButtonWithTitle({
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
  _CustomIconButtonWithTitleState createState() => _CustomIconButtonWithTitleState();
}

class _CustomIconButtonWithTitleState extends State<CustomIconButtonWithTitle> {
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
                width: 5
              ),
              borderRadius: BorderRadius.circular(30.0),
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

class MainFeatureCard extends StatefulWidget {
  MainFeatureCard({
    this.assetImage,
    this.title,
    this.onTap,
  });

  final String assetImage;
  final String title;
  final VoidCallback onTap;

  @override
  _MainFeatureCardState createState() => _MainFeatureCardState();
}

class _MainFeatureCardState extends State<MainFeatureCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width/3,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFE6E6E6),
                offset: Offset(0, 0),
                blurRadius: 25.0,
                spreadRadius: 0
              ),
              BoxShadow(
                color: Color(0xFFDEDEDE),
                offset: Offset(0, 0),
                blurRadius: 5.0,
                spreadRadius: 0
              ),
            ]
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset(widget.assetImage, height: 100.0,),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}