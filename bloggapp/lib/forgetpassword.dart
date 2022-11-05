import 'dart:convert';

import 'package:bloggapp/Homepage.dart';
import "package:flutter/material.dart";

import '../NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class forgetpassword extends StatefulWidget {
  const forgetpassword({Key? key}) : super(key: key);

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Form(
          key: _globalkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                usernameTextField(),
                SizedBox(
                  height: 15,
                ),
                passwordTextField(),
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () async {
                    Map<String, String> data = {
                      "password": _passwordController.text
                    };
                    print("/user/update/${_usernameController.text}");
                    var response = await networkHandler.patch(
                        "/user/update/${_usernameController.text}", data);

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      print("/user/update/${_usernameController.text}");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => homepage()),
                          (route) => false);
                    } else {
                      SnackBar(
                        content: Text("error in password change"),
                      );
                    }

                    // login logic End here
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff00A86B),
                    ),
                    child: Center(
                      child: circular
                          ? CircularProgressIndicator()
                          : Text(
                              "Update Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                // Divider(
                //   height: 50,
                //   thickness: 1.5,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget usernameTextField() {
    return Column(
      children: [
        Text("Username"),
        TextFormField(
          controller: _usernameController,
          validator: (value) {
            if (value!.isEmpty) return "Username can't be empty";

            return null;
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget passwordTextField() {
    return Column(
      children: [
        Text("Password"),
        TextFormField(
          controller: _passwordController,
          validator: (value) {
            if (value!.isEmpty) return "Password can't be empty";
            if (value.length < 6)
              return "Password must contains at least 6 digits";
            return null;
          },
          obscureText: vis,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
            helperStyle: TextStyle(
              fontSize: 14,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
        )
      ],
    );
  }
}
