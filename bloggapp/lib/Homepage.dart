import 'package:bloggapp/bottompages/account.dart';
import 'package:bloggapp/bottompages/add.dart';
import 'package:bloggapp/bottompages/home.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<Widget> l = [home(), add(), account()];
  Widget s = home();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade300,
      body: Center(
        child: s,
      ),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.cyan.shade300,
          animationDuration: Duration(milliseconds: 300),
          color: Colors.cyan.shade100,
          onTap: (index) {
            setState(() {
              s = l[index];
            });
          },
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
              size: 30.0,
            ),
            Icon(
              Icons.add,
              size: 30.0,
              color: Colors.white,
            ),
            Icon(
              Icons.account_box,
              size: 30.0,
              color: Colors.white,
            ),
          ]),
    );
  }
}
