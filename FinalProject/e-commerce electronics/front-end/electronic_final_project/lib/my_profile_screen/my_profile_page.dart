import 'dart:io';
import 'package:electronic_final_project/model/user.dart';
import 'package:electronic_final_project/my_profile_screen/upload_image.dart';
import 'package:image_picker/image_picker.dart';

import 'package:electronic_final_project/controller/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyProfilePage extends StatefulWidget {
  MyProfilePage({Key? key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final _controllerUsername = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  User user = User(email: '', image:'', username: '');
  String _profilePicture = "";
  String _newProfilePicture = "";
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final user = await UserController().getUser();
    setState(() {
      _controllerUsername.text = user.username;
      _controllerEmail.text = user.email;
      _profilePicture = user.image;
    });
  }

  @override
  void dispose() {
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }
File? _file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder(
        future: UserController().getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _controllerUsername.text = snapshot.data!.username;
            _controllerEmail.text = snapshot.data!.email;
            return Center(
              child: Container(
                padding: EdgeInsets.only(left: 4, right: 4, top: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _handleShowOptions,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(158, 158, 158, 1),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
CircleAvatar(
  radius: 75,
  backgroundImage: _selectedImage != null
      ? Image.file(_selectedImage!).image
      : _profilePicture.isNotEmpty
          ? NetworkImage(_profilePicture)
          : null,
  child: _selectedImage == null && _profilePicture.isEmpty
      ? Icon(
          Icons.person,
          size: 75,
        )
      : null,
),

                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: _handleShowOptions,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 4,
                                        color: Colors.white,
                                      ),
                                      color: Colors.orangeAccent,
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _controllerUsername,
                        focusNode: _usernameFocus,
                        validator: (value) {
                          if (value == null || value.length < 2) {
                            return "The username is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_circle_rounded,
                              color: Colors.grey),
                          label: Text("Username",
                              style: TextStyle(color: Colors.grey)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                                color: _usernameFocus.hasFocus
                                    ? Colors.orange
                                    : Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _controllerEmail,
                        focusNode: _emailFocus,
                        validator: (value) {
                          if (!EmailValidator.validate(value!)) {
                            return "The email must be correct";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.email, color: Colors.grey),
                          label: Text("Email",
                              style: TextStyle(color: Colors.grey)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _controllerPassword,
                        focusNode: _passwordFocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          if (value.length < 7) {
                            return "The password must be strong";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.password, color: Colors.grey),
                          label: Text("Password",
                              style: TextStyle(color: Colors.grey)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _handleSubmitAction,
                          child: Text("Submit"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text("There are some certain errors"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _handleShowOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(12.0),
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose your method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              onTap: () {
                handleGetImageAction(context, ImageSource.gallery);
              },
              leading: const Icon(Icons.image),
              title: const Text("Gallery"),
            ),
            ListTile(
              onTap: () {
                handleGetImageAction(context, ImageSource.camera);
              },
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
            ),
          ],
        ),
      ),
    ).then((value) {
      if (_newProfilePicture.isNotEmpty) {
        setState(() {
          _profilePicture = _newProfilePicture;
        });
      
      }
    });
  }

  handleGetImageAction(BuildContext context, ImageSource selectedSource) async {
    if (Platform.isAndroid || Platform.isIOS) {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: selectedSource);
      Navigator.pop(context);
      setState(() {
        _selectedImage = File(image!.path);
        _newProfilePicture = image.path;
      });
      EasyLoading.show(status: "Loading");
      UserController().uploadImage(_selectedImage!)

          .then((value) {
        EasyLoading.dismiss();
        setState(() {
          _profilePicture = value;
        });
        EasyLoading.showSuccess(value);
      }).catchError((ex) {
        EasyLoading.dismiss();
        EasyLoading.showError(ex.toString());
      });
    } else {
      EasyLoading.showError("Not Supported");
    }
  }

void _handleSubmitAction() {
  if (_formKey.currentState!.validate()) {
    EasyLoading.show(status: "Loading");
    UserController()
        .update(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
          username: _controllerUsername.text,
          image: _newProfilePicture, 
        )
        .then((value) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Done");
      _loadUserData();
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    });
  }
}


}