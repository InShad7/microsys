import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:microsys/controller/item_controller/item_controller.dart';
import 'package:microsys/model/item_model/item_model.dart';
import 'package:microsys/view/utils/constants.dart';
import 'package:microsys/view/widget/custom_btn.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../widget/custom_text_form_field.dart';
import 'widget/custom_drop_down.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key, this.isEdit = false, this.item});

  final bool isEdit;
  final ItemModel? item;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late ItemController provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<ItemController>(context, listen: false);
    if (widget.isEdit) {
      provider.itemNameController.text = widget.item!.itemName;
      provider.descriptionController.text = widget.item!.description;
      provider.unitController.text = widget.item!.unit;
      provider.priceController.text = widget.item!.price;
      provider.selectedCategory = widget.item!.category;
    } else {
      provider.itemNameController.clear();
      provider.descriptionController.clear();
      provider.unitController.clear();
      provider.priceController.clear();
      provider.selectedCategory = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(widget.isEdit ? 'Edit item' : 'Add item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Form(
          key: provider.itemFormKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: provider.itemNameController,
                hintText: 'Item name',
                isPrefixIcon: false,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Item name is required';
                  }
                  return null;
                },
              ),
              kHeight20,
              CustomTextFormField(
                maxLines: 5,
                controller: provider.descriptionController,
                hintText: 'Item description',
                isPrefixIcon: false,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              kHeight20,
              CustomTextFormField(
                controller: provider.priceController,
                hintText: 'Price',
                isPrefixIcon: false,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price is required';
                  }
                  return null;
                },
              ),
              kHeight20,
              CustomTextFormField(
                controller: provider.unitController,
                hintText: 'Unit',
                isPrefixIcon: false,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unit is required';
                  }
                  return null;
                },
              ),
              kHeight20,
              const CategoryDropdown(),
              const Spacer(),
              CustomBtn(
                title: 'Save',
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                  if (provider.itemFormKey.currentState!.validate()) {
                    if (widget.isEdit) {
                      provider.editItems(categoryId: widget.item!.id);
                    } else {
                      provider.addItemsToFirebase();
                    }
                  } else {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: 'Please enter valid data');
                  }
                },
                color: blue,
                textColor: white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
