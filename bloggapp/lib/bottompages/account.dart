import 'package:bloggapp/Homepage.dart';
import 'package:bloggapp/bottompages/acc_subset/blogs.dart';
import 'package:bloggapp/bottompages/acc_subset/profile.dart';
import 'package:bloggapp/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class account extends StatefulWidget {
  const account({Key? key}) : super(key: key);

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  final storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => profile()));
                },
                child: Text(
                  "Profile",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => Blogs(
                  //     url: "/blogpost/getownblog",
                  //   ),
                  // ));
                },
                child: Text(
                  "My Blogs",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  logout();
                },
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => login()), (route) => false);
  }
}
