// ignore_for_file: library_private_types_in_public_api

import 'dart:io';



import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';


class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
   TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordplacehoController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool isLoading=false;
  bool isCheckmarkVisible = false;
  bool isVisiblePassword = false;
  bool isVisiblePassword2 = false;
  List<User> users = []; 
  @override
  void initState() {
    super.initState();
  
    getUserData();
  }

   Future<void> getUserData() async {
    try {
      final user = await UserController().getUser();
      fullNameController.text = user.fullName;
      emailController.text = user.email;
      phoneController.text = user.phone;
     // usernameController.text = user.username;
      
    
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
  }
  File? _selectedImage;

  final ApiHelper _apiHelper = ApiHelper();

Future<void> _updateProfile() async {
  try {
    var data = {
      'username': usernameController.text,
      'email': emailController.text,
      'full_name': fullNameController.text,
      'phone': phoneController.text,
    };

   
    setState(() {
      isLoading = true;
    });

    await _apiHelper.putRequest('api/users/updateProfile', data);

    if (_selectedImage != null) {
      await _uploadProfilePicture();
    }

    setState(() {
      isLoading = false;
    });

    if (kDebugMode) {
      print('Profile updated successfully');
    }
  } catch (e) {
    setState(() {
      isLoading = false;
    });
    if (kDebugMode) {
      print('Error updating profile: $e');
    }
  }
}


  Future<void> _uploadProfilePicture() async {
  try {
    String imageUrl = await _apiHelper.uploadProfilePicture(_selectedImage!);
    if (kDebugMode) {
      print('Profile picture uploaded successfully: $imageUrl');
    }
    
    Provider.of<UserProfileModel>(context, listen: false).updateProfilePicture(imageUrl);
  } catch (e) {
    if (kDebugMode) {
      print('Error uploading profile picture: $e');
    }
  }
}
  void toggleCheckmark() {
    setState(() {
      isCheckmarkVisible = !isCheckmarkVisible;
    });
  }

  void toggleIconEye() {
    setState(() {
      isVisiblePassword = !isVisiblePassword;
    });
  }

  void toggleIVisibleEye() {
    setState(() {
      isVisiblePassword2 = !isVisiblePassword2;
    });
  }
Future<void> _pickImageFromCamera() async {
  final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
  if (pickedFile != null) {
    setState(() {
      _selectedImage = File(pickedFile.path);
    });
  }
}

Future<void> _pickImageFromGallery() async {
  final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _selectedImage = File(pickedFile.path);
    });
  }
}

Future<void> deleteUser() async {
  try {
    final user = await UserController().getUser();
    if (user.id != null) {
      await UserController().deleteUser(user.id!);
    Navigator.pushReplacementNamed(context, '/login'); 
      if (kDebugMode) {
        print('User deleted successfully.');
      }
     
    } else {
      if (kDebugMode) {
        print('User ID is null.');
      }
    
    }
  } catch (error) {
    if (kDebugMode) {
      print('Error deleting User: $error');
    }
   
  }
}
void showDeleteAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Account'),
        content: const Text('Are you sure you want to remove your Account?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteUser(); 
            },
            child: const Text('Remove'),
          ),
        ],
      );
    },
  );
}
  
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
      //  appBar: buildAppBar(context, "msg34"),
        body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                   
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: ClipOval(
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              )
                            : FutureBuilder(
                                future: _apiHelper.getProfilePicture(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    Uint8List imageData =
                                        snapshot.data as Uint8List;
                                    return Image.memory(
                                      imageData,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    );
                                  } else {
                                    return ClipOval(
                                      child: SizedBox(
                                        width: 150,
                                        height: 150,
                                       
                                        
                                      ),
                                    );
                                  }
                                },
                              ),
                      ),
                    ),
                    
                    Positioned(
                      right: 80,
                      bottom: 20, 
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text('Take a photo'),
                                      onTap: () {
                                        _pickImageFromCamera();
                                        Navigator.pop(context); 
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text('Choose from gallery'),
                                      onTap: () {
                                        _pickImageFromGallery();
                                        Navigator.pop(context); 
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                            ),
                            color: appTheme.deepOrange800,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                buildForm(context),
              ],
            ),
          ),
    ));
}
 
  void showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a photo'),
                onTap: () {
                  _pickImageFromCamera();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  _pickImageFromGallery();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextFormField(
            controller: fullNameController,
            hintText: "msg7".localized,
            labelText: "lbl5".localized,
        
          ),
          buildTextFormField(
            controller: emailController,
            hintText: "msg2".localized,
            labelText: "lbl5".localized,
           // icon: ImageConstant.imgCheckmark,
          ),
          buildTextFormField(
            controller: phoneController,
            hintText: "lbl6".localized,
            labelText: "lbl6".localized,
           // icon: ImageConstant.imgCall,
          ),
          buildTextFormField(
            controller: usernameController,
            hintText: "lbl6".localized,
            labelText: "lbl6".localized,
            //icon: ImageConstant.imgUser,
          ),
          buildPasswordFormField(
            controller: passwordplacehoController,
            hintText: "lblـ28".localized,
            labelText: "lblـ28".localized,
            //icon: ImageConstant.imgLock,
            toggleIcon: toggleIconEye,
            isVisible: isVisiblePassword,
          ),
          buildPasswordFormField(
            controller: confirmpasswordController,
            hintText: "lblـ29".localized,
            labelText: "lblـ29".localized,
           // icon: ImageConstant.imgLock,
            toggleIcon: toggleIVisibleEye,
            isVisible: isVisiblePassword2,
          ),
          CustomElevatedButton(
            text: "lblـ27".localized,
            onPressed: _updateProfile,
          ),
        ],
      ),
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
   
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText.localized,
          labelText: labelText.localized,
        
        ),
        onChanged: (value) {},
      ),
    );
  }

  Widget buildPasswordFormField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
   
    required VoidCallback toggleIcon,
    required bool isVisible,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        decoration: InputDecoration(
          hintText: hintText.localized,
          labelText: labelText.localized,
          suffixIcon: GestureDetector(
            onTap: toggleIcon,
            child: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        
        ),
        onChanged: (value) {},
      ),
    );
  }

  // Widget deleteAccount(BuildContext context) {
  //   return CustomElevatedButton(
  //     text: "lbl30_".localized,
  //     onTap: () {
  //     //   Navigator.push(
  //     //     context,
  //     //     MaterialPageRoute(builder: (context) => DeleteAccountForm()),
  //     //   );
  //     // },
  //     buttonStyle: CustomButtonStyles.fillRed,
  //   );
  // }
}