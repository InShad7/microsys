import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:microsys/controller/item_controller/item_controller.dart';
import 'package:microsys/model/item_model/item_model.dart';
import 'package:microsys/view/utils/colors.dart';
import 'package:provider/provider.dart';

import '../add_product_screen/add_product_screen.dart';
import '../widget/shimmer.dart';
import 'widget/item_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
        title: const Text('Products'),
      ),
      body: Consumer<ItemController>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) => const CardShimmer(),
            );
          } else if (provider.itemList.isEmpty) {
            return const Center(
              child: Text('No items found!'),
            );
          } else {
            return ListView.builder(
              itemCount: provider.itemList.length,
              itemBuilder: (context, index) {
                ItemModel item = provider.itemList[index];
                return ItemCard(
                  item: item,
                  width: width,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: blue,
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          );
        },
        label: const Text(
          'Add product',
          style: TextStyle(
            color: white,
          ),
        ),
      ),
    );
  }
}
