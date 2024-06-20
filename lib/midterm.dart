import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'components.dart';
import 'func.dart';
import 'viewgrade.dart';

class midtermPage extends StatefulWidget {

  final String groupCourse;
  final String group_id;
  final String username;
  final String gname;


  midtermPage({
    required this.groupCourse,
    required this.group_id,
    required this.username,
    required this.gname,

  });

  @override
  _midtermPageState createState() => _midtermPageState();
}

class _midtermPageState extends State<midtermPage> {
  TextEditingController studentIdController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  List<String> weeks = List.generate(15, (index) => 'w${index + 1}'); // Generate weeks from w1 to w15
  List<String> courseNames = []; // List to store course names

  @override
  void initState() {
    super.initState();
  }


  Future<void> submitGrade() async {
    var url = Uri.parse("http://192.168.1.88/cgs/midterm.php");

    var response = await http.post(url, body: {
      "student_id": studentIdController.text,
      "grade": gradeController.text,
      'groupCourse': widget.groupCourse,
      "groupid" : widget.group_id,

    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Debug print

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 'success') {
        Flushbar(
          messageText: Text(
            'Grade submitted successfully',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Somarsans-SemiBold',
            ),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
          borderRadius: BorderRadius.circular(8),
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 28,
          ),
        )..show(context);
        print('Grade submitted successfully');
      } else {
        String message;
        switch (jsonResponse['status']) {
          case 'no':
            message = "Student Doesn't Exist In This Section";
            break;
          case 'none':
            message = 'Enter Student ID';
            break;
          default:
            message = "Student Doesn't Exist";
            break;
        }
        Flushbar(
          messageText: Text(
            message,
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
        )..show(context);
        print('Error: ${jsonResponse['message']}');
      }
    } else {
      print('Server error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(), //
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>FunctionalityPage(username: widget.username,groupCourse: widget.groupCourse ,group_id:widget.group_id ,gname:widget.gname ),
                          ),
                        );

                      },

                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: Image(
                          image: AssetImage('assets/back.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25,),
                Text("Midterm\nSection",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: 'Somarsans-ExtraBold',
                  ),
                ),
                SizedBox(height: 50,),
                Column(
                  children: [
                    g_cnt("Enter Student ID",studentIdController),
                    SizedBox(height: 20),
                    g_cnt("Enter Grade",gradeController),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        submitGrade();
                      },
                      child: g_btn("Submit Grade"),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GradeTablePage(username:widget.username ,groupCourse: widget.groupCourse,group_id: widget.group_id ,gname:widget.gname),
                          ),
                        );
                      },
                      child: g_btn("Show Grade"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

