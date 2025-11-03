import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      children: [
        _buildSectionTitle('Account', color: Colors.blueAccent),
        _buildSettingItem(Icons.lock_outline, 'Privacy'),
        _buildSettingItem(Icons.notifications_none, 'Notifications'),
        _buildSettingItem(Icons.language_outlined, 'Language'),
        const SizedBox(height: 15),
        _buildSectionTitle('Support', color: Colors.blueAccent),
        _buildSettingItem(Icons.help_outline, 'Help Center'),
        _buildSettingItem(Icons.feedback_outlined, 'Send Feedback'),
        const SizedBox(height: 15),
        _buildSectionTitle('More', color:Colors.blueAccent),
        _buildSettingItem(Icons.info_outline, 'About App'),
        _buildSettingItem(Icons.logout, 'Logout', color: Colors.red),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: color ?? Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.blueAccent),
      title: Text(title, style: TextStyle(color: color)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}