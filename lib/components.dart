import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
Widget bar (String txt){
  return Container(

    decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(23),
        boxShadow: [
          BoxShadow(
          color: Colors.white.withOpacity(0.01),
          offset: Offset(4.0,4.0),
          blurRadius: 26,
          spreadRadius: 0
        ),
          BoxShadow(
              color: Colors.white.withOpacity(0.01),
              offset: Offset(-4.0,-4.0),
              blurRadius: 26,
              spreadRadius: 0
          ),


        ]
    ),

    child: TextFormField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 22,top: 19,bottom: 19),
          border: InputBorder.none,
          hintText: txt,
          hintStyle: TextStyle(
            fontSize: 17,
            color: Color(0xff606060),
            fontWeight: FontWeight.bold,
          )
      ),
    ),
  );
}
Widget btn (context , String label,Widget page) {
  return InkWell (
    onTap: () {
      // Handle button tap here
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page));

    },
    child: Container(
      height: 52,
      width: 178,
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(39),
      ),
      child: Center(
        child: Text(
            label, style: TextStyle(
          color: Colors.black,
            fontWeight:FontWeight.w700,
          fontSize: 19
        ),
        ),
      ),
    ),
  );
}

Widget g_cnt (String txt,TextEditingController controller){
  return Container(
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
        controller: controller,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Somarsans-Medium',
            fontSize: 17// Change this to the desired text color
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 22,top: 19,bottom: 19),
          border: InputBorder.none,
          hintText: txt,
          hintStyle: TextStyle(
            fontFamily: 'Somarsans-Medium',
            fontSize: 15,
            color: Color(0xff3E3E3E),
          ),
        ),
      ),
    ),
  );

}

Widget g_btn(String txt){
  return Container(
    height: 43,
    width: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(39),
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
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Somarsans-bold',
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    ),
  );
}