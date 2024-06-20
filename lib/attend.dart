import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'components.dart';
import 'func.dart';
import 'viewattend.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';

class AttendancePage extends StatefulWidget {

  final String groupCourse;
  final String group_id;
  final String username;
  final String gname;


  AttendancePage({
    required this.groupCourse,
    required this.group_id,
    required this.username,
    required this.gname,

  });

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  TextEditingController studentIdController = TextEditingController();
  String selectedWeek = 'w1'; // Set default to 'w1'
  String selectedCourse = ''; // Set default to an empty string
  List<String> weeks = List.generate(15, (index) => 'w${index + 1}'); // Generate weeks from w1 to w15

  @override
  void initState() {
    super.initState();
  }

  Future<void> submitAttendance() async {
    var url = Uri.parse("http://192.168.1.88/cgs/attend.php");

    var response = await http.post(url, body: {
      "student_id": studentIdController.text,
      "week": selectedWeek,
      'groupCourse': widget.groupCourse,
      "groupid" : widget.group_id,
    });

    if (response.statusCode == 200) {
      // Show success notification
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 'success') {
        Flushbar(
          messageText: Text(
            'Submitted Successfully',
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
        print('Attendance submitted successfully');
        // Handle success case
      }
      else if (jsonResponse['status'] == 'no') {
        Flushbar(
          messageText: Text(
            "Student Doesn't Exist In This Section",
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
        print('Attendance submitted successfully');
        // Handle success case
      }
      else if (jsonResponse['status'] == 'none') {
        Flushbar(
          messageText: Text(
            'Enter Student ID',
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
        print('Attendance submitted successfully');
        // Handle success case
      }
      else {
        Flushbar(
          messageText: Text(
            "Student Doesn't Exists",
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
        print('Failed to submit attendance');
        print('Error: ${jsonResponse['message']}');
        // Handle failure case
      }

      // Process the response as needed
    } else {
      // Handle errors
      print('Server error: ${response.statusCode}');
      // Handle server error
      // Handle errors
    }
  }

  Future<void> deleteAttendance() async {
    var url = Uri.parse("http://192.168.1.88/cgs/delete_attend.php");

    var response = await http.post(url, body: {
      "student_id": studentIdController.text,
      "week": selectedWeek,
      'groupCourse': widget.groupCourse,
      "groupid" : widget.group_id,
    });

    if (response.statusCode == 200) {
      // Show success notification
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 'success') {
        Flushbar(
          messageText: Text(
            'Deleted Successfully',
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
        // Handle success case
      }
      else if (jsonResponse['status'] == 'no') {
        Flushbar(
          messageText: Text(
            "Student Doesn't Exist In This Section",
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
        // Handle success case
      }
      else if (jsonResponse['status'] == 'none') {
        Flushbar(
          messageText: Text(
            'Enter Student ID',
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
        // Handle success case
      }
      else {
        Flushbar(
          messageText: Text(
            "Student Doesn't Exists",
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
        print('Failed to submit attendance');
        print('Error: ${jsonResponse['message']}');
        // Handle failure case
      }

      // Process the response as needed
    } else {
      // Handle errors
      print('Server error: ${response.statusCode}');
      // Handle server error
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(), // Add smooth physics
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>FunctionalityPage(username: widget.username,groupCourse: widget.groupCourse ,group_id:widget.group_id,gname:widget.gname  ),
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
                Text("Attendance Section",
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
                    Container(
                      width: 341,
                      height: 69,
                      decoration: BoxDecoration(
                        color: Color(0xFF171717),
                        borderRadius: BorderRadius.circular(23),
                        shape: BoxShape.rectangle,
                        border: GradientBoxBorder(
                          gradient: LinearGradient(colors: [Color(0xFF0F4C75),Color(0xFF3282B8)]),
                          width: 2.0,  // Adjust stroke width as needed
                        ),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: studentIdController,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Somarsans-Medium',
                              fontSize: 17// Change this to the desired text color
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 22,top: 19,bottom: 19),
                            border: InputBorder.none,
                            hintText: "Enter Student ID",
                            hintStyle: TextStyle(
                              fontFamily: 'Somarsans-Medium',
                              fontSize: 15,
                              color: Color(0xff3E3E3E),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 341,
                      height: 69,
                      decoration: BoxDecoration(
                        color: Color(0xFF171717),
                        borderRadius: BorderRadius.circular(23),
                        shape: BoxShape.rectangle,
                        border: GradientBoxBorder(
                          gradient: LinearGradient(colors: [Color(0xFF0F4C75),Color(0xFF3282B8)]),
                          width: 2.0,  // Adjust stroke width as needed
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Center(
                          child: DropdownButtonFormField<String>(
                            value: selectedWeek,
                            onChanged: (value) {
                              setState(() {
                                selectedWeek = value!;
                              });
                            },
                            items: weeks.map((week) {
                              return DropdownMenuItem<String>(
                                value: week,
                                child: Text(week,
                                  style: TextStyle(
                                    color: Colors.white
                                  ),

                                ),
                              );
                            }).toList(),
                            dropdownColor: Color(0xFF171717), // Set the dropdown menu background color to black
                            decoration: InputDecoration(
                              hintText: 'Select Week',
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    InkWell(
                      onTap: () {
                        submitAttendance();
                      },
                      child: g_btn("Submit Attendance"),
                    ),
                    SizedBox(height: 20),

                    InkWell(
                      onTap: () {
                        deleteAttendance();
                      },
                      child: g_btn("Delete Attendance"),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewAttendancePage(username: widget.username,groupCourse: widget.groupCourse,group_id: widget.group_id ,gname:widget.gname),
                          ),
                        );
                      },
                      child: g_btn("Show Attendance"),
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

