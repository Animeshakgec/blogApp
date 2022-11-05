import 'package:bloggapp/bottompages/acc_subset/createprofile.dart';
import 'package:bloggapp/bottompages/acc_subset/mainprofile.dart';
import 'package:flutter/material.dart';

import '../../Networkhandler.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  NetworkHandler networkHandler = NetworkHandler();
  Widget page = CircularProgressIndicator();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkprofile();
  }

  void checkprofile() async {
    var response = await networkHandler.get("/profile/checkprofile");
    if (response["status"] == true) {
      setState(() {
        page = MainProfile();
      });
    } else {
      setState(() {
        page = button();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page,
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Tap to button to add profile data",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => createprofile()));
              },
              child: Center(
                child: Text(
                  "Add Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
