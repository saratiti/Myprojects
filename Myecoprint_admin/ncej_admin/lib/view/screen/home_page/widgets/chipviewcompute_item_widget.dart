// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ncej_admin/controller/offer.dart';
import 'package:ncej_admin/core/app_export.dart';
import 'package:ncej_admin/data/module/offer.dart';

class ChipviewcomputeItemWidget extends StatelessWidget {
  const ChipviewcomputeItemWidget({Key? key}) : super(key: key);

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
                "lbl_20".tr,
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
                Navigator.of(context).pushNamed(AppRoutes.getAllOffers);
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
                "lbl20".tr,
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
  const MyDialog({super.key});

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController companyIdController = TextEditingController();
  final TextEditingController branchIdController = TextEditingController();
  final TextEditingController offerNameArabicController = TextEditingController();
  final TextEditingController offerNameEnglishController = TextEditingController();
  final TextEditingController offerDescriptionController = TextEditingController();
  final TextEditingController numberPointController = TextEditingController();
  final TextEditingController numberDiscountController = TextEditingController();
  final TextEditingController offerStartDateController = TextEditingController();
  final TextEditingController offerEndDateController = TextEditingController();
  final TextEditingController offerDiscountController = TextEditingController();

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedStartDate = picked;
        offerStartDateController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedEndDate = picked;
        offerEndDateController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

DateTime? parseDate(String dateText) {
  try {

    final dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.parse(dateText);
  } catch (e) {
    return null; 
  }
}
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
              ),
                TextFormField(
                controller: branchIdController,
                decoration: const InputDecoration(labelText: 'Branch ID'),
              ),
              TextFormField(
                controller: offerNameArabicController,
                decoration: const InputDecoration(labelText: 'Offer Name (Arabic)'),
              ),
              TextFormField(
                controller: offerNameEnglishController,
                decoration: const InputDecoration(labelText: 'Offer Name (English)'),
              ),
              TextFormField(
                controller: offerDescriptionController,
                decoration: const InputDecoration(labelText: 'Offer Description'),
              ),
              TextFormField(
                controller: numberPointController,
                decoration: const InputDecoration(labelText: 'Number of Points'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: numberDiscountController,
                decoration: const InputDecoration(labelText: 'Number of Discount'),
                keyboardType: TextInputType.number,
              ),
         TextFormField(
  controller: offerStartDateController,
  decoration: InputDecoration(
    labelText: 'Offer Start Date',
    suffixIcon: IconButton(
      onPressed: () => _selectStartDate(context),
      icon: const Icon(Icons.calendar_today),
    ),
  ),
),

              TextFormField(
                controller: offerEndDateController,
                decoration: InputDecoration(labelText: 'Offer End Date', suffixIcon: IconButton(
      onPressed: () => _selectEndDate(context),
      icon: const Icon(Icons.calendar_today),
    ),),
                
              ),
             
              TextFormField(
                controller: offerDiscountController,
                decoration: const InputDecoration(labelText: 'Offer Discount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
ElevatedButton(
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
int companyId = int.tryParse(companyIdController.text) ?? 0;
int branchId = int.tryParse(branchIdController.text) ?? 0;
String offerNameArabic = offerNameArabicController.text;
String offerNameEnglish = offerNameEnglishController.text;
String offerDescription = offerDescriptionController.text;
int numberPoint = int.tryParse(numberPointController.text) ?? 0;
double numberDiscount = double.tryParse(numberDiscountController.text) ?? 0;
DateTime? startDate = parseDate(offerStartDateController.text);
DateTime? endDate = parseDate(offerEndDateController.text);
double offerDiscount = double.tryParse(offerDiscountController.text) ?? 0.0;   
      if (startDate != null && endDate != null) {
        Offer offer = Offer(
          companyId: companyId,
          branchId:branchId,
          offerNameArabic: offerNameArabic,
          offerNameEnglish: offerNameEnglish,
          offerDescription: offerDescription,
          numberPoint: numberPoint,
          numberDiscount: numberDiscount,
          offerStartDate: startDate,
          offerEndDate: endDate,
          offerDiscount: offerDiscount,
        );

        try {
          await OfferController().createOffer(offer);
          if (kDebugMode) {
            print('Offer saved successfully.');
          }
          Navigator.of(context).pop();
        } catch (e) {
          if (kDebugMode) {
            print('Error saving offer: $e');
          }
        }
      }
    }
  },
  child: const Text('Save'),
),


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
