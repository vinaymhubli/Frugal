import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_mangaer/views/google_sign.dart';
import 'package:money_mangaer/views/homepage.dart';
Future <void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  await Hive.initFlutter();
  await Hive.openBox('money');
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
 statusBarColor:  Color.fromARGB(255, 60, 83, 141),
 

 ));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
   @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'MONEY_MANAGER',
      theme: ThemeData(primaryColor: Color.fromARGB(255, 5, 43, 141),
      
      dialogBackgroundColor: Colors.grey.shade400
      
      ),
      home: GoogleSignin (),
    
    );
      }
 
   
  }
