import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'attend.dart';
import 'assigment.dart';
import 'components.dart';
import 'groups.dart';
import 'midterm.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';


class FunctionalityPage extends StatelessWidget {
  final String username;
  final String groupCourse;
  final String group_id;
  final String gname;


  FunctionalityPage({
    required this.username,
    required this.groupCourse,
    required this.group_id,
    required this.gname,


  });
  void _downloadReport(BuildContext context) async {
    var url = Uri.parse('http://192.168.1.88/cgs/report.php');
    var response = await http.post(url,body: {
      'groupCourse': groupCourse,
      'groupid': group_id,
    });

    if (response.statusCode == 200) {
      var documentDirectory = await getApplicationDocumentsDirectory();
      File file = File('${documentDirectory.path}/report.xls');
      file.writeAsBytesSync(response.bodyBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Report downloaded to Desktop')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download report')),
      );
    }
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>GroupsPage(username: username),
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
              SizedBox(
                height: 40,
              ),
              Text(
                gname,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Somarsans-bold',
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AttendancePage(username: username,groupCourse: groupCourse,group_id: group_id,gname: gname),
                          ),
                        );

                      },
                      child: cont("Attendance")
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => midtermPage(username: username,groupCourse: groupCourse,group_id: group_id,gname: gname),
                          ),
                        );

                      },
                      child: cont("Midterm"),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssigmentPage(username: username,groupCourse: groupCourse,group_id: group_id,gname: gname ),
                          ),
                        );

                      },
                      child: cont("Assignment"),
                    ),
                    SizedBox(height: 70),

                    InkWell(
                      onTap: () {
                        _downloadReport(context);
                      },
                      child: g_btn("Download Report"),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFunctionalityTap(BuildContext context, String functionality) {
    // Implement specific logic for each functionality
    // For example, you can navigate to a new page for each functionality
    // You can pass the 'username' to the new page if needed

    // Example navigation:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SpecificFunctionalityPage(
          username: username,
          functionality: functionality,
        ),
      ),
    );
  }
}

class SpecificFunctionalityPage extends StatelessWidget {
  final String username;
  final String functionality;

  SpecificFunctionalityPage({
    required this.username,
    required this.functionality,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$functionality Page'),
      ),
      body: Center(
        child: Text(
          'Welcome, $username!\nYou are on the $functionality page.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

Widget cont (String txt){
return  Container(
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
        Text(txt,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'SomarSans-SemiBold',
          ),

        ),
      ],
    ),
  ),
);

}