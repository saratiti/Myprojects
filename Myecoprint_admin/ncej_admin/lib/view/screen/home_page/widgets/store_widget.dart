// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ncej_admin/controller/store.dart';
import 'package:ncej_admin/core/app_export.dart';
import 'package:ncej_admin/data/module/store.dart';

class StoreWidget extends StatelessWidget {
  const StoreWidget ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 190, 
            child: RawChip(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              showCheckmark: false,
              labelPadding: EdgeInsets.zero,
              label: Text(
                "lbl32_".tr,
                style: TextStyle(
                  color: appTheme.whiteA700,
                  fontSize: 16,
                  fontFamily: 'Bahij TheSansArabic',
                  fontWeight: FontWeight.w500,
                ),
              ),
              deleteIcon: SizedBox(
                height: 40,
                width: 40,
                child: CustomImageView(
                  svgPath: ImageConstant.imgComputer,
                  color: Colors.white,
                ),
              ),
              onDeleted: () {},
              selected: false,
              backgroundColor: appTheme.red700,
              selectedColor: appTheme.lightGreen500,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (value) {
                Navigator.of(context).pushNamed(AppRoutes.storePage);
              },
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 190, 
            child: RawChip(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10), 
              showCheckmark: false,
              labelPadding: EdgeInsets.zero,
              label: Text(
                "lbl31_".tr,
                style: TextStyle(
                  color: appTheme.whiteA700,
                  fontSize: 16, 
                  fontFamily: 'Bahij TheSansArabic',
                  fontWeight: FontWeight.w500,
                ),
              ),
              deleteIcon: SizedBox(
                height: 40,
                width: 40,
                child: CustomImageView(
                  svgPath: ImageConstant.imgFile,
                  color: Colors.white,
                ),
              ),
              onDeleted: () {},
              selected: false,
              backgroundColor: appTheme.lightGreen500,
              selectedColor: appTheme.lightGreen500,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
               onPressed: () {
               
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const MyDialog(); 
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog({Key? key}) : super(key: key);

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController companyIdController = TextEditingController();
  final TextEditingController typeIdController = TextEditingController();
  final TextEditingController storeNameArabicController = TextEditingController();
  final TextEditingController storeNameEnglishController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Offer'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: companyIdController,
                decoration: const InputDecoration(labelText: 'Company ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Company ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: typeIdController,
                decoration: const InputDecoration(labelText: 'Type ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Type ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: storeNameArabicController,
                decoration: const InputDecoration(labelText: 'Store Name (Arabic)'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Store Name (Arabic)';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: storeNameEnglishController,
                decoration: const InputDecoration(labelText: 'Store Name (English)'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Store Name (English)';
                  }
                  return null;
                },
              ),
            

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final nameArabic = storeNameArabicController.text;
                    final nameEnglish = storeNameEnglishController.text;
                    final typeId = int.tryParse(typeIdController.text) ?? 0;
                    final companyId = int.tryParse(companyIdController.text) ?? 0;

                     {
                      final store = Store(
                        nameArabic: nameArabic,
                        nameEnglish: nameEnglish,
                        typeId: typeId, companyId: companyId,
                       
                      );

                      try {
                        await StoreController().createStore(store);
                        if (kDebugMode) {
                          print('Store saved successfully.');
                        }
                        Navigator.of(context).pop();
                      } catch (e) {
                        if (kDebugMode) {
                          print('Error saving Store: $e');
                        }
                      }
                    }
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}