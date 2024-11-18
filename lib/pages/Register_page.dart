import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:project_client/Controller/Login_controller.dart';
import 'package:project_client/pages/login_page.dart';

import '../widgets/otp_txt_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
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
                'Create Your Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: ctrl.registerNameCtrl,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone_android),
                  labelText: " Your name ",
                  hintText: " Enter your Name ",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: ctrl.registerNumberCtrl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone_android),
                  labelText: " Your Mobile Number ",
                  hintText: " Enter your Mobile Number ",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              OtpTextField(
                otpController: ctrl.otpController,
                visible: ctrl.OtpFieldShow, onComplete: (otp) {
                  ctrl.otpEnter = int.tryParse(otp!);
              },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    if(ctrl.OtpFieldShow){
                      ctrl.addUser();
                    }else{
                      ctrl.sendOtp();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                  ),
                  child:Text(ctrl.OtpFieldShow ? "Register " : "Send Otp")),
              TextButton(onPressed: () {
                Get.to(() =>const LoginPage());
              }, child: const Text("Login")),
            ],
          ),
        ),
      );
    });
  }
}
