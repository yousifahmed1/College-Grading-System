import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'midterm.dart';

class GradeTablePage extends StatefulWidget {
  final String groupCourse;
  final String group_id;
  final String username;
  final String gname;

  GradeTablePage({
    required this.groupCourse,
    required this.group_id,
    required this.username,
    required this.gname,


  });

  @override
  _GradeTablePageState createState() => _GradeTablePageState();
}

class _GradeTablePageState extends State<GradeTablePage> {
  List<Map<String, dynamic>> gradeData = [];

  @override
  void initState() {
    super.initState();
    fetchGradeData();
  }

  Future<void> fetchGradeData() async {
    var url = Uri.parse("http://192.168.1.88/cgs/viewgrade.php");

    var response = await http.post(url, body: {
      'groupCourse': widget.groupCourse,
      'groupid': widget.group_id,
    });

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      setState(() {
        gradeData = List<Map<String, dynamic>>.from(data);
      });
    } else {
      // Handle errors
      print('Failed to load grade data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(), // Add smooth physics

        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(height: 70,),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>midtermPage(username: widget.username,groupCourse: widget.groupCourse, group_id: widget.group_id,gname:widget.gname),
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
                SizedBox(height: 5,),
                Text("Midterm Grades\nTable",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: 'Somarsans-ExtraBold',
                  ),
                ),
                SizedBox(height: 25,),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(), // Add smooth physics

                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DataTable(
                      dividerThickness: 0, // Set dividerThickness to 0 to remove borders

                      columns: <DataColumn>[
                        DataColumn(label: Text('Student Name', style: TextStyle(color: Colors.white,fontFamily: 'Somarsans-bold',))),
                        DataColumn(label: Text('Student ID', style: TextStyle(color: Colors.white,fontFamily: 'Somarsans-bold',))),
                        DataColumn(label: Text('Grade', style: TextStyle(color: Colors.white,fontFamily: 'Somarsans-bold',))),
                      ],
                      rows: gradeData.map((row) {
                        return DataRow(cells: <DataCell>[
                          DataCell(Text(row['std_name'].toString(), style: TextStyle(color: Colors.white,fontFamily: 'Somarsans-bold',))),
                          DataCell(Text(row['std_id'].toString(), style: TextStyle(color: Colors.white,fontFamily: 'Somarsans-bold',))),
                          DataCell(Text(row['grade'].toString(), style: TextStyle(color: Colors.white,fontFamily: 'Somarsans-bold',))),

                        ]);
                      }).toList(),
                      headingRowColor: MaterialStateColor.resolveWith((states) => Color(0xFF171717)),

                    ),
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

