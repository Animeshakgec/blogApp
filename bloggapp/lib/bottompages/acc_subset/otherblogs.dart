import 'dart:convert';
import 'package:bloggapp/models/SuperModel.dart';
import 'package:flutter/material.dart';
import 'package:bloggapp/NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class otherblogs extends StatefulWidget {
  const otherblogs({super.key});

  @override
  State<otherblogs> createState() => _otherblogsState();
}

class _otherblogsState extends State<otherblogs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData("/blogs/getotherblogs");
  }

  NetworkHandler networkHandler = NetworkHandler();
  FlutterSecureStorage storage = FlutterSecureStorage();
  List<Supermodels> supermodel = [];
  String baseurl = "http://192.168.43.179:8000";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData("/blogs/getotherblogs"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: supermodel.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 330,
                    color: Colors.greenAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      Row(
                        children: [
                          Text('username', style: TextStyle(fontSize: 18)),
                          Text("${supermodel[index].username}")
                        ],
                      ),
                      Row(
                        children: [
                          Text("Title", style: TextStyle(fontSize: 18)),
                          Text(supermodel[index].title)
                        ],
                      ),
                      Row(
                        children: [
                          Text("Body", style: TextStyle(fontSize: 18)),
                          Text(supermodel[index].body)
                        ],
                      ),
                    ]),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  // Future<List<Supermodel>> get() async{
  //   final reponse=await http.get(Uri.parse(Uri.parse()))
  // }
  Future<List<Supermodels>> getData(String u) async {
    final url = Uri.parse(baseurl + u);
    var token = await storage.read(key: "token");
    var response = await http.get(
      url,
      headers: {"Authorization": "this is my token$token"},
    );
    var data = jsonDecode(response.body.toString());
    print(data);
    if (/*response.statusCode == 200 */ response.statusCode == 200 ||
        response.statusCode == 201) {
      print("connect");
      // print(response.body);
      for (Map<String, dynamic> index in data) {
        supermodel.add(Supermodels.fromJson(index));
      }
      print(supermodel);
      return supermodel;
    } else {
      return supermodel;
    }
  }
}
