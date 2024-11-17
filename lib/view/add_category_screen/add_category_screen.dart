import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:microsys/controller/category_controller/category_controller.dart';
import 'package:microsys/model/category_model/category_model.dart';
import 'package:microsys/view/utils/constants.dart';
import 'package:microsys/view/widget/custom_btn.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../widget/custom_text_form_field.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key, this.isEdit = false, this.category});

  final bool isEdit;
  final CategoryModel? category;

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  late CategoryController provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<CategoryController>(context, listen: false);
    if (widget.isEdit) {
      provider.categoryNameController.text = widget.category!.categoryName;
      provider.descriptionController.text = widget.category!.description;
      provider.isActive = widget.category!.isActive;
    } else {
      provider.categoryNameController.clear();
      provider.descriptionController.clear();
      provider.isActive = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(widget.isEdit ? 'Edit category' : 'Add category'),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Form(
          key: provider.categoryFormKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: provider.categoryNameController,
                hintText: 'Category name',
                isPrefixIcon: false,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Category name is required';
                  }
                  return null;
                },
              ),
              kHeight20,
              CustomTextFormField(
                maxLines: 5,
                controller: provider.descriptionController,
                hintText: 'Category description',
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
              Row(
                children: [
                  Text(
                    'Active',
                    style: TextStyle(
                      fontSize: width * 0.04,
                    ),
                  ),
                  kWidth,
                  Consumer<CategoryController>(
                    builder: (context, value, child) => Switch.adaptive(
                      activeColor: blue,
                      value: provider.isActive,
                      onChanged: (value) {
                        provider.isActiveToggle();
                      },
                    ),
                  ),
                ],
              ),
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
                  if (provider.categoryFormKey.currentState!.validate()) {
                    if (widget.isEdit) {
                      provider.editCategory(categoryId: widget.category!.id);
                    } else {
                      provider.addCategoryToFirebase();
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
