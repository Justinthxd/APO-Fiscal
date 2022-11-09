import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

Widget line() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20),
    child: const DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 4.0,
      dashColor: Colors.black45,
      dashRadius: 0.0,
      dashGapLength: 9.0,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    ),
  );
}
