import 'package:flutter/material.dart';
import 'AddItemView.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api.dart';

void main() {
  var state = MyState();
  state.fetchTodos();
  runApp(
    ChangeNotifierProvider(create: (context) => state, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Julias app',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: 'TO DO LIST'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                Provider.of<MyState>(context, listen: false).setFilterBy(value);
              },
              itemBuilder: (context) => [
                    const PopupMenuItem(value: 'all', child: Text('all')),
                    const PopupMenuItem(
                        value: 'Checked', child: Text('Checked')),
                    const PopupMenuItem(
                        value: 'Not Checked', child: Text('Not Checked')),
                  ]),
        ],
      ),
      body: Consumer<MyState>(
          builder: (context, state, child) =>
              ListOfTodos(filterList(state.list, state.filterBy))),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var newItem = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddItemView()));
          if (newItem != null) {
            Provider.of<MyState>(context, listen: false).addItems(newItem);
          }
        },
      ),
    );
  }
}

class Items {
  String id;
  String message;
  bool done;

  Items({required this.message, this.done = false, this.id = ''});

  static Map<String, dynamic> toJson(Items items) {
    return {
      'title': items.message,
      'done': items.done,
    };
  }

  static Items fromJson(dynamic items) {
    return Items(message: items['title'], done: items['done'], id: items['id']);
  }
}

class ListOfTodos extends StatelessWidget {
  final List<Items> list;
  ListOfTodos(this.list);

  Widget build(BuildContext context) {
    return ListView(children: list.map((sak) => _todo(context, sak)).toList());
  }

  Widget _todo(context, sak) {
    return ListTile(
        leading: Checkbox(
          value: sak.done,
          onChanged: (val) {
            Provider.of<MyState>(context, listen: false).checkItem(sak);
          },
        ),
        title: sak.done
            ? Text(sak.message,
                style: const TextStyle(decoration: TextDecoration.lineThrough))
            : Text(sak.message),
        trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              var state = Provider.of<MyState>(context, listen: false);
              state.removeItem(sak);
            }));
  }
}

List<Items> filterList(list, filterBy) {
  if (filterBy == 'all') return list;
  if (filterBy == 'Checked')
    return list.where((item) => item.done == true).toList();
  if (filterBy == 'Not Checked')
    return list.where((item) => item.done == false).toList();
  return list;
}
