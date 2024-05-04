import 'package:caprichosa/app_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeftBar extends StatefulWidget {
  const LeftBar({Key? key}) : super(key: key);

  @override
  _LeftBarState createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar> {
  late AppData appData;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    appData = Provider.of<AppData>(context);

    return SizedBox(
      width: 300, // Adjust the width of the left bar as needed
      child: CupertinoScrollbar(
        controller: _scrollController,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: appData.collections.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print("Collection tapped");
                appData.setSelectedCollection(appData.collections[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: appData.selectedCollection == appData.collections[index]
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
                              appData.collections[index].name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.activeBlue,
                              ),
                            ),
                            Text(
                              appData.collections[index].lastModificationDate != null
                                  ? "Last updated: ${appData.collections[index].lastModificationDate}"
                                  : "Unsaved",
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
                        print("delete collection");
                        appData.closeCollection(appData.collections[index]);
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
        )

      ),
    );
  }
}


