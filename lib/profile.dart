// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors_in_immutables, camel_case_types, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class profileEdit extends StatelessWidget {
  profileEdit({
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
                height: 400,
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
                        '우진',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text('합격이냐 불합격이냐',
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
                                onPressed: () {},
                                icon: Icon(Icons.chat)),
                            Text(
                              '나와의 채팅',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                )),
                            Text(
                              '프로필 편집',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                                color: Colors.white,
                                onPressed: () {},
                                icon: Icon(Icons.add_box)),
                            Text(
                              '펑 보관함',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      )
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
