import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:money_mangaer/views/homepage.dart';
import 'package:money_mangaer/views/mhome.dart';

import '../widgets/google_text.dart';


class GoogleSignin extends StatefulWidget {
  GoogleSignin({Key? key}) : super(key: key);

  @override
  State<GoogleSignin> createState() => _GoogleSigninState();
}

class _GoogleSigninState extends State<GoogleSignin> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe2e7ef),

     body: StreamBuilder<User?>(    
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if(snapshot.hasData){
         return MoneyHome();
        }
        if(snapshot.connectionState==ConnectionState.waiting){
         return CircularProgressIndicator();
        }
        return Container(
          
          child: Column(
            children: [
              Lottie.asset('assets/google.json',width: 600,height: 500),
              Center(
                child:  FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  onPressed: ()async{
                    final newuser= await _googleSignIn.signIn();
                    final googleauth=await newuser!.authentication;
                    final creds= GoogleAuthProvider.credential(accessToken:googleauth.accessToken ,idToken:googleauth.idToken );
                    await FirebaseAuth.instance.signInWithCredential(creds);
                  },
                  
                 label: Google(context),
                ),
              ),
            ],
          ),
        );
      },
     ), 
    );
  }

 
}