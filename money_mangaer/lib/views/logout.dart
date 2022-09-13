import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:money_mangaer/views/google_sign.dart';
import 'package:money_mangaer/views/mhome.dart';
class Logout extends StatefulWidget {
  Logout({Key? key}) : super(key: key);

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
  }
  Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}
  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffe2e7ef),
     
     body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Lottie.asset('assets/logout.json'),
        Text('Do You Want To Logout ?',style: GoogleFonts.adamina(
          fontSize: 20,fontWeight:FontWeight.bold,
          color:Color.fromARGB(255, 5, 43, 141))),
          SizedBox(height: 30,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: ElevatedButton(
                    onPressed:(){
                    signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>GoogleSignin()));
                    
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
                ),
        Padding(
          padding: const EdgeInsets.only(right: 80),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MHome()));
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),
            child: Text(
              "No",
            ),
          ),
          
        ),

              ],
            ),
            
          )
      ],
      
     ),
     
    );
  }
}