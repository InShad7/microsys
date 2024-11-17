import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/category_controller/category_controller.dart';
import '../../../controller/item_controller/item_controller.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemController>(context);
    Provider.of<CategoryController>(context).fetchCategories();
    final categories = Provider.of<CategoryController>(context).categoryList;

    return DropdownButtonFormField<String>(
      hint: const Text('Select category'),
      value: provider.selectedCategory.isNotEmpty
          ? provider.selectedCategory
          : null,
      items: categories
          .where((category) => category.isActive)
          .map(
            (category) => DropdownMenuItem<String>(
              value: category.categoryName,
              child: Text(category.categoryName),
            ),
          )
          .toList(),
      onChanged: (value) {
        provider.selectCategory(value!);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      dropdownColor: Colors.grey[200],
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }
}
