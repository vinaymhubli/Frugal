import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_mangaer/views/deleted.dart';
showConfirmDialog(BuildContext context, String title, String content) async {
  return await showDialog(
    
    barrierColor: Color.fromARGB(255, 5, 43, 141).withOpacity(0.4),
    
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(  
        borderRadius: BorderRadius.circular(25)
      ),
      title: Text(title,style: GoogleFonts.adamina(fontSize: 23,color:Colors.black,fontWeight: FontWeight.bold),),
      content: Text(content),
      actions: [
        
        ElevatedButton(
         
          onPressed: () {
            Navigator.of(context).pop(true);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Deleted()));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Color.fromARGB(255, 143, 16, 7),


            ),
          ),
          
          child: Text(
            "YES",
          ),

        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),
          child: Text(
            "No",
          ),
        ),
      ],
    ),
  );
}