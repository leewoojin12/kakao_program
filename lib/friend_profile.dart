// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors_in_immutables, camel_case_types, depend_on_referenced_packages

// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print, prefer_typing_uninitialized_variables, duplicate_ignore, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'Msgchat.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loginPage.dart' as login;


class friendEdit extends StatelessWidget {
  friendEdit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(1),
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), // 투명도를 조정하여 명암 조절
                  BlendMode.darken,
                ),
                image: AssetImage(
                  'assets/profileedit.jpg',
                ),
                fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.only(top: 50, left: 0, bottom: 0, right: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.white,
                      )),
                  Container(
                      width: 150,
                      margin: EdgeInsets.only(right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.gift,
                                color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.calendarCheck,
                                color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.settings, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      )),
                ],
              )),
              SizedBox(
                width: 10,
                height: 430 ,
                child: Container(
                  width: 20,
                ),
              ),
              Container(
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          width: 120,
                          height: 120,
                          color: Colors.blueAccent,
                          child: Image.asset(
                            'assets/profile.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        login.friendlist[0],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(' ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15)),
                    ],
                  )),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.white, width: 0.3))),
                child: Container(
                  padding: EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (c) {
                                  return Msgchat();
                                }));
                              },
                              icon: Icon(Icons.chat),
                            ),
                            Text(
                              '1:1 채팅',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ]));
  }
}
