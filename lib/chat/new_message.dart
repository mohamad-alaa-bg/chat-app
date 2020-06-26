import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class NewMessage extends StatefulWidget {

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final List<String> char = ['a','b','c','d'];
  var isEnStart =true ;
  var isEnEnd  = true;
  var _enterMessage = '';
  final _controller = new TextEditingController();
  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'text': _enterMessage,
      'createdAt' : Timestamp.now(),
      'userId' : user.uid,
      'username' : userData['username'],
      'userImage' :userData['image_url'],
    });

      setState(() {
        _enterMessage =  '' ;
      });
      _controller.clear();


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              controller: _controller,
              maxLines: null,
             minLines: 1,

              textAlign: TextAlign.justify,
             // textDirection:isEnStart ? TextDirection.ltr: TextDirection.rtl,
             // textAlign: isEnEnd ?TextAlign.left : TextAlign.right,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                String firstLetter = value.substring(0,1);
                setState(() {
                  _enterMessage = value;


                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enterMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
