import 'package:flutter/material.dart';
import '../widgets/settings_header.dart';
import '../widgets/settings_list.dart';

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(
              isDarkMode: isDarkMode,
              onToggleTheme: onToggleTheme,
            ),
            const Expanded(child: SettingsList()),
          ],
        ),
      ),
    );
  }
}
