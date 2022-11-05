import 'dart:convert' show json;

import 'package:bloggapp/Homepage.dart';
import 'package:bloggapp/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool v = true;
  final _globalkey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
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
          child: Center(
            // child: : MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   decoratContainer(
            //   heightion: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [Colors.cyan.shade300],
            //       begin: const FractionalOffset(0.0, 1.0),
            //       end: const FractionalOffset(0.0, 1.0),
            //       stops: [0.0, 1.0],
            //       tileMode: TileMode.repeated,
            //     ),
            //   ),
            child: Form(
              key: _globalkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign up with email',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  user(),
                  email(),
                  password(),
                  SizedBox(height: 30.0),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        circular = true;
                      });
                      await checkuser();
                      if (_globalkey.currentState!.validate() && validate) {
                        Map<String, String> data = {
                          "username": usernamecontroller.text,
                          "email": emailcontroller.text,
                          "password": passwordcontroller.text
                        };
                        print(data);
                        var response =
                            await networkHandler.post("/user/register", data);
                        if (response.statusCode == 200 ||
                            response.statusCode == 201) {
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
                                MaterialPageRoute(
                                    builder: (context) => homepage()),
                                (route) => false);
                          } else {
                            SnackBar(content: Text("Network error"));
                          }
                        }
                        // networkHandler.get(" ");
                        setState(() {
                          circular = false;
                        });
                      } else {
                        setState(() {
                          circular = false;
                        });
                      }
                    },
                    child: circular
                        ? CircularProgressIndicator()
                        : Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "SignUP",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Ubuntu",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  checkuser() async {
    if (usernamecontroller.text.length == 0) {
      setState(() {
        validate = false;
        errmsg = "user can't be empty";
      });
    } else {
      var response = await networkHandler
          .get("/user/checkusername/${usernamecontroller.text}");
      if (response['status']) {
        setState(() {
          validate = false;
          errmsg = "user is already taken";
        });
      } else {
        setState(() {
          validate = true;
        });
      }
    }
  }

  Widget user() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text("Username"),
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
              focusedBorder: UnderlineInputBorder(
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

  Widget email() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text("Email"),
          TextFormField(
            controller: emailcontroller,
            validator: (value) {
              if (value!.isEmpty) return "Email can't be empty";
              if (!value.contains("@")) return "Email is Invalid";
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
      ),
    );
  }

  Widget password() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Text("Password"),
            TextFormField(
              controller: passwordcontroller,
              validator: (value) {
                if (value!.isEmpty) return "Password can't be empty";
                if (value.length < 6)
                  return "Password must contains at least 6 digits";
                return null;
              },
              obscureText: v,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(v ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      v = !v;
                    });
                  },
                ),
                helperText: "password at least more than 6 digits",
                helperStyle: TextStyle(
                  fontSize: 16,
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
        ),
      ),
    );
  }
}
