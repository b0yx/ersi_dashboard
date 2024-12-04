import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'auth/login_view.dart';
import 'auth/signup_view.dart';

class WellcomeView extends GetView<HomeController> {
  const WellcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F9F4),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'images/ers.eilogo.png',
              height: 80,
            ),
            Image.asset(
              'images/engineerphoto.png',
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const SignupView()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF96E6B3),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'هيا بنا!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Get.to(() => const LoginView()),
                        child: const Text(
                          'قم بتسجيل الدخول',
                          style: TextStyle(
                            color: Color(0xFF96E6B3),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const Text(
                        'هل تملك حساب بالفعل؟',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
