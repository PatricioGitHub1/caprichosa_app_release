import 'package:caprichosa/collection_element.dart';
import 'package:flutter/foundation.dart';

class Collection {
  String name;
  String? lastModificationDate;
  String? filePath;
  List<CollectionElement>? elements;

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
  int get hashCode => name.hashCode ^ lastModificationDate.hashCode ^ elements.hashCode;
}
