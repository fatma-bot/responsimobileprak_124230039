import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsiapp/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Ambil Data dari Hive
    var box = Hive.box('session');
    String username = box.get('username', defaultValue: 'User');

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage("assets/images/kucing.jpg"),
              backgroundColor: Colors.orange,
            ),
            const SizedBox(height: 20),
            Text(
              "Halo, Fatma Triana",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text("124230039"),
            Text("Logged in as $username"),
            const SizedBox(height: 40),

            // TOMBOL LOGOUT
            ElevatedButton.icon(
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                "LOGOUT",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                // 1. Hapus Data Session
                box.put('isLogin', false);
                // box.clear(); // Opsional: kalau mau hapus semua data di box session

                // 2. Lempar balik ke Login Screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false, // Hapus semua riwayat halaman sebelumnya
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
