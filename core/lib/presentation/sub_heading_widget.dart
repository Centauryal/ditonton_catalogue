import 'package:core/core.dart';
import 'package:flutter/material.dart';

Row buildSubHeading({
  required String title,
  required Function() onTap,
  required Key key,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: kHeading6,
      ),
      Material(
        child: InkWell(
          key: key,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      )
    ],
  );
}
