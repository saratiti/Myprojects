// // ignore_for_file: library_private_types_in_public_api

// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_eco_print/controller/user.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/view/screen/%20points/collecting_points/collecting_points.dart';
import 'package:my_eco_print/view/screen/user/delete_account_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/module/user.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController personalnameController = TextEditingController();
  TextEditingController emailaddressController = TextEditingController();
  TextEditingController phonenumberoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordplacehoController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isCheckmarkVisible = false;
  bool isVisiblePassword = false;
  bool isVisiblePassword2 = false;
  String _profilePicture = "";
  String _newProfilePicture = "";
  File? _selectedImage;
  List<User> users = []; 
  @override
  void initState() {
    super.initState();
    getUserData();
  }

 Future<void> getUserData() async {
    try {
      final user = await UserController().getUser();
      personalnameController.text = user.fullName;
      emailaddressController.text = user.email;
      phonenumberoneController.text = user.phone;
      usernameController.text = user.username;
      
      setState(() {
        _profilePicture = user.image;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
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

  Future<void> selectProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _profilePicture = pickedImage.path;
      });
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

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
        appBar: buildAppBar(context),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
  
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 43.v),
      child: SizedBox(
        height: 1000.v,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.topCenter,
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
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.h),
                child: buildProfilePicture(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 45.h, vertical: 150.v),
                child: buildForm(context),
              ),
            ),
     Align(
  alignment: Alignment.bottomCenter,
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 50.h, vertical: 100.v),
    child: deleteAccount(context),
  ),
)

        ],
        ),
      ),
    );
  }

  Widget buildProfilePicture() {
    return GestureDetector(
      onTap: _handleShowOptions,
      child: Container(
        width: 150,
        height: 150,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 75,
              backgroundColor: appTheme.gray400,
              backgroundImage: _selectedImage != null
                  ? Image.file(_selectedImage!).image
                  : _profilePicture.isNotEmpty
                      ? NetworkImage(_profilePicture)
                      : null,
              child: _selectedImage == null && _profilePicture.isEmpty
                  ? Icon(
                      Icons.person,
                      size: 75,
                      color: appTheme.gray100,
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
                    color: appTheme.lightGreen500,
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
      UserController().uploadImage(_selectedImage!).then((value) {
        EasyLoading.dismiss();
        setState(() {
          _profilePicture = value;
        });
         SharedPreferences.getInstance().then((prefs) {

      });
      EasyLoading.showSuccess(value);
        EasyLoading.showSuccess(value);
      }).catchError((ex) {
        EasyLoading.dismiss();
        EasyLoading.showError(ex.toString());
      });
    } else {
      EasyLoading.showError("Not Supported");
    }
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
            controller: personalnameController,
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
            controller: emailaddressController,
            margin: EdgeInsets.only(
              left: 7.h,
              top: 3.v,
              right: 8.h,
            ),
            hintText: emailaddressController.text.tr,
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
            controller: phonenumberoneController,
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
void handleSubmitAction() {
  if (_formKey.currentState!.validate()) {
    EasyLoading.show(status: "Loading");
    UserController()
        .update(
          email: emailaddressController.text,
          password: passwordplacehoController.text,
          username: usernameController.text, 
          image: _newProfilePicture,
          fullName: personalnameController.text,
          profilePicture: '',
          phone: phonenumberoneController.text, 
        )
        .then((value) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Done");
          getUserData();
        })
        .catchError((error) {
          EasyLoading.dismiss();
          EasyLoading.showError(error.toString());
          if (kDebugMode) {
            print("Error: $error");
          }
        });
  }
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
                handleSubmitAction();
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
    // showDeleteAccountDialog(context);
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
}

CustomAppBar buildAppBar(BuildContext context) {
 final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return CustomAppBar(
      height: 50.v,
      leadingWidth: 40.h,
      leading: CustomImageView(
              svgPath: (textDirection == TextDirection.rtl)
                  ? ImageConstant.imgArrowright
                  : ImageConstant.imgArrowleftOnprimary,
              height: 24.0,
              width: 24.0,
              margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
              onTap: () => onTapArrowleft(context),
            ),
      centerTitle: true,
      title: AppbarTitle(text: "msg34".tr),
    );
  }