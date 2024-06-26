import 'dart:async';
import 'dart:convert';

import 'package:caprichosa/app_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SpinLayout extends StatefulWidget {
  const SpinLayout({Key? key}) : super(key: key);

  @override
  _SpinLayout createState() => _SpinLayout();
}

class _SpinLayout extends State<SpinLayout> {
  late AppData appData;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCenterItem(appData.totalRouletteComponents - 10);
      print("selected element: ${appData.rouletteComponents[appData.totalRouletteComponents - 10].name}");
    });

    Timer(Duration(seconds: 4), () {
      print("The spin has ended");
      _showAlertDialog(context);
      //Navigator.pop(context);

    });
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }
  
  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(appData.rouletteComponents[appData.totalRouletteComponents - 10].name),
        content: Column(children: [
          appData.rouletteComponents[appData.totalRouletteComponents - 10].imageBase64 != null
            ? Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              child: FractionallySizedBox(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: Image.memory(
                base64.decode(appData.rouletteComponents[appData.totalRouletteComponents - 10].imageBase64!),
                fit: BoxFit.contain,
              ),
          )) : Container()
        ],),
        //const Text('Proceed with destructive action?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              goBack(context);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void _scrollToCenterItem(int index) {
    double itemExtent = MediaQuery.of(context).size.height * 0.40 + 8; // Item height + margin
    double targetOffset = index * itemExtent + (MediaQuery.of(context).size.width - MediaQuery.of(context).size.height * 0.40) / 3;
    
    _scrollController.animateTo(
      targetOffset,
      duration: Duration(seconds: 3), // Adjust duration as needed
      curve: Curves.easeInOutQuad, // Adjust curve as needed
    );
    
  }

  @override
  Widget build(BuildContext context) {
    appData = Provider.of<AppData>(context);
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    Color backgroundColor = brightness == Brightness.light ? CupertinoColors.white : CupertinoColors.darkBackgroundGray;
    return Container(
      color: backgroundColor, // Set background color here
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.20, // Adjust height as needed
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: appData.rouletteComponents.length,
            itemBuilder: (context, index) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.height * 0.40,
                margin: const EdgeInsets.all(8), // Add margin between items
                color: appData.rouletteComponents[index].color, // Example color
                child: Center(
                  child: Text(appData.rouletteComponents[index].name),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
