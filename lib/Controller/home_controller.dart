import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product.dart';
import '../model/product_category/product_category.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollections;

  List<Product> products = [];
  List<Product> productShowInui = [];
  List<ProductCategory> productCategories = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    categoryCollections = firestore.collection('category');
    await fetchCategory();
    await fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapShot = await productCollection.get();
      final List<Product> retrievedproducts = productSnapShot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedproducts);
      productShowInui.assignAll(products);
      update();
      print("Number of products fetched: ${products.length}");
      update();
      Get.snackbar('Success', 'Product fetched Successfully',
          colorText: Colors.green);
    } catch (e) {
      Get.snackbar('error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  fetchCategory() async {
    try {
      QuerySnapshot categorySnapShot = await categoryCollections.get();
      final List<ProductCategory> retrievedCategory = categorySnapShot.docs
          .map((doc) =>
              ProductCategory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      productCategories.clear();
      productCategories.assignAll(retrievedCategory);
      update();
    } catch (e) {
      Get.snackbar('error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  filterByCategory(String category) {
    productShowInui.clear;
    productShowInui =
        products.where((product) => product.category == category).toList();
    update();
  }

  filterByBrand(List<String> brands) {
    if (brands.isNotEmpty) {
      // Convert selected brands to lowercase for case-insensitive comparison
      List<String> lowerCaseBrands = brands.map((brand) => brand.toLowerCase()).toList();

      // Filter the products by checking if the brand is in the selected list
      productShowInui = products
          .where((product) =>
          lowerCaseBrands.contains(product.brand?.toLowerCase() ?? ''))  // Safely handle null brand
          .toList();
    } else {
      // Show all products if no brands are selected
      productShowInui = products;
    }

    update();  // Notify UI to refresh
  }

  sortByPrice({required bool ascending}){
    List<Product> sortedProducts = List<Product>.from(productShowInui);
    sortedProducts.sort((a ,b ) => ascending ? a.price!.compareTo(b.price!) : b.price!.compareTo(a.price!));
    productShowInui = sortedProducts;
    update();
  }


}
