import 'package:caprichosa/app_data.dart';
import 'package:caprichosa/collection.dart';
import 'package:caprichosa/collection_edit.dart';
import 'package:caprichosa/collection_statistics.dart';
import 'package:caprichosa/left_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key, required this.title});

  final String title;

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final TextEditingController _collectionNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);
    appData.initializeCollections();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Tooltip(
              message: 'Save current collection',
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  print('hello');
                },
                child: const Icon(CupertinoIcons.arrow_down_doc_fill),
              ),
            ),
            Tooltip(
              message: 'Import collection',
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  print('world');
                },
                child: const Icon(CupertinoIcons.arrow_up_doc_fill),
              ),
            ),
            Tooltip(
              message: 'Add collection',
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  showAddCollectionDialog(appData);
                },
                child: const Icon(CupertinoIcons.add_circled_solid),
              ),
            ),
          ],
        ),

      ),
      child: Row(
        children: [
          const LeftBar(),
          Expanded(
            child: appData.selectedCollection == null
                ? const Center(
                    child: Text(
                      'Select or create a collection to start the fun!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.systemRed,
                      ),
                    ),
                  )
                : Container(
                    //color: CupertinoColors.destructiveRed,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: CollectionEdit(collection: appData.selectedCollection),
                        ),
                        Expanded(
                          flex: 6,
                          child: CollectionStatistics(),
                        ),
                      ],
                    ),
                  ),
          ),
          
        ],
      ),
    );
    
  }

  showAddCollectionDialog(AppData appData) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Enter Collection Name'),
        content: CupertinoTextField(
          controller: _collectionNameController,
          placeholder: 'Collection Name',
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              String collectionName = _collectionNameController.text;

              if (collectionName.isNotEmpty) {
                Collection collection = Collection.basic(collectionName);
                appData.addCollection(collection);
              }
              
              Navigator.pop(context); 
            },
            child: const Text('Save'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            isDestructiveAction: true,
            child: const Text('Dismiss'),
          ),
        ],
      ),
    );
  }
}
