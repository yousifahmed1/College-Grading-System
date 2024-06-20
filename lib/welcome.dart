import 'package:flutter/material.dart';
import 'login.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),
      body: Center( // Center the entire body content
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(), // Add smooth physics
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontFamily: 'Somarsans-ExtraBold',
                ),
              ),
              SizedBox(
                width: 376,
                height: 376,
                child: Image(
                  image: AssetImage('assets/w_logo.png'),
                ),
              ),
              Text(
                "College Grading System",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Somarsans-ExtraBold',
                ),
              ),
              SizedBox(height: 60,),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
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
                        Color(0xFF3282B8),  // Second color
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Start Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SomarSans-SemiBold',
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
