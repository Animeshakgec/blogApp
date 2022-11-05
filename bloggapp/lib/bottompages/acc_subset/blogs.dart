import 'package:bloggapp/NetworkHandler.dart';
import 'package:bloggapp/bottompages/acc_subset/blog.dart';
import 'package:bloggapp/bottompages/acc_subset/blogwidget.dart';
import 'package:bloggapp/models/SuperModel.dart';
import 'package:bloggapp/models/addBlogModel.dart';
import 'package:flutter/material.dart';

class Blogs extends StatefulWidget {
  Blogs({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  NetworkHandler networkHandler = NetworkHandler();
  Welcome welcome = Welcome(data: []);
  List<AddBlogModel> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get(widget.url);
    final welcome = Welcome.fromJson(response);
    setState(() {
      data = welcome.data.cast<AddBlogModel>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? Column(
            children: data
                .map((item) => Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Blog(
                                          addBlogModel: item,
                                          networkHandler: networkHandler,
                                        )));
                          },
                          child: BlogCard(
                            addBlogModel: item,
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                      ],
                    ))
                .toList(),
          )
        : Center(
            child: Text("We don't have any Blog Yet"),
          );
  }
}
