import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_client/pages/Register_page.dart';
import '../Controller/Login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController ctrl = Get.find<LoginController>();
    return GetBuilder<LoginController>(
      assignId: true,
      builder: (ctrl) {
        return Scaffold(
          body: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: ctrl.loginNumberCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.phone_android),
                      labelText: "Mobile Number",
                      hintText: " Enter Mobile Number",
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ctrl.loginWithPhone();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text("Login"),
                  ),
                  TextButton(onPressed: () {
                    Get.to(() => const RegisterPage());
                  },
                      child: const Text("Register new account ")),
                ],
              )),
        );
      },
    );
  }
}
