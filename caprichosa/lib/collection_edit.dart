import 'package:caprichosa/collection.dart';
import 'package:flutter/cupertino.dart';

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

    if (widget.collection == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CupertinoTextField(
        controller: _textFieldController,
        placeholder: widget.collection!.name,
      ),
    );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
