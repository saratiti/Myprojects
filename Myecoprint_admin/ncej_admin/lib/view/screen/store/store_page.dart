// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ncej_admin/controller/store.dart';
import 'package:ncej_admin/core/app_export.dart';
import 'package:ncej_admin/data/module/store.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List<Store> stores = [];
 late int ?id;
  @override
  void initState() {
    super.initState();
    fetchedStores();
  }

  Future<void> fetchedStores() async {
    try {
      List<Store> fetchedStores = await StoreController().getAll();

      setState(() {
        stores = fetchedStores;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching offers: $e");
      }
    }
  }
Future<void> deleteStore(int index) async {
  try {
    final store = stores[index];
    if (store.id != null) {
      await StoreController().deleteStore(stores[index].id!);
      setState(() {
        stores.removeAt(index);
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
      itemCount: stores.length,
      itemBuilder: (context, index) {
        final store= stores[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(store.nameArabic),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Store Name (Arabic): ${store.nameArabic}'),
               Text('Store Name (English): ${store.nameEnglish}'),
                Text('Type: ${store.typeId.toString()}'),
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
                                                       deleteStore(index);
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
      title: AppbarTitle(text: "lbl33_".tr),
    );
  }