import 'package:caprichosa/app_data.dart';
import 'package:caprichosa/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionEdit extends StatefulWidget {
  final Collection? collection;

  const CollectionEdit({Key? key, this.collection}) : super(key: key);

  @override
  _CollectionEditState createState() => _CollectionEditState();
}

class _CollectionEditState extends State<CollectionEdit> {
  late TextEditingController _textFieldController;

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController(text: widget.collection?.name ?? '');
  }

  @override
  void didUpdateWidget(covariant CollectionEdit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.collection != widget.collection) {
      _textFieldController.text = widget.collection?.name ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);
    ScrollController _scrollController = ScrollController();


    if (widget.collection == null) {
      print("xd");
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top, // Height of the status bar
        ),
        SizedBox(
          height: 150, // You can adjust the height as needed
          child: Container(
            color: CupertinoColors.activeOrange,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: "Collection's name: ",
                      style: const TextStyle(
                        color: CupertinoColors.activeBlue,
                        fontSize: 16.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "${widget.collection?.name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CupertinoTextField(
                  controller: _textFieldController,
                  placeholder: widget.collection?.name,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 6, // 60% of the available height
          child: Container(
            color: CupertinoColors.secondarySystemFill,
            width: double.infinity,
          ),
        ),
        Expanded(
          flex: 4, // 40% of the available height
          child: CupertinoScrollbar(
        controller: _scrollController,
        child: Container( // Added container with secondarySystemFill color
          color: CupertinoColors.secondarySystemFill,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: appData.selectedCollection?.elements.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print("element ${appData.selectedCollection!.elements[index].name} tapped");
                  appData.setSelectedCollectionElement(appData.selectedCollection!.elements[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: appData.selectedElement == appData.selectedCollection!.elements[index]
                            ? CupertinoColors.activeBlue
                            : Colors.transparent,
                        width: 4, // Adjust the width of the border as needed
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appData.selectedCollection!.elements[index].name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: CupertinoColors.activeBlue,
                                ),
                              ),
                              Text(
                                "${appData.selectedCollection!.elements[index].percentage} %",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          // Handle delete button tap action here
                          print("delete element!!!!");
                          
                        },
                        child: const Icon(
                          CupertinoIcons.clear,
                          color: CupertinoColors.systemRed,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
        ),
      ],
    );

  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
