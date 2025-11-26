// lib/presentation/screens/settings_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/settings_local.dart';
import '../cubit/settings_cubit.dart';
import 'about_screen.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onToggleTheme;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.onToggleTheme,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // read initial image from cubit if available
    final cubit = context.read<SettingsCubit>();
    final state = cubit.state;
    if (state is dynamic && state.imageFile != null) {
      _image = state.imageFile;
    }
    // subscribe to changes
    cubit.stream.listen((s) {
      if (s is dynamic) {
        setState(() {
          _image = s.imageFile;
        });
      }
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final path = pickedFile.path;
      // save path via cubit (which writes to SharedPreferences)
      context.read<SettingsCubit>().setImagePath(path);

      // update local preview immediately
      setState(() {
        _image = File(path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = widget.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(Icons.person, size: 60, color: Colors.white70)
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "abdoelsedemy8@gmail.com",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.edit),
                label: const Text("Edit Photo"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? Colors.grey[800] : Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 25),

            SwitchListTile(
              title: const Text("Language (English / Arabic)"),
              value: true,
              onChanged: (val) {},
              secondary: const Icon(Icons.language),
            ),

            // Dark Mode switch now uses the cubit via the callback passed in main
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: isDarkMode,
              onChanged: widget.onToggleTheme,
              secondary: const Icon(Icons.dark_mode),
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AboutScreen(isDarkMode: isDarkMode),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
