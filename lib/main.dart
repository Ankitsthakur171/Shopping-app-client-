import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_client/Controller/Login_controller.dart';
import 'package:project_client/Controller/home_controller.dart';
import 'package:project_client/Controller/purchase_controller.dart';
import 'package:project_client/pages/Home_page.dart';
import 'package:project_client/pages/Register_page.dart';
import 'package:project_client/pages/login_page.dart';
import 'package:project_client/pages/product_description_page.dart';

import 'firebase_option.dart';

Future<void> main() async {

  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options : firebaseOptions);
  Get.put(LoginController());
  Get.put(HomeController());
  Get.put(PurchaseController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const HomePage(),

    );
  }
}


