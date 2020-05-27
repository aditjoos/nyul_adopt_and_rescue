import 'package:flutter/material.dart';

class FunkyOverlay extends StatefulWidget {
  FunkyOverlay(this.content, this.actions);

  final String content;
  final List<Widget> actions;
  
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();


  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.content),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: widget.actions,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FunkyLoading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyLoadingState();
}

class FunkyLoadingState extends State<FunkyLoading> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();


  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FunkyDialog extends StatefulWidget {
  FunkyDialog(this.title, this.child, this.mainAxisSize);

  final Widget title;
  final Widget child;
  final MainAxisSize mainAxisSize;
  
  @override
  State<StatefulWidget> createState() => FunkyDialogState();
}

class FunkyDialogState extends State<FunkyDialog> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();


  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                mainAxisSize: widget.mainAxisSize,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.title,
                  widget.child
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyDialogTitle extends StatefulWidget {
  MyDialogTitle({this.title, this.backgroundColor, this.titleColor});

  final String title;
  final Color backgroundColor;
  final Color titleColor;

  @override
  _MyDialogTitleState createState() => _MyDialogTitleState();
}

class _MyDialogTitleState extends State<MyDialogTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: widget.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)))),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Text(widget.title, style: TextStyle(
            color: widget.titleColor,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}