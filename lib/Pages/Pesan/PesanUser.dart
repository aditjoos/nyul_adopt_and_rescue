import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/components/ContainerAndButtons.dart';

class PesanUser extends StatefulWidget {
  @override
  _PesanUserState createState() => _PesanUserState();
}

class _PesanUserState extends State<PesanUser> {

  late TextEditingController chatController;

  void sendChat() {
    setState(() {
      chatController = TextEditingController(text: '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(LineIcons.arrowLeft),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage('https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/66/66adceda7ade28d229597b106eda2735d15f8c27_full.jpg'),
                  ),
                  SizedBox(width: 10.0,),
                  Text('Felix Kohln', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          SizedBox(height: 15.0,),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                color: Color(0xFFFAFAFA),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ChatBox(
                      me: true,
                      chatText: 'Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.',
                    ),
                    SizedBox(height: 15.0,),
                    ChatBox(
                      me: false,
                      chatText: 'Lorem ipsum dolor sit amet.',
                    ),
                    SizedBox(height: 15.0,),
                    ChatBox(
                      me: true,
                      chatText: 'OK',
                    ),
                    SizedBox(height: 15.0,),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Colors.grey.shade300,
                  style: BorderStyle.solid
                )
              )
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black26,
                  width: 1.0
                ),
                borderRadius: BorderRadius.circular(25.0)
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: chatController,
                      style: TextStyle(fontFamily: 'Montserrat',),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                          hintText: "Ketik pesan...",
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.orange[400],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => sendChat(),
                          borderRadius: BorderRadius.circular(25.0),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Icon(LineIcons.paperPlane, color: Colors.white)
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatBox extends StatelessWidget {
  ChatBox({
    required this.me, 
    required this.chatText
  });

  final bool me;
  final String chatText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(width: me ? 30.0 : 0,),
        // me ? Expanded(child: SizedBox()) : SizedBox(width: 0,),
        Flexible(
          child: MyContainer(
            width: double.infinity,
            color: me ? Colors.orange.shade400 : Colors.white,
            child: Text(chatText, style: TextStyle(color: me ? Colors.white : Colors.black),),
            padding: EdgeInsets.all(10.0),
          ),
        ),
        SizedBox(width: !me ? 30.0 : 0,),
      ],
    );
  }
}