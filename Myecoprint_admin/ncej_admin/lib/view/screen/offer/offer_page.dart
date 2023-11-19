// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ncej_admin/controller/offer.dart';
import 'package:ncej_admin/core/app_export.dart';
import 'package:ncej_admin/data/module/offer.dart';

class GetAllOffersPage extends StatefulWidget {
  const GetAllOffersPage({super.key});

  @override
  _GetAllOffersPageState createState() => _GetAllOffersPageState();
}

class _GetAllOffersPageState extends State<GetAllOffersPage> {
  List<Offer> offers = [];
 late int ?id;
  @override
  void initState() {
    super.initState();
    fetchOffers();
  }

  Future<void> fetchOffers() async {
    try {
      List<Offer> fetchedOffers = await OfferController().getAll();

      setState(() {
        offers = fetchedOffers;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching offers: $e");
      }
    }
  }
Future<void> deleteOffer(int index) async {
  try {
    final offer = offers[index];
    if (offer.id != null) {
      await OfferController().deleteOffer(offers[index].id!);
      setState(() {
        offers.removeAt(index);
      });
      if (kDebugMode) {
        print('Offer deleted successfully.');
      }
    } else {
      if (kDebugMode) {
        print('Offer or Offer ID is null.');
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to delete Offer. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  } catch (error) {
    if (kDebugMode) {
      print('Error deleting Offer: $error');
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Failed to delete Offer. Please try again later.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: buildAppBar( context),
    body: ListView.builder(
      itemCount: offers.length,
      itemBuilder: (context, index) {
        final offer = offers[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(offer.offerNameEnglish),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Offer Name (Arabic): ${offer.offerNameArabic}'),
                Text('Description: ${offer.offerDescription}'),
                Text('Start Date: ${offer.offerStartDate.toString()}'),
                Text('End Date: ${offer.offerEndDate.toString()}'),
                Text('Number of Points: ${offer.numberPoint.toString()}'),
                Text('Number of Discount: ${offer.numberDiscount.toString()}'),
                Text('Discount: ${offer.offerDiscount.toString()}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                 showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  title: const Text('Remove Offer'),
                                                  content: const Text('Are you sure you want to remove this Offer?'),
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
                                                       deleteOffer(index);
                                                      },
                                                      child: const Text('Remove'),
                                                    ),
                                                  ],
                                                ),
                                              );
      }),
              ],
            ),
          ),
        );
      },
    ),
  );
}}

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
      title: AppbarTitle(text: "lbl60".tr),
    );
  }