import 'package:caprichosa/collection_element.dart';
import 'package:flutter/foundation.dart';

enum CollectionAddedPercentage {
  undefined,
  just0neHundred,
  lessThanOneHundred,
  moreThanOneHundred

}

class Collection {
  String name;
  String? lastModificationDate;
  String? filePath;
  List<CollectionElement> elements = [];
  CollectionElement? selectedElement;
  CollectionAddedPercentage addedPercentage = CollectionAddedPercentage.undefined;
  double differentialPercentage = 0.0;

  Collection(this.name, this.lastModificationDate, this.elements, this.filePath);
  Collection.basic(this.name);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Collection &&
        other.name == name &&
        other.lastModificationDate == lastModificationDate &&
        listEquals(other.elements, elements) ;
  }

  @override
  String toString() {
    return "($name,$lastModificationDate, $filePath, $elements, $addedPercentage, $differentialPercentage)";
  }

  @override
  int get hashCode => name.hashCode ^ lastModificationDate.hashCode ^ elements.hashCode;

  double getTotalPercentage() {
    double total = 0;

    for (var element in elements) {
      total += element.percentage;
    }

    return double.parse(total.toStringAsFixed(2));
  }

  void setAddedPercentage() {
    double totalPercentage = getTotalPercentage();
    print(totalPercentage);

    if (totalPercentage == 100.00) {
      addedPercentage = CollectionAddedPercentage.just0neHundred;
      differentialPercentage = 0.0;

    } else if (totalPercentage > 100.00) {
      addedPercentage = CollectionAddedPercentage.moreThanOneHundred;

    } else  {
      addedPercentage = CollectionAddedPercentage.lessThanOneHundred;

    }
  }

  double getRemainingPercentageTo100(bool lessThan100) {
    if (lessThan100) {
      differentialPercentage = double.parse((100.00 - getTotalPercentage()).toStringAsFixed(2));
    } else {
      differentialPercentage = double.parse((getTotalPercentage() - 100).toStringAsFixed(2));
    }

    return differentialPercentage;
  }

  void orderElementsByPercentage() {
    elements.sort((a, b) => a.percentage.compareTo(b.percentage));
    print(elements.toString());
  }
  
}
