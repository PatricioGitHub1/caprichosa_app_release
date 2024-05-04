import 'package:caprichosa/app_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LeftBar extends StatefulWidget {
  const LeftBar({Key? key}) : super(key: key);

  @override
  _LeftBarState createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar> {
  late AppData appData;

  @override
  Widget build(BuildContext context) {
    appData = Provider.of<AppData>(context);

    return SizedBox(
      width: 250, // Adjust the width of the left bar as needed
      child: CupertinoScrollbar(
        child: ListView.builder(
          itemCount: appData.collections.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                CupertinoButton(
                  onPressed: () {
                    print("selected collections");
                    appData.setSelectedCollection(appData.collections[index]);
                    appData.forceNotifyListeners();
                  },
                  padding: EdgeInsets.zero, // Set padding to zero
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
                        child: Text(
                          appData.collections[index].name,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 8),
                        child: Text(
                          "Last updated: ${appData.collections[index].lastModificationDate}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: CupertinoButton(
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
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
