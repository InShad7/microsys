// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:microsys/model/item_model/item_model.dart';
import '../add_product_screen/add_product_screen.dart';
import '../category_details_screen/widget/content_widget.dart';
import '../category_details_screen/widget/edit_delete_btn.dart';
import '../utils/colors.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key, required this.item});
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(item.itemName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentWidget(
            width: width,
            title: 'item name',
            description: item.itemName,
          ),
          ContentWidget(
            width: width,
            title: 'Description',
            description: item.description,
          ),
          ContentWidget(
            width: width,
            title: 'Category',
            description: item.category,
          ),
          Row(
            children: [
              Expanded(
                child: ContentWidget(
                  width: width,
                  title: 'Unit',
                  description: item.unit,
                ),
              ),
              Expanded(
                child: ContentWidget(
                  width: width,
                  title: 'Price',
                  description: item.price,
                ),
              ),
            ],
          ),
          const Spacer(),
          EditAndDeleteBtn(
            width: width,
            item: item,
            addScreen: AddProductScreen(
              isEdit: true,
              item: item,
            ),
          ),
        ],
      ),
    );
  }
}
