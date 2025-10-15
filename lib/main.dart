import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/screens/auth/register_screen.dart';
import 'package:jar_of_hearts/screens/home/home.dart';
import 'package:jar_of_hearts/utils/user_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Jar of hearts',
      theme: ThemeData(
        fontFamily: 'Dys',
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          // filled: true,
          // fillColor: Colors.grey,
        ),
      ),
      home: UserPreferences.isLoggedIn()
          ? const HomeScreen()
          : const RegisterScreen(),
    );
  }
}
