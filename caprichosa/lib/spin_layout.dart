import 'package:caprichosa/app_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SpinLayout extends StatefulWidget {
  const SpinLayout({Key? key}) : super(key: key);

  @override
  _SpinLayout createState() => _SpinLayout();
}

class _SpinLayout extends State<SpinLayout> {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    Color backgroundColor = brightness == Brightness.light ? CupertinoColors.white : CupertinoColors.darkBackgroundGray;
    return Container(
      color: backgroundColor, // Set background color here
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.20, // Adjust height as needed
          child: ListView.builder(
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