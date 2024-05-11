// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';


class UploadReceipt extends StatefulWidget {
  const UploadReceipt({Key? key}) : super(key: key);

  @override
  _UploadReceiptState createState() => _UploadReceiptState();
}

class _UploadReceiptState extends State<UploadReceipt> {
  bool _uploading = false;
  String _uploadMessage = '';
  File? _imageFile;

  Future<void> _uploadImage(File imageFile) async {
    setState(() {
      _uploading = true;
    });
    try {
      // Instantiate ApiHelper
      ApiHelper apiHelper = ApiHelper();
      
      // Upload image using ApiHelper
      String uploadResponse = await apiHelper.uploadInvoice(imageFile);
      
      // Update UI message
      setState(() {
        _uploadMessage = 'Upload successful: $uploadResponse';
      });
    } catch (error) {
      // Handle upload error
      setState(() {
        _uploadMessage = 'Error uploading: $error';
      });
    } finally {
      // Update UI state
      setState(() {
        _uploading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        setState(() {
          _imageFile = imageFile;
        });
        // Call _uploadImage method to upload the selected image
        await _uploadImage(imageFile);
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error picking image: $error");
      }
      setState(() {
        _uploadMessage = 'Error picking image: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 40.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      onTap: _uploading ? null : _pickImage,
                      child: DottedBorder(
                        color: appTheme.deepOrange800.withOpacity(0.43),
                        padding: const EdgeInsets.all(10.0),
                        strokeWidth: 2.0,
                        radius: const Radius.circular(10.0),
                        borderType: BorderType.RRect,
                        dashPattern: const [5, 5],
                        child: Container(
                          padding: const EdgeInsets.all(40.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _imageFile != null && _imageFile!.existsSync()
    ? Image.file(
        _imageFile!,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      )
    : CustomImageView(
        imagePath: ImageConstant.imgUploadIconPrimary,
        height: 100.0,
        width: 100.0,
      ),

                              const SizedBox(height: 20.0),
                              _uploading
                                  ? const CircularProgressIndicator()
                                  : RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Drag & drop files or ",
                                            style: CustomTextStyles.titleMediumMulishff0e0e0e,
                                          ),
                                          TextSpan(
                                            text: "Browse",
                                            style: CustomTextStyles.titleMediumMulishffd1512d.copyWith(
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                              const SizedBox(height: 20.0),
                              Text(
                                _uploadMessage.isNotEmpty
                                    ? _uploadMessage
                                    : "Supported formats: JPEG, PNG, PDF",
                                style: CustomTextStyles.bodyMediumInterGray60001,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                CustomElevatedButton(
                  height: 60.0,
                  text: "Continue",
                  buttonStyle: CustomButtonStyles.outlineBlue,
                  buttonTextStyle: CustomTextStyles.titleLargeWhiteA700,
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        elevation: 0,
        leadingWidth: 40.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appTheme.deepOrange800,
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
        title: const Text(
          "Upload Receipts",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
