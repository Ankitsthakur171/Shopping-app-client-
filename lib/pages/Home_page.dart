import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_client/Controller/home_controller.dart';
import 'package:project_client/pages/login_page.dart';
import 'package:project_client/pages/product_description_page.dart';
import 'package:project_client/widgets/multi_select_dropdown.dart';
import 'package:project_client/widgets/product_card.dart';
import '../widgets/drop_down_btn.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async {
          ctrl.fetchProducts();
          },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'SNEAKS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(onPressed: () {
                final box = GetStorage();
                box.erase();
                Get.offAll(const LoginPage());
              }, icon: const Icon(Icons.logout)),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ctrl.productCategories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            ctrl.filterByCategory(ctrl.productCategories[index].name ?? '');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Chip(label: Text(ctrl.productCategories[index].name ?? 'Error')),
                          ),
                        );
                      }),
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: SizedBox(
                        width: double.infinity,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: 'Rs : Low to High',
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'Rs : Low to High',
                                child: Center(
                                  child: Text('Rs : Low to High'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Rs : High to Low',
                                child: Center(
                                  child: Text('Rs : High to Low'),
                                ),
                              ),
                            ],
                            onChanged: (selected) {
                              ctrl.sortByPrice(ascending: selected == 'Rs : Low to High' ? true : false);
                            },
                            hint: const Text('Sort'),
                            icon: const Icon(Icons.arrow_drop_down),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),


                    Flexible(
                        child: MultiSelectDropdown(
                          items: const ['Roadsters', 'Sketchers', 'Puma', 'Adidas' , 'clarks'],
                          onSelectionChanged: (selectedItems) {
                            ctrl.filterByBrand(selectedItems);
                          },
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 650,
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8),
                      itemCount: ctrl.productShowInui.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          name: ctrl.productShowInui[index].name ?? 'No Name',
                          imageUrl: ctrl.productShowInui[index].image ?? 'url',
                          price: ctrl.productShowInui[index].price ?? 00,
                          offerTag: '30% off',
                          ontap: () {
                            Get.to(const ProductDescriptionPage(),
                            arguments: {'data' : ctrl.productShowInui[index]});
                          },
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
