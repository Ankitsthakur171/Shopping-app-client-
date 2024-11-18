import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PurchaseController extends GetxController {
  TextEditingController addressController = TextEditingController();
  double orderPrice = 0;

  String itemName = '';
  String orderAddress = '';

  submitOrder(
      {required double price,
      required String item,
      required String description}) {
    orderPrice = price;
    itemName = item;
    orderAddress = addressController.text;
    Razorpay razorpay = Razorpay();
    var options = {
      'key': '<YOUR_KEY_HERE>',
      'amount': 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {
        'contact': '8888888888',
        'email': 'test@razorpay.com'
      }
    };
  }
}
