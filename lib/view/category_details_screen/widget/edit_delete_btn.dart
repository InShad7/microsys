// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:microsys/model/item_model/item_model.dart';
import 'package:provider/provider.dart';

import '../../../controller/category_controller/category_controller.dart';
import '../../../controller/item_controller/item_controller.dart';
import '../../../model/category_model/category_model.dart';
import '../../utils/colors.dart';
import '../../widget/custom_btn.dart';

class EditAndDeleteBtn extends StatelessWidget {
  const EditAndDeleteBtn({
    super.key,
    required this.width,
    this.category,
    required this.addScreen,
    this.isCategory = false,
    this.item,
  });

  final double width;
  final CategoryModel? category;
  final ItemModel? item;
  final Widget addScreen;
  final bool isCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(width * 0.04),
      child: Row(
        children: [
          Expanded(
            child: CustomBtn(
              title: 'Edit',
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => addScreen),
                );
              },
              color: blue,
              textColor: white,
            ),
          ),
          GestureDetector(
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(isCategory ? 'Delete Category' : 'Delete item'),
                  content: Text(
                    isCategory
                        ? 'Are you sure you want to delete this category?'
                        : 'Are you sure you want to delete this item?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
                if (isCategory) {
                  await Provider.of<CategoryController>(context, listen: false)
                      .deleteCategoryFromFirebase(category!.id);
                } else {
                  await Provider.of<ItemController>(context, listen: false)
                      .deleteItemFromFirebase(item!.id);
                }
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                // vertical: width * 0.03,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: width * 0.025,
              ),
              decoration: BoxDecoration(
                color: grey200,
                borderRadius: BorderRadius.circular(width * 0.03),
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
