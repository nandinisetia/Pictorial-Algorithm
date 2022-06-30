import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';

late final User user;
final _firestore = FirebaseFirestore.instance;
void main() {
  runApp(MaterialApp(
    home: chatscreen(),
  ));
}

class chatscreen extends StatefulWidget {
  const chatscreen({Key? key}) : super(key: key);

  @override
  _chatscreenState createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String message;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    try {
      user = await _auth.currentUser!;
      //   final uid = user.uid;
      if (user != null) {
        print(user.email);
      } else {}
    } catch (e) {
      print(e);
    }
  }

  void messageStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('FlashChat', style: TextStyle(fontSize: 22)),
            IconButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.exit_to_app_rounded))
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MessageStream(),
          Row(
            children: [
              Container(
                width: 338,
                child: TextField(
                    controller: messageTextController,
                    onChanged: (value) {
                      message = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: kmessagebox.copyWith(
                      hintText: "Enter Your Text",
                    )),
              ),
              IconButton(
                onPressed: () {
                  messageTextController.clear();
                  _firestore
                      .collection('messages')
                      .add({'text': message, 'sender': user.email});
                },
                icon: Icon(Icons.send_sharp),
                color: Colors.blueAccent.shade400,
              )
            ],
          )
        ],
      )),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ));
          }
          final messages = snapshot.data!.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final currentuser = user.email;
            if (currentuser == messageSender) {}
            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isme: currentuser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messageBubbles,
            ),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text, required this.isme});
  final String sender;
  final String text;

  final bool isme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.black38),
          ),
          SizedBox(height: 5),
          Material(
            elevation: 1,
            borderRadius: isme
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isme ? Colors.lightBlueAccent : Colors.white70,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 14, color: isme ? Colors.white : Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
