import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  void _register() {
    String username = _userController.text.trim();
    String password = _passController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Isi semua data!")));
      return;
    }

    var box = Hive.box('users');

    // Cek kalau username sudah terdaftar
    if (box.containsKey(username)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Username sudah dipakai!")));
      return;
    }

    // ✅ Simpan sebagai MAP sesuai dengan login
    box.put(username, {"username": username, "password": password});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registrasi Berhasil! Silakan Login.")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Akun")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: "Buat Username"),
            ),
            TextField(
              controller: _passController,
              decoration: const InputDecoration(labelText: "Buat Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: const Text("DAFTAR SEKARANG"),
            ),
          ],
        ),
      ),
    );
  }
}
