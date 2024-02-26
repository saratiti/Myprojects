// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_eco_print/controller/api_helper.dart';
import 'package:my_eco_print/controller/user.dart';
import 'package:my_eco_print/controller/user_profile_provider.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/data/module/user.dart';
import 'package:my_eco_print/view/screen/user/delete_account_form.dart';
import 'package:my_eco_print/view/widgets/app_bar/appbar.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
      usernameController.text = user.username;
      
    
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

    print('Profile updated successfully');
  } catch (e) {
    setState(() {
      isLoading = false;
    });
    print('Error updating profile: $e');
  }
}


  Future<void> _uploadProfilePicture() async {
  try {
    String imageUrl = await _apiHelper.uploadProfilePicture(_selectedImage!);
    print('Profile picture uploaded successfully: $imageUrl');
    
    Provider.of<UserProfileModel>(context, listen: false).updateProfilePicture(imageUrl);
  } catch (e) {
    print('Error uploading profile picture: $e');
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
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child:Scaffold(
    appBar: buildAppBar(context,"msg34"),
    body: isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                   
                    Container(
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
                                    return CircularProgressIndicator();
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
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                       
                                        child: Center(
                                          child: CustomImageView(
                                            svgPath: ImageConstant.imgFingerprint,
                                            height: 100, 
                                            width: 100,
                                            alignment: Alignment.center,
                                          ),
                                        ),
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
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.camera_alt),
                                      title: Text('Take a photo'),
                                      onTap: () {
                                        _pickImageFromCamera();
                                        Navigator.pop(context); 
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.photo_library),
                                      title: Text('Choose from gallery'),
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
                            color: appTheme.lightGreen500,
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
                buildBody(context),
              ],
            ),
          ),
    ));
}


  Widget buildForm(BuildContext context) {
    return Form(
      
      key: _formKey,
      child:   Stack(children: [
      Positioned.fill(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: 22.v,
                right: 28.h,
              ),
              child: Text(
                "lbl5".tr,
                style: CustomTextStyles.titleSmallBahijTheSansArabicPrimary,
              ),
            ),
          ),
          CustomTextFormField(
            controller: fullNameController,
            margin: EdgeInsets.only(
              left: 7.h,
              top: 3.v,
              right: 8.h,
            ),
            hintText: "msg7".tr,
            suffix: Container(
              margin: EdgeInsets.fromLTRB(10.h, 13.v, 20.h, 12.v),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.h,
                ),
              ),
              child: CustomImageView(
                svgPath: ImageConstant.imgUser,
              ),
            ),
            suffixConstraints: BoxConstraints(
              maxHeight: 45.v,
            ),
            contentPadding: EdgeInsets.only(
              left: 30.h,
              top: 11.v,
              bottom: 11.v,
            ), onChanged: (email) {  },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: 22.v,
                right: 28.h,
              ),
              child: Text(
                "msg2".tr,
                style: CustomTextStyles.titleSmallBahijTheSansArabicPrimary,
              ),
            ),
          ),
          CustomTextFormField(
            controller: emailController,
            margin: EdgeInsets.only(
              left: 7.h,
              top: 3.v,
              right: 8.h,
            ),
            hintText: emailController.text.tr,
            suffix: Container(
              margin: EdgeInsets.fromLTRB(10.h, 12.v, 20.h, 13.v),
              child: CustomImageView(
                svgPath: ImageConstant.imgCheckmark,
              ),
            ),
            suffixConstraints: BoxConstraints(
              maxHeight: 45.v,
            ),
            contentPadding: EdgeInsets.only(
              left: 30.h,
              top: 11.v,
              bottom: 11.v,
            ), onChanged: (email) {  },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: 22.v,
                right: 28.h,
              ),
              child: Text(
                "lbl6".tr,
                style: CustomTextStyles.titleSmallBahijTheSansArabicGray400,
              ),
            ),
          ),
          CustomTextFormField(
            controller: phoneController,
            margin: EdgeInsets.only(
              left: 7.h,
              top: 3.v,
              right: 8.h,
            ),
            hintText: "lbl6".tr,
            suffix: Container(
              margin: EdgeInsets.fromLTRB(10.h, 13.v, 20.h, 12.v),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.h,
                ),
              ),
              child: CustomImageView(
                svgPath: ImageConstant.imgCall,
              ),
            ),
            suffixConstraints: BoxConstraints(
              maxHeight: 45.v,
            ),
            contentPadding: EdgeInsets.only(
              left: 30.h,
              top: 11.v,
              bottom: 11.v,
            ), onChanged: (email) {  },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: 22.v,
                right: 28.h,
              ),
              child: Text(
                "lbl6".tr,
                style: CustomTextStyles.titleSmallBahijTheSansArabicGray400,
              ),
            ),
          ),
          CustomTextFormField(
            controller: usernameController,
            margin: EdgeInsets.only(
              left: 7.h,
              top: 3.v,
              right: 8.h,
            ),
            hintText: "lbl6".tr,
            suffix: Container(
              margin: EdgeInsets.fromLTRB(10.h, 13.v, 20.h, 12.v),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.h,
                ),
              ),
              child: CustomImageView(
                svgPath: ImageConstant.imgUser,
              ),
            ),
            suffixConstraints: BoxConstraints(
              maxHeight: 45.v,
            ),
            contentPadding: EdgeInsets.only(
              left: 30.h,
              top: 11.v,
              bottom: 11.v,
            ), onChanged: (email) {  },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: 22.v,
                right: 28.h,
              ),
              child: Text(
                "lblـ28".tr,
                style: CustomTextStyles.titleSmallBahijTheSansArabicPrimary,
              ),
            ),
          ),
          CustomTextFormField(
            controller: passwordplacehoController,
            margin: EdgeInsets.only(
              left: 7.h,
              top: 3.v,
              right: 8.h,
            ),
            hintText: "lblـ28".tr,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            prefix: GestureDetector(
              onTap: toggleIconEye,
              child: Container(
                margin: EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
                child: Icon(
                  isVisiblePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 45.v,
            ),
            obscureText: !isVisiblePassword,
            suffix: Container(
              margin: EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
              child: CustomImageView(
                svgPath: ImageConstant.imgLock,
              ),
            ), onChanged: (email) {  },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: 20.v,
                right: 28.h,
              ),
              child: Text(
                "lblـ29".tr,
                style: CustomTextStyles.titleSmallBahijTheSansArabicPrimary,
              ),
            ),
          ),
          CustomTextFormField(
            controller: confirmpasswordController,
            margin: EdgeInsets.only(
              left: 7.h,
              top: 3.v,
              right: 8.h,
            ),
            hintText: "lblـ29".tr,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            prefix: GestureDetector(
              onTap: toggleIVisibleEye,
              child: Container(
                margin: EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
                child: Icon(
                  isVisiblePassword2 ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 45.v,
            ),
            obscureText: !isVisiblePassword2,
            suffix: Container(
              margin: EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
              child: CustomImageView(
                svgPath: ImageConstant.imgLock,
              ),
            ),
            suffixConstraints: BoxConstraints(
              maxHeight: 45.v,
            ), onChanged: (email) {  },
          ),
        ],
      ))
    ]
    ) 
    );
    
  
  }


Widget deleteAccount(BuildContext context) {
  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 350.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 40.v),
            CustomElevatedButton(
              text: "lblـ27".tr,
              margin: EdgeInsets.only(
                left: 26.h,
                top: 250.v,
                right: 27.h,
              ),
              onTap: () {
                _updateProfile();
              },
             
            ),
            SizedBox(height: 40.v),
         CustomElevatedButton(
  text: "lbl30_".tr,
  margin: EdgeInsets.only(
    left: 80.h,  
    right: 80.h, 
  ),
  onTap: () {
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeleteAccountForm()),
    );
  },
  buttonStyle: CustomButtonStyles.fillRed,
)


          ],
        ),
      ),
    ],
  );
}



  Widget buildBody(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: 10),
    child: SizedBox(
      height: 1000.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Opacity(
            opacity: 0.1,
            child: CustomImageView(
              imagePath: ImageConstant.imgGroup70252,
              height: 200.v,
              width: 200.h,
              alignment: Alignment.bottomCenter,
            ),
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 50.h),
          //     child: buildProfilePicture(),
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.h, vertical: 20.v), 
              child: buildForm(context),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.h, vertical: 10.v),
              child: deleteAccount(context),
            ),
          ),
        ],
      ),
    ),
  );
}
}