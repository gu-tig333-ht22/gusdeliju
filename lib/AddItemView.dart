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

class MyState extends ChangeNotifier {
  List<Items> _list = [];

  String _filterBy = 'all';
  List<Items> get list => _list;
  String get filterBy => _filterBy;

  void addItems(Items items) async {
    _list = await Api.addItems(items);
    notifyListeners();
  }

  void removeItem(item) async {
    _list = await Api.removeItem(item.id);
    notifyListeners();
  }

  void checkItem(item) async {
    _list = await Api.checkItem(item);
    //item.done = !item.done;
    notifyListeners();
  }

  void setFilterBy(filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }

  void fetchTodos() async {
    _list = await Api.fetchTodos();
    notifyListeners();
    print(_list);
  }
}
