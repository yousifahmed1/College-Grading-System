import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'func.dart';
import 'login.dart';
import 'viewattend.dart';
import 'package:gradient_borders/gradient_borders.dart';


class GroupsPage extends StatefulWidget {
  final String username;

  GroupsPage({required this.username});

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  List<Map<String, dynamic>> groups = [];

  @override
  void initState() {
    super.initState();
    fetchGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 70,),
          SizedBox(
            width: 70,
            height: 70,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );

              },
              child: Image(
                image: AssetImage('assets/profile.png'),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Text('Welcome, ${widget.username}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'SomarSans-Bold',
            ),
          ),
          SizedBox(height: 55),
          Text("Select Section",
            style: TextStyle(
            color: Colors.white,
            fontSize: 37,
            fontFamily: 'SomarSans-Bold',
          )
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(), // Add smooth physics
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FunctionalityPage(
                          username: widget.username,
                          groupCourse: groups[index]['crs_id'],
                          group_id: groups[index]['g_id'],
                          gname : groups[index]['group_course']
                        ),
                      ),
                    );
                  },
                  //child: Text(groups[index]['group_course']),
                    child: Column(
                      children: [
                        Container(
                          width: 341,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Color(0xFF171717),
                            border: GradientBoxBorder(
                              gradient: LinearGradient(colors: [Color(0xFF0F4C75),Color(0xFF3282B8)]),
                              width: 2.0,  // Adjust stroke width as needed
                            ),
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child:Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text(groups[index]['group_course'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'SomarSans-SemiBold',
                                  ),

                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 11,),

                      ],
                    ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchGroups() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.88/cgs/groups.php'), // Replace with your actual PHP script URL
      body: {'username': widget.username},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        groups = List<Map<String, dynamic>>.from(data);
      });
    } else {
      throw Exception('Failed to load groups');
    }
  }
}
