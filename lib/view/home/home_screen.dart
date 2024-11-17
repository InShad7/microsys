import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'widget/grid_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: blue,
        title: Image.network(
          'https://www.microsystc.com/img/logo.png',
          height: 120,
          width: 150,
        ),
      ),
      body: GridView.builder(
        itemCount: gridItem.length,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: width * 0.01,
          mainAxisSpacing: width * 0.01,
          childAspectRatio: 0.99,
        ),
        itemBuilder: (context, index) {
          return GridCard(
            width: width,
            index: index,
          );
        },
      ),
    );
  }
}
