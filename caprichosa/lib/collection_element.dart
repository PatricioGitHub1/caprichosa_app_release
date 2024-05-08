import 'package:flutter/cupertino.dart';

class CollectionElement {
  String name;
  String? imageBase64;
  double percentage;
  Color color;

  CollectionElement(this.name, this.imageBase64, this.percentage, this.color) {
    percentage = double.parse(percentage.toStringAsFixed(2));
  }

  @override
  String toString() {
    return "($name,$percentage)";
  }
}