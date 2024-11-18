import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';
import 'package:project_client/pages/Home_page.dart';
import '../model/users/user.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerNumberCtrl = TextEditingController();
  TextEditingController loginNumberCtrl = TextEditingController();
  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  bool OtpFieldShow = false;
  int? OtpSend;
  int? otpEnter;

  User? loginUser ;

  @override
  void onReady() {
    Map<String, dynamic>? user = box.read('loginUser');
    if (user != null) {
      loginUser = User.fromJson(user);
      Get.to(const HomePage());
    }
    super.onReady();
  }

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  addUser() {
    try {
      if (OtpSend == otpEnter) {
        DocumentReference doc = userCollection.doc();
        User user = User(
          id: doc.id,
          name: registerNameCtrl.text,
          number: int.parse(registerNumberCtrl.text),
        );
        final userJson = user.toJson();
        doc.set(userJson);
        update();
        Get.snackbar('success', 'user  added successfully',
            colorText: Colors.green);
        registerNumberCtrl.clear();
        registerNameCtrl.clear();
        otpController.clear();
      } else {
        Get.snackbar('Error', 'Otp is Incorrect', colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar('error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  sendOtp() async {
    try {
      if (registerNameCtrl.text.isEmpty || registerNumberCtrl.text.isEmpty) {
        Get.snackbar('Error', 'Please Fill the Fields ', colorText: Colors.red);
        //? to stop the code
        return;
      }
      final random = Random();
      int otp = 1000 + random.nextInt(9000);
      String mobileNumber = registerNumberCtrl.text;
      String url =
          'https://www.fast2sms.com/dev/bulkV2?authorization=HoyKJqSOUY7vXMIVENkmPhpi9tABjax6dz3cugLeGrTWn0485FVGqmHLYXA9QOxWI2EMF8hNzpveyb5g&route=otp&variables_values=$otp&flash=0&numbers=$mobileNumber';
      Response response = await GetConnect().get(url);
      print(otp);
      print(response.body);
      // will send otp and check if send successfully or not
      if (response.body["message"][0] == 'SMS sent successfully.') {
        OtpFieldShow = true;
        OtpSend = otp;
        Get.snackbar('Successful', 'Otp Send successfully',
            colorText: Colors.green);
      } else {
        Get.snackbar('Error', 'Otp Not Send', colorText: Colors.red);
      }
    } catch (e) {
      print(e);
    } finally {
      update();
    }
  }

  Future<void> loginWithPhone() async {
    try {
      String phoneNumber = loginNumberCtrl.text;
      if (phoneNumber.isNotEmpty) {
        var querySnapshot = await userCollection
            .where('number', isEqualTo: int.tryParse(phoneNumber))
            .limit(1)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.first;
          var userData = userDoc.data() as Map<String, dynamic>;
          box.write('loginUser', userData);
          Get.to(() => const HomePage());
          loginNumberCtrl.clear();
          Get.snackbar('Success', 'login Successful', colorText: Colors.green);
        } else {
          Get.snackbar('Error', 'User not found, please register',
              colorText: Colors.red);
        }
      }
    } catch (error) {
      print('failed to Login :$error');
      Get.snackbar('Error', 'Failed to Login', colorText: Colors.red);
    }
  }
}
