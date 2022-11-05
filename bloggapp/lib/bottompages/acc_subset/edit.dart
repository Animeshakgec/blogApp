import 'dart:io';

import 'package:bloggapp/NetworkHandler.dart';
import 'package:bloggapp/bottompages/acc_subset/mainprofile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class edit extends StatefulWidget {
  const edit({Key? key}) : super(key: key);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  final networkHandler = NetworkHandler();
  bool circular = false;
  late PickedFile _imageFile;
  TextEditingController _name = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _about = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text("Edit your Profile"),
          name(),
          SizedBox(
            height: 20,
          ),
          profession(),
          SizedBox(
            height: 20,
          ),
          dob(),
          SizedBox(
            height: 20,
          ),
          title(),
          SizedBox(
            height: 20,
          ),
          about(),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              setState(() {
                circular = true;
              });
              Map<String, String> data = {
                "name": _name.text,
                "profession": _profession.text,
                "DOB": _dob.text,
                "titleline": _title.text,
                "about": _about.text,
              };
              var response =
                  await networkHandler.patch("/profile/update", data);
              if (response.statusCode == 200 || response.statusCode == 201) {
                if (_imageFile != null) {
                  var imageResponse = await networkHandler.patchImage(
                      "/profile/add/image", _imageFile.path);
                  if (imageResponse.statusCode == 200) {
                    setState(() {
                      circular = false;
                    });
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MainProfile()),
                        (route) => false);
                  }
                } else {
                  setState(() {
                    circular = false;
                  });
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MainProfile()),
                      (route) => false);
                }
              }
            },
            child: circular
                ? CircularProgressIndicator()
                : Center(
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget imageProfile() {
    final file = File(_imageFile.path);
    return Center(
      child: Stack(children: <Widget>[
        Image(image: AssetImage('graphics/background.png')),
        CircleAvatar(
          radius: 80.0,
          // backgroundImage:_imageFile == null?AssetImage('assets/dp.png'): FileImage(File((_imageFile.path))),),
          backgroundImage: AssetImage('assets/dp.png'),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource s) async {
    final pickedFile = await _picker.pickImage(source: s);
    setState(() {
      _imageFile = pickedFile as PickedFile;
    });
  }

  Widget name() {
    return TextFormField(
      controller: _name,
      validator: (value) {
        if (value!.isEmpty) return "Name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(Icons.person, color: Colors.green),
        labelText: "Name",
        helperText: "user can't be empty",
        hintText: "Enter Name",
      ),
    );
  }

  Widget profession() {
    return TextFormField(
      controller: _profession,
      validator: (value) {
        if (value!.isEmpty) return "profession can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(Icons.person, color: Colors.green),
        labelText: "Profession",
        helperText: "profession can't be empty",
        hintText: "Enter Profession",
      ),
    );
  }

  Widget dob() {
    return TextFormField(
      controller: _dob,
      validator: (value) {
        if (value!.isEmpty) return "Name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(Icons.person, color: Colors.green),
        labelText: "Date Of Birth ",
        helperText: "date of birth in form of dd/mm/yyyy",
        hintText: "Enter Date Of Birth",
      ),
    );
  }

  Widget title() {
    return TextFormField(
      controller: _title,
      validator: (value) {
        if (value!.isEmpty) return "Name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(Icons.person, color: Colors.green),
        labelText: "Titlename ",
        helperText: "Titlename can't be empty",
        hintText: "Enter Titlename",
      ),
    );
  }

  Widget about() {
    return TextFormField(
      controller: _about,
      validator: (value) {
        if (value!.isEmpty) return "Name can't be empty";

        return null;
      },
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(Icons.person, color: Colors.green),
        labelText: "About",
        helperText: "aboutcan't be empty",
        hintText: "Enter about",
      ),
    );
  }
}
