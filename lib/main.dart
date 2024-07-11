// ignore_for_file: use_super_parameters, avoid_unnecessary_containers, camel_case_types, unnecessary_import

import 'dart:ffi';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'profile.dart';
import 'updatefriend.dart';
import 'friend_profile.dart';
import 'loginPage.dart' as login;
import 'singUppage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print, prefer_typing_uninitialized_variables, duplicate_ignore, prefer_const_literals_to_create_immutables

void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MaterialApp(theme: ThemeData(), initialRoute: '/',routes: {
    '/home': (context) => MyApp(),
    '/': (context) => login.Loginpage(),
    '/singup':(context) =>singUppage(),
  }));// 홈 페이지 경로를 추가합니다.:},));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, String>> results =
  [];
  var tab = 0;
  var hello;
  var userImage;


  List<Contact> peoplelist = [];

  primalystack(i) {
    setState(() {
      if (i == 1) {
        print('정상');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getPermission();

  }


  getPermission() async {
    //핸드폰에서 연락처 불러오기

    var status = await Permission.contacts.request();
    if (status.isGranted) {
      print('허락됨');
      var contacts = await ContactsService.getContacts(); // 데이터 불러오기
      setState(() {
        peoplelist = contacts;
      });
      int i = 0;
      while (i < peoplelist.length) {
        var fullname  = (peoplelist[i].familyName ?? '') + '' + (peoplelist[i].givenName ?? '');

        i++;
      }
    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading : false,
        backgroundColor: Colors.black,
        title: Text('친구',
            style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w900)),
        actions: [
          Icon(
            Icons.search,
            size: 30,
            color: Colors.grey,
          ),
          SizedBox(width: 10),
          Icon(
            Icons.person_add,
            size: 30,
            color: Colors.grey,
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {
                getPermission();
                print(peoplelist);
              },
              icon: Icon(Icons.abc)),
        ],
      ),
      // ignore: avoid_unnecessary_containers

      // 카톡 메인
      body: [
        Container(
            child: Container(
                height: double.infinity,
                color: Colors.black,
                child: Row(
                  children: [
                    Flexible(
                        flex: 4,
                        child: ListView(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 5.0),
                          children: [
                            Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                                color: Color.fromARGB(255, 32, 32, 32),
                              ),
                              child: Row(
                                children: [
                                  Padding(padding: EdgeInsets.only(left: 10.0)),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        color:
                                        Color.fromARGB(255, 160, 160, 160),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text(
                                      '알림',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    '포트폴리오 전용 ',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            myprofile(
                              primalystack: primalystack,userImage: userImage
                            ),
                            updatefriend(),
                            myprofile2(userImage: userImage
                            ),
                          ],
                        ))
                  ],
                ))),
      ][tab],

      bottomNavigationBar: bottomAppbar(primalystack: primalystack),
    );
  }
}

// 내 프로필
class myprofile extends StatefulWidget {
  myprofile({
    super.key,
    this.primalystack,this.userImage
  });
  var primalystack;
  var userImage;
  @override
  State<myprofile> createState() => _myprofileState();
}

class _myprofileState extends State<myprofile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (c) {
          return profileEdit();
        }));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color.fromARGB(255, 28, 28, 28)))),
        padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(padding: EdgeInsets.only()),
            Container(
                padding: EdgeInsets.only(right: 40),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28.0),
                      child: Container(
                        width: 70,
                        height: 70,
                        color: Colors.blueAccent,
                        child: Image.asset('assets/profile.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      padding: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            login.Username,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                          Text('합격이냐 불합격이냐',
                              overflow: TextOverflow.ellipsis, // 줄 바꿈 없이 잘라냄
                              style: TextStyle(
                                color: Color.fromARGB(255, 99, 99, 99),
                                fontSize: 13,
                              ))
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
              width: 100,
              height: 27,
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.9),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: FittedBox(
                fit: BoxFit.contain,
                child: ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () async {
                      var picker = ImagePicker();
                      var image = await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        setState((){
                          widget.userImage = File(image.path);
                        });
                      }else{
                        setState(() {

                          widget.userImage = null;
                        });
                      }

                    },
                    child: Text(
                      '멀티프로필 +',
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class myprofile2 extends StatelessWidget {
  myprofile2({super.key, this.userImage,});


  final userImage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (c) {
          return friendEdit();
        }));
      },
      child: Container(
        color: Colors.black,
        width: double.infinity,
        padding: EdgeInsets.only(
          bottom: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: EdgeInsets.only(right: 40),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.blueAccent,
                        child: Image.asset(
                          'assets/profile.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      padding: EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '우진',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                color: Colors.white,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      color: Colors.white,

                      //child: Image.asset('assets/'),
                      child: userImage != null? Image.file(userImage) : Image.asset('assets/profile.jpg' ,fit: BoxFit.cover,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class bottomAppbar extends StatelessWidget {
  bottomAppbar({
    Key? key,
    this.primalystack,
  }) : super(key: key);

  var primalystack;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (i) {
        //getnew();
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Color.fromARGB(255, 120, 120, 120),
          ),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
            color: Color.fromARGB(255, 120, 120, 120),
          ),
          label: '채팅',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.forum,
            color: Color.fromARGB(255, 120, 120, 120),
          ),
          label: '오픈채팅',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_bag,
            color: Color.fromARGB(255, 120, 120, 120),
          ),
          label: '샵',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.more_vert,
            color: Color.fromARGB(255, 120, 120, 120),
          ),
          label: '샵',
        ),
      ],
      selectedItemColor:
      Colors.amber[800], // Set the color of the selected item
      // Set the color of unselected items
    );
  }
}
