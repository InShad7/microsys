import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/item_model/item_model.dart';
import '../../item_details_screen/item_details_screen.dart';
import '../../utils/colors.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
    required this.width,
  });

  final ItemModel item;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ItemDetailsScreen(
              item: item,
            ),
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
            item.itemName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            item.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            "KWD ${item.price}",
            style: const TextStyle(color: blue),
          ),
        ),
      ),
    );
  }
}
