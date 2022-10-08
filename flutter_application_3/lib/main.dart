import 'package:flutter/material.dart';
import 'package:flutter_application_3/Utils/binding.dart';
import 'package:flutter_application_3/Utils/middleWare.dart';
import 'package:flutter_application_3/View/Auth/signUp.dart';
import 'package:flutter_application_3/constance.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'View/Home/home.dart';
import 'firebase_options.dart';
import 'View/Auth/login.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      initialBinding: MyBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LogIn(), middlewares: [MyMiddleWare()]),
        GetPage(name: '/signup', page: () => SignUp()),
        GetPage(name: '/home', page: () => const Home()),
      ],
    );
  }
}
