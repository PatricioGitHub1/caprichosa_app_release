import 'package:caprichosa/app_data.dart';
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
  late AppData appData;
  TextEditingController textEditingController = TextEditingController();

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
                  print('Added collection');
                },
                child: const Icon(CupertinoIcons.add_circled_solid),
              ),
            ),
          ],
        ),
        backgroundColor: CupertinoColors.darkBackgroundGray,
        border: null,
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
                    color: CupertinoColors.destructiveRed,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            color: CupertinoColors.activeGreen,
                            // Your content for the first container here
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            color: CupertinoColors.systemBlue,
                            // Your content for the second container here
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );

  }

}
