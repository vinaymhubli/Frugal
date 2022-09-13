import 'package:flutter/material.dart';

Widget Google(BuildContext context){
  return RichText(
  text: TextSpan(
    text: 'Sign',
    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color.fromRGBO(219, 68, 55, 55)),
    
    children: const <TextSpan>[
      

      TextSpan(text: ' in', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color.fromARGB(250, 234, 156, 12))),
      TextSpan(text: ' with', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 15, 157, 88))),
      TextSpan(text: ' Google', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 66, 134, 244))),

      
    ],
  ),
);
}
