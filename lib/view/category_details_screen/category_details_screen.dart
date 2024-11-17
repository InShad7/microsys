import 'package:flutter/material.dart';
import 'package:microsys/model/category_model/category_model.dart';
import '../add_category_screen/add_category_screen.dart';
import '../utils/colors.dart';
import 'widget/content_widget.dart';
import 'widget/edit_delete_btn.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(category.categoryName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentWidget(
            width: width,
            title: 'Category name',
            description: category.categoryName,
          ),
          ContentWidget(
            width: width,
            title: 'Description',
            description: category.description,
          ),
          ContentWidget(
            width: width,
            title: 'Active',
            description: category.isActive ? 'Active' : 'Not active',
          ),
          const Spacer(),
          EditAndDeleteBtn(
            isCategory: true,
            width: width,
            category: category,
            addScreen: AddCategoryScreen(
              isEdit: true,
              category: category,
            ),
          ),
        ],
      ),
    );
  }
}
