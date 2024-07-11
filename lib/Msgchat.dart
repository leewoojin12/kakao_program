

// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors_in_immutables, camel_case_types, depend_on_referenced_packages

// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print, prefer_typing_uninitialized_variables, duplicate_ignore, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'loginPage.dart' as login;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';



class Msgchat extends StatefulWidget {
  Msgchat({super.key});

  @override
  State<Msgchat> createState() => _MsgchatState();
}

class _MsgchatState extends State<Msgchat> {
  List<String> chat = [];

  final TextEditingController TextEdit = TextEditingController();

  String inputText = ' ';

  @override
  void initState() {
    super.initState();
  }

  void _sendMessage() {
    final text = TextEdit.text.trim();
    if (text.isNotEmpty) {
      FirebaseFirestore.instance.collection('chatRooms').doc(login.Username).collection('messages').add({
        'text': text,
        'sender': login.Username, // Spring Boot에서 받아온 사용자 ID 또는 닉네임을 사용
        'timestamp': Timestamp.now(),
      });
      TextEdit.clear();
    }
  }




  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('hayde')),
        body: Container(
          color: Colors.grey,
          width: double.infinity,
          height: double.infinity,
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chatRooms')
                  .doc(login.Username)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if(!snapshot.hasData){
                  return Center(child: Text('No data available'));

                }
                final chatDocs = snapshot.data!.docs;
                return ListView.builder(
                    reverse: true,
                    itemCount: chatDocs.length,
                    itemBuilder: (ctx, index) {
                      bool isMe = chatDocs[index]['sender'] ==
                          login.Username; // 사용자 ID 비교

                      if(index == null ) {

                      }else{
                        return Align(
                          alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              chatDocs[index]['text'],
                              style: theme.textTheme.bodyLarge!
                                  .copyWith(color: theme.colorScheme.onPrimary),
                            ),
                          ),
                        );
                      }


                    });
              }),
        ),
        bottomNavigationBar: Padding(
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              width: double.infinity,
              height: 50,
              color: Colors.pink,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEdit,
                      decoration: InputDecoration(
                        hintText: 'Enter your message',
                      ),

                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        _sendMessage();
                        /*setState(() { 일단 둔거 chat << 여기 list 에 입력된거 저장
                          chat.add(TextEdit.text);
                        });*/
                      },
                      icon: Icon(Icons.send)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          print(chat);
                        });
                      },
                      icon: Icon(Icons.abc)),
                ],
              )),
        ));
  }
}


