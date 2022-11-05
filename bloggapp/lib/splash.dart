import 'dart:async';
import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  startTimer() {
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.of(context).pushReplacementNamed('/login');
    Navigator.of(context).pushReplacementNamed('/Homepage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan.shade200,
        body: Center(
          child: Container(
            child: Image.asset("assets/bp.png"),
          ),
        ));
  }
}
