import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:microsys/controller/category_controller/category_controller.dart';
import 'package:microsys/model/category_model/category_model.dart';
import 'package:microsys/view/add_category_screen/add_category_screen.dart';
import 'package:microsys/view/utils/colors.dart';
import 'package:microsys/view/widget/shimmer.dart';
import 'package:provider/provider.dart';
import 'widget/category_card.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryController>(context, listen: false).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: const Text('Category'),
      ),
      body: Consumer<CategoryController>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) => const CardShimmer(),
            );
          } else if (provider.categoryList.isEmpty) {
            return const Center(
              child: Text('No categories found!'),
            );
          } else {
            return ListView.builder(
              itemCount: provider.categoryList.length,
              itemBuilder: (context, index) {
                CategoryModel category = provider.categoryList[index];
                return CategoryCard(
                  category: category,
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
              builder: (context) => const AddCategoryScreen(),
            ),
          );
        },
        label: const Text(
          'Add category',
          style: TextStyle(
            color: white,
          ),
        ),
      ),
    );
  }
}
