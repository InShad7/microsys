import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/category_model/category_model.dart';
import '../../category_details_screen/category_details_screen.dart';
import '../../utils/colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.width,
  });

  final CategoryModel category;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => CategoryDetailsScreen(category: category),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: width * 0.02,
        ),
        decoration: BoxDecoration(
          color: grey200,
          borderRadius: BorderRadius.circular(width * 0.02),
        ),
        child: ListTile(
          title: Text(
            category.categoryName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            category.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(
            Icons.circle,
            color: category.isActive ? green : red,
            size: 10,
          ),
        ),
      ),
    );
  }
}
