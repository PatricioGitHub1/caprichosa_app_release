import 'dart:math';

import 'package:caprichosa/collection.dart';
import 'package:caprichosa/collection_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AppData with ChangeNotifier {
  final int totalRouletteComponents = 100;
  List<Collection> collections = [];
  Collection? selectedCollection;
  CollectionElement? selectedElement;
  bool defaultCollectionDeleted = false; // Flag to track deletion of default collection
  
  List<CollectionElement> rouletteComponents = [];

  void forceNotifyListeners() {
    notifyListeners();
  }

  // Add the default collection to the collections list
  void addDefaultCollection() {
    List<CollectionElement> elements = []; // Your elements initialization here

    elements.add(CollectionElement("Wicked Sick", null, 1.38, generateRandomColor()));
    elements.add(CollectionElement("Emphorosaur-S", null, 1.83, generateRandomColor()));
    elements.add(CollectionElement("Umbral Rabbit", null, 1.83, generateRandomColor()));
    elements.add(CollectionElement("Sakkaku", null, 1.83, generateRandomColor()));
    elements.add(CollectionElement("Neoqueen", null, 1.83, generateRandomColor()));
    elements.add(CollectionElement("Banana Cannon", null, 10.93, generateRandomColor()));
    elements.add(CollectionElement("Liquidation", null, 10.93, generateRandomColor()));
    elements.add(CollectionElement("Fragments", null, 10.93, generateRandomColor()));
    elements.add(CollectionElement("Featherweight", null, 10.93, generateRandomColor()));
    elements.add(CollectionElement("Cyberforce", null, 10.93, generateRandomColor()));
    elements.add(CollectionElement("Re.built", null, 10.93, generateRandomColor()));
    elements.add(CollectionElement("Insomnia", null, 10.93, generateRandomColor()));
    elements.add(CollectionElement("Rebel", null, 10.93, generateRandomColor()));

    elements.add(CollectionElement("Butterfly Knife | Marble Fade", null, 0.24, generateRandomColor()));
    elements.add(CollectionElement("Temukau", null, 0.43, generateRandomColor()));
    elements.add(CollectionElement("Head Shot", null, 0.43, generateRandomColor()));
    elements.add(CollectionElement("Duality", null, 1.38, generateRandomColor()));
    elements.add(CollectionElement("Wild Child", null, 1.38, generateRandomColor()));

    DateTime now = DateTime(2004,1,8);
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    Collection collectionBase = Collection("Revolution Case", formattedDate, elements, null);
    collections.add(collectionBase);
  }

  // Initialize collections
  void initializeCollections() {
  if (collections.isEmpty && !defaultCollectionDeleted) {
      addDefaultCollection(); // Add default collection only if collections list is empty and default collection is not deleted
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

  void closeCollectionElement(CollectionElement element) {
    if (element == selectedElement) {
      print("el elemento a eliminar esta seleccionado");
      selectedElement = null;
    }

    selectedCollection!.elements.remove(element);

    notifyListeners();
  }

  void setSelectedCollection(Collection collection) {
    selectedCollection = collection;
    selectedElement = null;
    notifyListeners();
  }

  void setSelectedCollectionElement(CollectionElement element) {
    selectedElement = element;
    notifyListeners();
  }

  void setCollectionElementColor(CollectionElement element, Color newColor) {
    element.color = newColor;
    notifyListeners();
  }

  void setCollectionElementPercentage(CollectionElement element, double percentage) {
    element.percentage = double.parse(percentage.toStringAsFixed(2));
    notifyListeners();
  }

  Color generateRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256), // Random red value
      random.nextInt(256), // Random green value
      random.nextInt(256), // Random blue value
    );
  }

  void addCollection(Collection collection) {
    String newName = collection.name;
    int count = 1;

    while (collections.any((existingCollection) => existingCollection.name == newName)) {
      newName = '${collection.name} (${count++})'; 
    }

    collection.name = newName; 
    collections.add(collection); 
    notifyListeners();
  }

  void addCollectionElement(CollectionElement element) {
    String newName = element.name;
    int count = 1;

    while (selectedCollection!.elements.any((existingElement) => existingElement.name == newName)) {
      newName = '${element.name} (${count++})'; 
    }

    element.name = newName;
    selectedCollection!.elements.add(element);
    notifyListeners(); 
  }

  void startSpinProcess() {
    
    selectedCollection!.orderElementsByPercentage();

    //print(selectedCollection!.differentialPercentage);
    for (var i = 0; i < totalRouletteComponents; i++) {

      double randomValue = Random().nextDouble() * 100;
      double addedIrregularValue = selectedCollection!.differentialPercentage / selectedCollection!.elements.length;
      double accumulatedPercentage = 0.0;

      for (var element in selectedCollection!.elements) {
        accumulatedPercentage += element.percentage + addedIrregularValue;
        if (randomValue < accumulatedPercentage) {
          rouletteComponents.add(element);
          break;
        }
      }
    }
    
  }

}
