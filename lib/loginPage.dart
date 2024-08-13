// ignore_for_file: use_super_parameters, avoid_unnecessary_containers, camel_case_types, unnecessary_import
// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print, prefer_typing_uninitialized_variables, duplicate_ignore, prefer_const_literals_to_create_immutables\


library loginPage;

  import 'package:flutter/material.dart';
  import 'singUppage.dart';
  import 'package:http/http.dart' as http;
  import 'dart:async';
  import 'main.dart' as setmain;
  import 'dart:convert';

  String? sessionCookie;
  String Username= ' ';
  List<String> friendlist =[];

  class Loginpage extends StatefulWidget {
    Loginpage({super.key});


    @override
    State<Loginpage> createState() => _LoginpageState();
  }

  class _LoginpageState extends State<Loginpage> {
    final TextEditingController _nickController = TextEditingController();

    final TextEditingController _passController = TextEditingController();

    final TextEditingController _emailController = TextEditingController();

    var publicID ;


    @override
    Future<void> getUser() async {
      final url = Uri.parse('http://10.0.2.2:8080/members/getuser/');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
          print(response.body);
          final data =json.decode(response.body);
          String memberInfo = ' ';
          memberInfo = data;// 전체 JSON 응답 출력q


          print(memberInfo);
      } else {
        print('Failed to get user info: ${response.statusCode}');
      }
    }

    Future<void> deleteAllMembers() async {
      final url = Uri.parse('http://10.0.2.2:8080/members/members');

      final response = await http.delete(url);

      if (response.statusCode == 200) {
        // 성공적으로 삭제됨

        print("All members deleted successfully");
      } else {
        // 에러 발생
        throw Exception("Failed to delete members");
      }
    }

    Future<void> _login (BuildContext context) async {
      try {
        publicID = _nickController;
        print('시도합니다'); // 디버그 메시지 출력
        final response = await http.post(
          Uri.parse('http://10.0.2.2:8080/members/Login'), // Spring Boot API URL
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8', // JSON 형식으로 데이터 전송
          },
          body: jsonEncode(<String, String>{
            'nickname': _nickController.text, // 사용자명 값 설정
            'password': _passController.text, // 비밀번호 값 설정
          }),
        );

        // 응답 내용 확인

        if (response.statusCode == 200) {
          // 로그인 성공 처리
          String? rawCookie = response.headers['set-cookie'];
          if (rawCookie != null) {
            int index = rawCookie.indexOf(';');
            sessionCookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
            print("로그인 성공, 저장된 세션 쿠키: $sessionCookie");
          }
          setState(() {
            Username = _nickController.text;
            setmain.setfriend.add(response.body);
            friendlist = [response.body];
            print('친구이름 : $friendlist');



          });
          Navigator.pushNamed(context, '/home');

          print('로그인 완료');




        } else {
          // 서버에서 반환된 오류 메시지 표시
          String errorMessage;
          try {
            // JSON 디코딩 시도
            errorMessage = jsonDecode(response.body)['error'] ?? 'Unknown error';
          } catch (e) {
            // JSON 디코딩 실패 시 응답 본문 그대로 사용
            errorMessage = response.body;
          }

        }
      } catch (e) {
        print("Error: $e");
      }
    }

          Widget build(BuildContext context) {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.lightBlueAccent, Colors.pinkAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.lock_outline,
                          size: 100.0,
                          color: Colors.white,
                        ),
                        SizedBox(height: 50.0),
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'nickname',
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0,
                                horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ), controller: _nickController,
                        ),
                        SizedBox(height: 10.0),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0,
                                horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ), controller: _passController,
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            _login(context);
                            // 로그인 버튼 클릭 시 처리할 로직 작성
                          },
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            // primary 대신 backgroundColor 사용
                            padding: EdgeInsets.symmetric(vertical: 10.0,
                                horizontal: 80.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () {
                            deleteAllMembers();
                            // 비밀번호 찾기 클릭 시 처리할 로직 작성

                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/singup');
                            // 회원가입 클릭 시 처리할 로직 작성
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
  }

