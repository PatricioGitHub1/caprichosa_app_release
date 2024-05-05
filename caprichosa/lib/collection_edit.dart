import 'package:caprichosa/app_data.dart';
import 'package:caprichosa/collection.dart';
import 'package:caprichosa/collection_element.dart';
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
          color: Color.fromARGB(237, 15, 15, 221),
          width: double.infinity,
          child: Stack(
            children: [
              // Content to show when the boolean is true
              if (appData.selectedElement != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Your tag widget
                    SizedBox(
                      height: 50, // Adjust height as needed
                      child: Container(
                        color: Colors.green, // Adjust color as needed
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust padding as needed
                                  child: Text(
                                    appData.selectedElement!.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            Tooltip(
                              message: 'Add element',
                              child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  CollectionElement newElement = CollectionElement('Element', null, 0.0, appData.generateRandomColor());

                                  // Delay the scrolling animation slightly to allow time for layout update
                                  Future.delayed(const Duration(milliseconds: 2000), () {
                                    _scrollController.animateTo(
                                      _scrollController.position.maxScrollExtent,
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeOut,
                                    );
                                  });

                                },
                                child: const Icon(CupertinoIcons.add_circled_solid),
                              ),
                            ),
                            SizedBox(width: 8), // Add some space between buttons
                            Tooltip(
                              message: 'Save element',
                              child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  print('elemento guardado!!');
                                },
                                child: const Icon(CupertinoIcons.floppy_disk),
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                    SizedBox(height: 20), // Spacer
                    // Your text field with placeholder text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CupertinoTextField()
                    ),
                  ],
                ),
              // Content to show when the boolean is false
              if (appData.selectedElement == null)
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the children horizontally
                    children: [
                      const Text(
                        'Select or create an item',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Tooltip(
                        message: 'Add Element',
                        child: CupertinoButton(       
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            CollectionElement newElement = CollectionElement('Element', null, 0.0, appData.generateRandomColor());
                            appData.addCollectionElement(newElement);
                            // Delay the scrolling animation slightly to allow time for layout update
                            Future.delayed(const Duration(milliseconds: 2000), () {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                              );
                            });
                          },
                          child: const Icon(CupertinoIcons.add_circled_solid, color: CupertinoColors.systemRed,),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
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
                              Row(children: [
                                  Container(
                                    width: 10, // Adjust width of the colored rectangle as needed
                                    height: 10, // Adjust height of the colored rectangle as needed
                                    color: appData.selectedCollection!.elements[index].color ?? Colors.transparent,
                                  ),
                                  const Padding(padding: EdgeInsets.only(left: 10, right:5)),
                                  Text(
                                    "${appData.selectedCollection!.elements[index].percentage} %",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                ]
                              ,)
                              
                            ],
                          ),
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          // Handle delete button tap action here
                          print("delete element!!!!");
                          appData.closeCollectionElement(appData.selectedCollection!.elements[index]);
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
