import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasks/pages/home_page.dart';
import 'package:tasks/pages/login_page.dart';

void  main(List<String> args) async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
  class MyApp extends StatelessWidget {
    const MyApp({super.key});
  
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: "tasks",
        debugShowCheckedModeBanner: false,
        home: LoginPage(),

      );
    }
  }

