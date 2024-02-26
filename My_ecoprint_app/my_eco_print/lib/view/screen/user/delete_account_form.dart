// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_eco_print/controller/user.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/view/widgets/app_bar/appbar.dart';


class DeleteAccountForm extends StatefulWidget {
  @override
  _DeleteAccountFormState createState() => _DeleteAccountFormState();
}

class _DeleteAccountFormState extends State<DeleteAccountForm> {
  final TextEditingController otherReasonController = TextEditingController();
  String selectedReason = '';
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
    return Scaffold(
      appBar: buildAppBar(context,"lbl30_"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select or Provide Reason to Delete Your Account',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            RadioListTile(
              title: const Text('Reason 1'),
              value: 'Reason 1',
              groupValue: selectedReason,
              onChanged: (value) {
                setState(() {
                  selectedReason = value!;
                });
              },
            ),
            RadioListTile(
              title: const Text('Reason 2'),
              value: 'Reason 2',
              groupValue: selectedReason,
              onChanged: (value) {
                setState(() {
                  selectedReason = value!;
                });
              },
            ),
            RadioListTile(
              title: const Text('Other'),
              value: 'Other',
              groupValue: selectedReason,
              onChanged: (value) {
                setState(() {
                  selectedReason = value!;
                });
              },
            ),
            if (selectedReason == 'Other') ...[
              const SizedBox(height: 16.0),
              TextFormField(
                controller: otherReasonController,
                decoration: const InputDecoration(
                  labelText: 'Other Reason',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            const SizedBox(height: 20.0),
            CustomElevatedButton(
              text: "lbl30_".tr,
              margin: EdgeInsets.only(
                left: 80.h,
                right: 80.h,
              ),
              onTap: () {
                showDeleteAccountDialog(context);
              },
              buttonStyle: CustomButtonStyles.fillRed,
            ),
          ],
        ),
      ),
    );
  }

}