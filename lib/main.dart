import 'package:ersei/app/core/loclization/translition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/core/services/services.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: MyTranslition(),
      title: 'Engineering Reports System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.VERIFICATIONCODEVIEW, // المسار المبدئي

      getPages: AppPages.routes, // تحديد الروابط مع الـ Bindings
    );
  }
}
