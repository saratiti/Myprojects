import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';

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
          title: Text(
            'Delete Account',
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Are you sure you want to remove your account?',
            style: TextStyle(color: Colors.black54),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: appTheme.deepOrange800),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteUser();
              },
              child: Text(
                'Remove',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select or Provide Reason to Delete Your Account',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20.0),
            _buildReasonRadioTile('Reason 1'),
            _buildReasonRadioTile('Reason 2'),
            _buildReasonRadioTile('Other'),
            if (selectedReason == 'Other') ...[
              SizedBox(height: 16.0),
              TextFormField(
                controller: otherReasonController,
                decoration: InputDecoration(
                  labelText: 'Other Reason',
                  labelStyle: TextStyle(color: Colors.black87),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            SizedBox(height: 20.0),
            CustomElevatedButton(
              text: "lbl30_".tr,
              margin: EdgeInsets.symmetric(horizontal: 80.0),
              onPressed: () {
                showDeleteAccountDialog(context);
              },
              buttonStyle: CustomButtonStyles.fillPrimary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonRadioTile(String title) {
    return RadioListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.black87),
      ),
      value: title,
      groupValue: selectedReason,
      onChanged: (value) {
        setState(() {
          selectedReason = value!;
        });
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        elevation: 0,
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
            child: Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
        title: Text(
          "lbl30_".localized,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
