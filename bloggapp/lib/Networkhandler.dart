import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  String baseurl = "http://192.168.43.179:8000";
  // var baseurl = "https://www.google.co.in";
  var log = Logger();
  // Future get(String url) async {
  //   var urrl = (baseurl + url);
  //   // var response = await http.get(Uri.parse(url));
  //   // print('Response status: ${response.statusCode}');
  //   // print('Response body: ${response.body}');
  //   var response = await http.get(Uri.parse(urrl));
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     log.i(response.body);
  //     return json.decode(response.body);
  //   }
  //   // print('Response status: ${response.statusCode}');
  //   log.i(response.body);
  //   log.i(response.statusCode);
  // }
  FlutterSecureStorage storage = FlutterSecureStorage();
  Future get(var u) async {
    final url = Uri.parse(baseurl + u);
    var token = await storage.read(key: "token");
    var response = await http.get(
      url,
      headers: {"Authorization": "this is my token$token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(var url, Map<String, String> body) async {
    var token = await storage.read(key: "token");
    var response = await http.post(Uri.parse(baseurl + url),
        headers: {
          "Content-type": "application/json",
          "Authorization": "this is my token$token"
        },
        body: json.encode(body));
    return response;
  }
  // var response = await http.get(Uri.https(url));
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');

  // print(await http.read(Uri.https(url)));
  // String compurl(String url){
  //   return (baseurl+url);
  // }
  Future<http.StreamedResponse> patchImage(var url, String filepath) async {
    var token = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH', Uri.parse(baseurl + url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "this is my token$token"
    });
    var response = request.send();
    return response;
  }

  Future<http.Response> patch(var url, Map<String, String> body) async {
    var token = await storage.read(key: "token");
    var response = await http.patch(Uri.parse(baseurl + url),
        headers: {
          "Content-type": "application/json",
          "Authorization": "this is my token$token"
        },
        body: json.encode(body));
    return response;
  }

  Future<http.Response> post1(String url, var body) async {
    var token = await storage.read(key: "token");
    log.d(body);
    var response = await http.post(
      Uri.parse(baseurl + url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "this is my token$token"
      },
      body: json.encode(body),
    );
    return response;
  }

  NetworkImage getImage(String username) {
    var url = Uri.parse(baseurl + "/uploads//$username.jpg") as String;
    return NetworkImage(url);
  }
}
