import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    super.key,
    required this.width,
    required this.description,
    required this.title,
  });

  final double width;
  final String description;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: black,
            ),
          ),
          Container(
            width: width,
            // margin: EdgeInsets.symmetric(
            //   horizontal: width * 0.04,
            //   vertical: width * 0.02,
            // ),
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: width * 0.03,
            ),
            decoration: BoxDecoration(
              color: grey200,
              borderRadius: BorderRadius.circular(width * 0.03),
            ),
            child: Text(
              description,
              style: TextStyle(
                fontSize: width * 0.04,
                color: black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
