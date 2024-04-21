import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/widgets/custom_elevated_button.dart';

class InviteFriendsPage extends StatelessWidget {
  const InviteFriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            const Text(
              'Invite your friends to join!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Invite Form
            const TextField(
              decoration: InputDecoration(
                labelText: 'Friend\'s Email',
                border: OutlineInputBorder(),
                // Add more form fields for phone number, message, etc.
              ),
            ),
            const SizedBox(height: 20),
            // Share Options
            const Text(
              'Share invitation via:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareIconButton(Icons.email, 'Email', () {
                  // Implement sharing via email
                }),
                _buildShareIconButton(Icons.message, 'SMS', () {
                  // Implement sharing via SMS
                }),
                _buildShareIconButton(Icons.share, 'Other', () {
                  // Implement sharing via other social media platforms
                }),
              ],
            ),
            // Send Invitation Button
            const SizedBox(height: 20),
            _buildUploadButton(context)
          ],
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
        "Invite Friends",
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),
  );
}
Widget _buildUploadButton(BuildContext context) {
  return CustomElevatedButton(
    height: 55.v,
    text: "Send Invitation",
    onPressed: () {
     
    },
   
  );
}
  Widget _buildShareIconButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          iconSize: 48,
          color: appTheme.deepOrange800,
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
