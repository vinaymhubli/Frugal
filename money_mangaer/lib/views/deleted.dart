import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_mangaer/views/mhome.dart';
class Deleted extends StatefulWidget {
  Deleted({Key? key}) : super(key: key);

  @override
  State<Deleted> createState() => _DeletedState();
}

class _DeletedState extends State<Deleted> {
  @override
  void initState() {
     Future.delayed(Duration(seconds: 3),(){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MHome()));
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Lottie.asset("assets/deleted.json",width: 500,height: 500),
      ),
    );
  }
}