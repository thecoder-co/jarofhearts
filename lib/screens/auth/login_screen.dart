import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jar_of_hearts/controllers/auth.dart';
import 'package:jar_of_hearts/screens/auth/register_screen.dart';
import 'package:jar_of_hearts/screens/home/home.dart';
import 'package:jar_of_hearts/utils/app_colors.dart';
import 'package:jar_of_hearts/utils/size.dart';
import 'package:jar_of_hearts/widgets/gradient_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final usernameText = TextEditingController();
  final passwordText = TextEditingController();

  bool isVisible = false;

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColors.gradient,
          ),
          alignment: Alignment.center,
          child: Container(
            height: WindowSize.height(context) - 50,
            width: WindowSize.isLandscape(context)
                ? WindowSize.width(context) / 2.5
                : double.infinity,
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/jar of hearts.jpeg',
                    height: 200,
                    width: 200,
                    //color: Colors.red,
                  ),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      prefixIcon: Icon(Icons.person),
                    ),
                    controller: usernameText,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordText,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.person),
                      /* suffixIcon: IconButton(
                        onPressed: () {
                          setState(() => isVisible = !isVisible);
                        },
                        icon: Icon(
                          isVisible ? Icons.visibility_off : Icons.visibility,
                        ),
                      ), */
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GradientButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        bool status = await authController.loginUser(
                          username: usernameText.text,
                          password: passwordText.text,
                        );
                        if (status) {
                          Get.to(() => const HomeScreen());
                        }
                      }
                    },
                    text: 'Login',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.to(() => const RegisterScreen());
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
