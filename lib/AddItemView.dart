//import 'dart:js';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api.dart';

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
          _content(),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(
                  context, Items(message: controller.text, done: false));
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

Widget _content() {
  return ElevatedButton(
    child: Text('Hej'),
    onPressed: () {
      _dostuff();
    },
  );
}

void _dostuff() async {
  var result = await _fetchstuffFromInternet();
  print(result);
}

Future<String> _fetchstuffFromInternet() async {
  http.Response response = await http.get(Uri.parse(
      'https://todoapp-api.apps.k8s.gu.se/todos?key=4332f801-310e-4e3e-88c3-d179d6fdfba4'));
  return response.body;
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
  String _filterBy = 'all';
  List<Items> get list => _list;
  String get filterBy => _filterBy;

  void addItems(Items items) async {
    _list = await Api.addItems(items);
    notifyListeners();
  }

  void removeItem(items) {
    Api.removeItem(items.id);
    _list.remove(items);
    notifyListeners();
  }

  void checkItem(item) {
    item.done = !item.done;
    notifyListeners();
  }

  void setFilterBy(filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }
}
