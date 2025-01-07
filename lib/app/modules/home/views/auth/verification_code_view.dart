import 'package:ersei/app/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'new_password_view.dart';

class VerificationCodeView extends GetView {
  const VerificationCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.black54,
              ),
              const SizedBox(height: 10),
              Center(
                child: Image.asset(
                  'images/ers.eilogo.png',
                  height: 60,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'ادخل رمز التأكيد المرسل الى بريدك\nالالكتروني',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: index == 0 ? const Color(0xFF96E6B3) : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: index == 0
                        ? const Center(
                            child: Text(
                              '5',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'لم يصلني أي رمز تأكيد - إعادة الارسال',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const NewPasswordView()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF96E6B3),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'SEND',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
