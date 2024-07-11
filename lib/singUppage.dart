  // ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors_in_immutables, camel_case_types, depend_on_referenced_packages


  import 'package:flutter/material.dart';
  import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';
  import 'dart:async';
  import 'dart:io';


  class singUppage extends StatefulWidget {
    singUppage ({super.key});




    @override
    State<singUppage> createState() => _loginpageState();
  }
  var Alreadymember = '';

  class _loginpageState extends State<singUppage> {
    var inputDate =  TextEditingController();
    var inputText = '';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();


  /*  // 서버 연결 상태 확인차 hello
  Future<void> hello() async {
    try {
      print('시도합니다');
      final response = await http.get(Uri.parse('http://192.168.123.102:8081/members/hello')).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        print('성공: ${response.body}');
        setState(() {
          inputText = response.body;
        });
      } else {
        print('실패: ${response.statusCode}');
      }
    } on TimeoutException catch (_) {
      print('연결 시간 초과');
    } on SocketException catch (_) {
      print('연결 거부됨');
    } catch (e) {
      print('오류 발생: $e');
    }
  }
  */

    Future<void> _registerUser() async {
      try {
        print('시도합니다'); // 디버그 메시지 출력
        final response = await http.post(
          Uri.parse('http://10.0.2.2:8080/members/signUp/do'), // Spring Boot API URL  192.168.123.102
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8', // JSON 형식으로 데이터 전송
          },
          body: jsonEncode(<String, String>{
            'email': _emailController.text, // 이메일 값 설정
            'password': _passwordController.text, // 비밀번호 값 설정
            'username': _usernameController.text,
            'nickname': _nicknameController.text,



            // 사용자명 값 설정
          }),
        );


        if (response.statusCode == 200) {
          // 회원가입 성공 처리
          print(response.body);
          Navigator.pushNamed(context, '/');
        } else {
          Alreadymember = response.body;
          showDialog(
            context: context,
            builder: (context){

              return Dialog(

                child:Container(height: 50,width:50,
                  alignment: Alignment.center,
                  child: Text(Alreadymember),

                ),

              );
            },
          );


          print('Failed to register user: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (e) {
        print('Error occurred: $e'); // 예외 처리
      }
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('회원가입'),),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$inputText'),
              TextField(
                decoration: InputDecoration(labelText: 'username'),controller: _usernameController,onChanged: (text){setState(() {



                });}
              ),TextField(
                decoration: InputDecoration(labelText: 'nickname'),controller: _nicknameController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'password' ),controller: _passwordController,
              ),TextField(
                decoration: InputDecoration(labelText: 'email'),controller: _emailController,
              ),
               SizedBox(height: 20),
                ElevatedButton(
                onPressed: () {

                  _registerUser();






                }, child: Text('가입'),)

            ],
          ),
        )
        ,



      );




    }
  }

  class DialogUI extends StatelessWidget {
    DialogUI({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Dialog(
        child: Container(
          width: 300,
          height: 300,
          child: Column(
            children: [
              TextField(),
              TextButton( child: Text('완료'), onPressed:(){} ),
              TextButton(
                  child: Text('취소'),
                  onPressed:(){  })
            ],
          ),
        ),
      );
    }
  }
