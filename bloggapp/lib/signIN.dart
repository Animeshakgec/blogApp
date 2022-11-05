import 'dart:convert';

import 'package:bloggapp/Homepage.dart';
import 'package:bloggapp/NetworkHandler.dart';
import 'package:bloggapp/forgetpassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class signin extends StatefulWidget {
  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  bool v = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final storage = new FlutterSecureStorage();
  String errmsg = "       ";
  bool validate = false;
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.cyan.shade200,
          // body: Container(
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Colors.cyan.shade300],
          //       begin: FractionalOffset(0.0, 1.0),
          //       end: FractionalOffset(0.0, 1.0),
          //       stops: [0.0, 1.0],
          //       tileMode: TileMode.repeated,
          //     ),
          //   ),
          child: Form(
            key: _globalkey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign in with email',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  user(),
                  password(),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        circular = true;
                      });
                      Map<String, String> data = {
                        "username": usernamecontroller.text,
                        "password": passwordcontroller.text,
                      };
                      var response =
                          await networkHandler.post("/user/login", data);
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        Map<String, dynamic> output =
                            json.decode(response.body);
                        print(output["token"]);
                        await storage.write(
                            key: "token", value: output["token"]);
                        setState(() {
                          validate = true;
                          circular = false;
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => homepage()),
                            (route) => false);
                      } else {
                        String output = json.decode(response.body);
                        setState(() {
                          circular = false;
                          errmsg = output;
                          validate = false;
                        });
                      }
                    },
                    child: circular
                        ? const CircularProgressIndicator()
                        : Container(
                            width: 150.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "SignIN",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => forgetpassword()));
                        },
                        child: const Text(
                          "Forget Password",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Ubuntu",
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget user() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text("Username"),
          TextFormField(
            controller: usernamecontroller,
            // validator: (value)
            // {
            //   if(value!.isEmpty) {
            //     return "username can't be empty";
            //   }
            //   return null;
            // },
            decoration: InputDecoration(
              errorText: validate ? null : errmsg,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget password() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            const Text("Password"),
            TextFormField(
              controller: passwordcontroller,
              obscureText: v,
              decoration: InputDecoration(
                errorText: validate ? null : errmsg,
                suffixIcon: IconButton(
                  icon: Icon(v ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      v = !v;
                    });
                  },
                ),
                helperText: "password at least more than 6 digits",
                helperStyle: const TextStyle(
                  fontSize: 16,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
