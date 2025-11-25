import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsiapp/screens/login_screen.dart';
import 'package:responsiapp/screens/navigation.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('session');
  await Hive.openBox('users');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('session');
    var isLoggedIn = box.get('isLogin', defaultValue: false);
    return MaterialApp(
      home: isLoggedIn ? const Navigation() : const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
