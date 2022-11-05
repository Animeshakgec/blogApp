import 'dart:io';

import 'package:bloggapp/Homepage.dart';
import 'package:bloggapp/login.dart';
import 'package:bloggapp/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = homepage();
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checklogin();
  }

  void checklogin() async {
    var token = await storage.read(key: "token");
    if (token != null) {
      setState(() {
        page = homepage();
      });
    } else {
      setState(() {
        page = login();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => splash(),
        // page ==login()?"/login": (context) => login():"/Homepage": (context) => homepage(),
        "/login": (context) => login(),
        // "/Homepage": (context) => homepage(),
        // "/login":(context)=>login(),
        // "/signIN":(context)=>signin(),
      },
    );
  }
}
