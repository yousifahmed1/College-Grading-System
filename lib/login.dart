// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:gradient_borders/gradient_borders.dart';
import 'package:another_flushbar/flushbar.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'groups.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.16/cgs/login.php'),
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );

    var data = json.decode(response.body);
    if (data == "Success") {
      // You can handle the response here, e.g., check for success or failure
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              GroupsPage(username: usernameController.text.toUpperCase()),
        ),
      );
      print('Login successful');
    } else {
      Flushbar(
        messageText: Text(
          "Invalid Data",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Somarsans-SemiBold',
          ),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        icon: Icon(
          Icons.error_rounded,
          color: Colors.white,
          size: 28,
        ),
      )
        ..show(context);
      // Handle errors
      print('Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(), // Add smooth physics
        scrollDirection: Axis.vertical,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 160,),
                Text(
                  "Log in",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 55,
                    fontFamily: 'Somarsans-ExtraBold',
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 55,),
                    Container(
                      width: 341,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Username",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Somarsans-Regular',
                                ),),
                            ],
                          ),
                          SizedBox(height: 3,),

                          Container(
                            width: 341,
                            height: 69,
                            decoration: BoxDecoration(
                              color: Color(0xFF171717),
                              borderRadius: BorderRadius.circular(23),
                              shape: BoxShape.rectangle,
                              border: GradientBoxBorder(
                                gradient: LinearGradient(colors: [
                                  Color(0xFF0F4C75),
                                  Color(0xFF3282B8)
                                ]),
                                width: 2.0, // Adjust stroke width as needed
                              ),
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: usernameController,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Somarsans-Medium',
                                    fontSize: 17 // Change this to the desired text color
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 22, top: 19, bottom: 19),
                                  border: InputBorder.none,
                                  hintText: "Enter your Username",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff3E3E3E),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25,),
                    Container(
                      width: 341,

                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Somarsans-Regular',
                                ),),
                            ],
                          ),
                          SizedBox(height: 3,),

                          Container(
                            width: 341,
                            height: 69,
                            decoration: BoxDecoration(
                              color: Color(0xFF171717),
                              borderRadius: BorderRadius.circular(23),
                              shape: BoxShape.rectangle,
                              border: GradientBoxBorder(
                                gradient: LinearGradient(colors: [
                                  Color(0xFF0F4C75),
                                  Color(0xFF3282B8)
                                ]),
                                width: 2.0, // Adjust stroke width as needed
                              ),
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true, // This line makes the text obscure
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Somarsans-Medium',
                                    fontSize: 17 // Change this to the desired text color
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 22, top: 19, bottom: 19),
                                  border: InputBorder.none,
                                  hintText: "Enter your password",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff3E3E3E),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 48,),
                    InkWell(
                      onTap: () {
                        _login();
                      },
                      child: Container(
                        width: 341,
                        height: 69,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF0F4C75), // First color
                              Color(0xFF3282B8), // Second color
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SomarSans-SemiBold',
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
