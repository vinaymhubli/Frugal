import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:money_mangaer/views/mhome.dart'; 
class MoneyHome extends StatefulWidget {
  MoneyHome({Key? key}) : super(key: key);

  @override
  State<MoneyHome> createState() => _MoneyHomeState();
}

class _MoneyHomeState extends State<MoneyHome> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5),(){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MHome()));
    });
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/money.json"),
            SizedBox(height: 100),
            Text("Frugal",style: GoogleFonts.adamina(fontSize: 38,color:Color.fromARGB(255, 5, 43, 141),fontWeight: FontWeight.bold),),
            SizedBox(height: 29.0,),
            CircularProgressIndicator(color: Colors.orange,)
          ],
        ),
    );
  }
}