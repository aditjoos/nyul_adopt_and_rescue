import 'package:flutter/material.dart';

class MyDialogs {
  loadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: MyDialog(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          child: CircularProgressIndicator(),
        ),
      )
    );
  }

  simpleDialog(BuildContext context, String title, String? contentText) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => MyActionDialog(
        title: title,
        body: contentText?? 'Content Text.',
        buttonText: 'OK',
        actionOnTap: () {
          Navigator.pop(context);
        },
      )
    );
  }

  functionDialog(BuildContext context, String title, String contentText, VoidCallback function) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => MyActionDialog(
        title: title,
        body: contentText,
        buttonText: 'OK',
        actionOnTap: () {
          Navigator.pop(context);
          function();
        },
      )
    );
  }

  errorDialog(BuildContext context, String title, String contentText, VoidCallback function) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => MyActionDialog(
        title: title,
        body: contentText,
        buttonText: 'Ulangi',
        actionOnTap: () {
          Navigator.pop(context);
          function();
        },
      )
    );
  }
}

class MyDialog extends StatefulWidget {
  MyDialog({
    this.title,
    required this.child,
    required this.mainAxisSize,
    required this.crossAxisAlignment
  });

  final String? title;
  final Widget child;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  
  @override
  State<StatefulWidget> createState() => MyDialogState();
}

class MyDialogState extends State<MyDialog> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeInOutCirc);

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
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                mainAxisSize: widget.mainAxisSize,
                crossAxisAlignment: widget.crossAxisAlignment,
                children: <Widget>[
                  widget.title == null ? Container() : Column(
                    children: <Widget>[
                      Text(widget.title?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      SizedBox(height: 10.0,),
                    ],
                  ),
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

class MyActionDialog extends StatelessWidget {
  MyActionDialog({
    required this.title,
    required this.body,
    required this.buttonText,
    required this.actionOnTap
  });

  final String title;
  final String body;
  final String buttonText;
  final VoidCallback actionOnTap;

  @override
  Widget build(BuildContext context) {
    return MyDialog(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(body),
          SizedBox(height: 5.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: actionOnTap,
                child: Text(buttonText),
              ),
            ],
          ),
        ],
      ),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}

class MyBottomSheet extends StatelessWidget {
  MyBottomSheet({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: Container(),
            ),
          )
        ],
      ),
    );
  }
}