import 'dart:js';
import 'package:flutter/material.dart';
import 'main.dart';

class AddItemView extends StatelessWidget {
//  AddItemView();

  TextEditingController controller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('TO DO LIST')),
      ),
      body: Column(
        children: [
          _TextField(),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context, Items(message: controller.text));
            },
            icon: Icon(Icons.save, size: 24.0),
            label: Text('SAVE'), // <-- Text
          ),
        ],
      ),
    );
  }

  Widget _TextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'What are you going to do?',
        ),
      ),
    );
  }
}

/*Widget _AddTextButton() {
  return Container(
    child: ElevatedButton.icon(
      onPressed: () {
        Navigator.pop(context,
        Items(message: message))
      },
      icon: Icon(Icons.save, size: 24.0),
      label: Text('SAVE'), // <-- Text
    ),
  );
}*/

class MyState extends ChangeNotifier {
  List<Items> _list = [Items(message: 'jhgjh')];
  List<Items> get list => _list;
  bool _isChecked = false;

  void addItems(Items items) {
    _list.add(items);
    notifyListeners();
  }

  void removeItem(Items items) {
    _list.remove(items);
    notifyListeners();
  }
}
