import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_client/Controller/purchase_controller.dart';

import '../model/product.dart';

class ProductDescriptionPage extends StatelessWidget {
  const ProductDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Product product = Get.arguments['data'];
    return GetBuilder<PurchaseController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Product Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  product.image ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                product.name ?? '',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                product.description ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Rs:${product.price ?? ''}',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: ctrl.addressController,
                maxLines: 8,
                decoration:
                InputDecoration(
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Enter Your Billing Address',
                ),

              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child:  const Text(
                    'Buy Now ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ), onPressed: () {
                  ctrl.submitOrder(
                      price: product.price ?? 0,
                      item: product.name ?? '',
                      description: product.description ?? '');
                },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
