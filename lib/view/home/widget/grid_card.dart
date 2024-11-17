
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../category_screen/category_screen.dart';
import '../../dashboard_screen/dashboard_screen.dart';
import '../../item_screen/item_screen.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class GridCard extends StatelessWidget {
  const GridCard({
    super.key,
    required this.width, required this.index,
  });

  final double width;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => index == 0
                ? const CategoryScreen()
                : index == 1
                    ? const ProductScreen()
                    : const DashboardScreen(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(width * 0.025),
        padding: EdgeInsets.all(width * 0.03),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(19),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(3, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: width * 0.30,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Image.asset(gridImg[index]),
            ),
            kHeight,
            Text(
              gridItem[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 0.04,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List gridItem = [
  'Category',
  'Products',
  'Dashboard',
];
List gridImg = [
  'assets/image/category_micro.png',
  'assets/image/product_micro.png',
  'assets/image/dashbord.png',
];
