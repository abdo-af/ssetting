import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // بعد ما يختار الصورة ارفعها على فايربيز
      await _uploadUserData("abdoelsedemy8@gmail.com", _image);
    }
  }

  Future<void> _uploadUserData(String email, File? imageFile) async {
    if (imageFile == null) return;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('$email.jpg');

      await ref.putFile(imageFile);
      final imageUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'email': email,
        'image_url': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
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
            // صورة المستخدم
            Center(
              child: CircleAvatar(
                radius: 55,
                backgroundImage:
                _image != null ? FileImage(_image!) : null,
                backgroundColor: Colors.grey[300],
                child: _image == null
                    ? const Icon(Icons.person, size: 50, color: Colors.white70)
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
            // زرار تعديل الصورة
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

            // تبديل اللغة
            SwitchListTile(
              title: const Text("Language (English / Arabic)"),
              value: true,
              onChanged: (val) {},
              secondary: const Icon(Icons.language),
            ),

            // دارك مود
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: isDarkMode,
              onChanged: widget.onToggleTheme,
              secondary: const Icon(Icons.dark_mode),
            ),

            // عن التطبيق
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

            // تسجيل الخروج
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
