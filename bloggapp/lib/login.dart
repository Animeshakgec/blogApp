import 'package:bloggapp/signIN.dart';
import 'package:bloggapp/signUP.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<Offset> animation1;
  late AnimationController _controller2;
  late Animation<Offset> animation2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller1 = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    animation1 = Tween<Offset>(
      begin: Offset(0.0, 3.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller1, curve: Curves.bounceOut));
    _controller2 = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );
    animation2 = Tween<Offset>(
      begin: Offset(0.0, 6.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.bounceOut));
    _controller1.forward();
    _controller2.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.cyan,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.white, Colors.cyan],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated,
          )),
          child: Column(
            children: <Widget>[
              SlideTransition(
                position: animation1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 50.0,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
              ),
              SlideTransition(
                position: animation1,
                child: Text(
                  'We Missed You',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.black87,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              SizedBox(
                height: 90.0,
              ),
              SlideTransition(
                position: animation1,
                child: Text(
                  'To connected with us please login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.black87,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              box("assets/google.png", "Signup with Google", null),
              SizedBox(
                height: 10.0,
              ),
              box("assets/facebook.png", "Signup with Facebook", null),
              SizedBox(
                height: 10.0,
              ),
              box("assets/email.png", "Signup with Email", emailclick),
              SlideTransition(
                position: animation2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have Account ",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => signin()));
                      },
                      child: Text(
                        "  SignIN",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.blue.shade600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  emailclick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => signup(),
    ));
  }

  Widget box(String path, String text, onclick) {
    return SlideTransition(
      position: animation2,
      child: InkWell(
        onTap: onclick,
        child: Container(
          height: 65,
          width: MediaQuery.of(context).size.width - 50,
          child: Card(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    path,
                    height: 40,
                    width: 40,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
