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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageBase64': imageBase64,
      'percentage': percentage,
      'color': color.value,
    };
  }

  factory CollectionElement.fromJson(Map<String, dynamic> json) {
    return CollectionElement(
      json['name'],
      json['imageBase64'],
      json['percentage'].toDouble(),
      Color(json['color']),
    );
  }
}