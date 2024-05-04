import 'package:caprichosa/collection.dart';
import 'package:caprichosa/collection_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AppData with ChangeNotifier {
  List<Collection> collections = [];
  Collection? selectedCollection;
  bool defaultCollectionDeleted = false; // Flag to track deletion of default collection

  void forceNotifyListeners() {
    notifyListeners();
  }

  // Add the default collection to the collections list
  void addDefaultCollection() {
    List<CollectionElement> elements = []; // Your elements initialization here
    elements.add(CollectionElement("Butterfly Knife | Marble Fade", null, 0.64 / 5));
    elements.add(CollectionElement("Temukau", null, 0.64 / 5));
    elements.add(CollectionElement("Head Shot", null, 0.64 / 5));
    elements.add(CollectionElement("Duality", null, 3.2 / 4));
    elements.add(CollectionElement("Wild Child", null, 3.2 / 4));
    elements.add(CollectionElement("Wicked Sick", null, 3.2 / 4));
    elements.add(CollectionElement("Emphorosaur-S", null, 15.98 / 5));
    elements.add(CollectionElement("Umbral Rabbit", null, 15.98 / 5));
    elements.add(CollectionElement("Sakkaku", null, 15.98 / 5));
    elements.add(CollectionElement("Neoqueen", null, 15.98 / 5));
    elements.add(CollectionElement("Banana Cannon", null, 79.92 / 5));
    elements.add(CollectionElement("Liquidation", null, 79.92 / 5));
    elements.add(CollectionElement("Fragments", null, 79.92 / 5));
    elements.add(CollectionElement("Featherweight", null, 79.92 / 5));
    elements.add(CollectionElement("Cyberforce", null, 79.92 / 5));
    elements.add(CollectionElement("Re.built", null, 79.92 / 5));
    elements.add(CollectionElement("Insomnia", null, 79.92 / 5));
    elements.add(CollectionElement("Rebel", null, 79.92 / 5));
    DateTime now = DateTime(2004,1,8);
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    Collection collectionBase = Collection("Revolution Case", formattedDate, elements, null);
    collections = [collectionBase];
  }

  // Initialize collections
  void initializeCollections() {
    if (!defaultCollectionDeleted) {
      addDefaultCollection(); // Add default collection only if not deleted
    }
  }

  // Method to close collection
  void closeCollection(Collection collection) {
    if (collection == selectedCollection) {
      selectedCollection = null;
    }

    if (collections.contains(collection)) {
      collections.remove(collection);
      if (collection.name == "Revolution Case") {
        defaultCollectionDeleted = true; // Set flag if default collection is deleted
      }
      notifyListeners();
    }
  }

  void setSelectedCollection(Collection collection) {
    selectedCollection = collection;
  }

}
