// ignore_for_file: use_super_parameters, avoid_unnecessary_containers, camel_case_types, unnecessary_import
// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print, prefer_typing_uninitialized_variables, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class people extends StatelessWidget {
  const people({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 0.0, right: 15),
        child: Column(
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
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                '이름',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }
}

class updatefriend extends StatelessWidget {
  const updatefriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text('업데이트한 프로필',
                style: TextStyle(
                    color: Color.fromARGB(255, 120, 120, 120),
                    fontSize: 12,
                    fontWeight: FontWeight.w100)),
          ),
          Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color.fromARGB(255, 28, 28, 28)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  people(),
                  people(),
                  people(),
                  people(),
                  people(),
                ],
              ))
          // ignore: avoid_unnecessary_containers
        ],
      ),
    );
  }
}
