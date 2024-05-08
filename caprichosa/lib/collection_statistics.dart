import 'package:caprichosa/app_data.dart';
import 'package:caprichosa/collection.dart';
import 'package:caprichosa/spin_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_desktop_kit/cdk_button.dart';
import 'package:provider/provider.dart';

class CollectionStatistics extends StatefulWidget {
  const CollectionStatistics({Key? key}) : super(key: key);

  @override
  _CollectionStatistics createState() => _CollectionStatistics();
}

class _CollectionStatistics extends State<CollectionStatistics> {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);
    appData.selectedCollection?.setAddedPercentage();
    String message = '';

    if (appData.selectedCollection!.addedPercentage == CollectionAddedPercentage.just0neHundred) {
      message = 'Press the button to start';

    } else if (appData.selectedCollection!.addedPercentage == CollectionAddedPercentage.lessThanOneHundred) {
      double remaining = appData.selectedCollection!.getRemainingPercentageTo100(true);  
      message = 'The items percentages don\'t add up to 100%. The remaining $remaining% will be distributed equally between all elements';

    } else  {
      double excess = appData.selectedCollection!.getRemainingPercentageTo100(false);
      message = 'The items percentages exceed 100%. The $excess% excess will be substracted equally between all elements';
    }
    print("xd");
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top, // Height of the status bar
        ),
        Expanded(
          child: appData.selectedCollection!.elements.isEmpty
              ?  const Center( 
                    child: Text( 'To add spin you need at least one item in the collection',
                    style: TextStyle(color: CupertinoColors.systemRed),)
                  )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(message),
                        SizedBox(height: 20), // Add space between text and button
                        CDKButton(
                          style: CDKButtonStyle.action,
                          isLarge: true,
                          onPressed: () {
                            print("empezar ruleta");
                            appData.startSpinProcess();
                            print("to roulette");
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => const PopScope(canPop: false, child: SpinLayout())
                              ),
                            );
                          },
                          child: const Text('Spin'),
                        ),
                      ],
                    ),
                  ),
                )
        ),
      ],
    );
  }


}