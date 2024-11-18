import 'package:flutter/material.dart';
import 'package:microsys/controller/item_controller/item_controller.dart';
import 'package:microsys/view/add_product_screen/widget/custom_drop_down.dart';
import 'package:microsys/view/utils/colors.dart';
import 'package:microsys/view/utils/constants.dart';
import 'package:provider/provider.dart';
import '../item_screen/widget/item_card.dart';
import 'widget/chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ItemController>(context, listen: false);
    provider.fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: const Text('Dashboard'),
      ),
      body: Consumer<ItemController>(
        builder: (context, provider, child) => Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            children: [
              const CategoryDropdown(),
              kHeight20,
              CategoryChart(
                items: provider.itemList,
                selectedCategory: provider.selectedCategory,
              ),
              if (provider.selectedCategory != '')
                Column(
                  children: [
                    kHeight20,
                    const Text(
                      'X axis: Units',
                      style: TextStyle(color: grey),
                    ),
                    const Text(
                      'Y axis: Price',
                      style: TextStyle(color: grey),
                    ),
                    kHeight30,
                    SizedBox(
                      height: width * 0.65,
                      child: Builder(
                        builder: (context) {
                          final filteredList = provider.itemList
                              .where((item) =>
                                  item.category == provider.selectedCategory)
                              .toList();

                          return ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final item = filteredList[index];
                              return ItemCard(
                                isDashboard: true,
                                item: item,
                                width: width,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
