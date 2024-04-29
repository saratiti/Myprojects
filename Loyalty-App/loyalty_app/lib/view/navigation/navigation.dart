import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';


class CircularNavigationMenu extends StatelessWidget {
  final VoidCallback? onProfilePressed;
  final VoidCallback? onInvitePressed;
  final VoidCallback? onLogoutPressed;

  const CircularNavigationMenu({
    Key? key,
    this.onProfilePressed,
    this.onInvitePressed,
    this.onLogoutPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         _buildMenuItem(
  icon: Icons.account_circle,
  label: 'Your Profile',
  onPressed: () {
    Navigator.pushNamed(context, AppRoutes.editScreen);
  },
),
          const SizedBox(height: 16),
          _buildMenuItem(
            icon: Icons.person_add,
            label: 'Invite Friends',
            onPressed: onInvitePressed,
          ),
          const SizedBox(height: 16),
          _buildMenuItem(
            icon: Icons.logout,
            label: 'Logout',
            onPressed: () {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: appTheme.deepOrange800,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
