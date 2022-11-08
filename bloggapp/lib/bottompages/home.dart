import 'package:bloggapp/bottompages/acc_subset/blogs.dart';
import 'package:bloggapp/bottompages/acc_subset/otherblogs.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.cyan.shade300,
        appBar: AppBar(
            title: Text(
              "Blog App",
              style: TextStyle(
                  fontFamily: "Ubuntu", fontSize: 20.0, color: Colors.black),
            ),
            backgroundColor: Colors.cyan.shade100),
        body: otherblogs(),
      ),
    );
  }
}
