import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'TIG333 TODO'),
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
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          _checkboxRow(),
          _checkboxRow(),
          _checkboxRow(),
          _checkboxRow(),
          TextButton(
              child: const Text(
                'Klar',
              ),
              onPressed: () {
                debugPrint('Button #1 is clicked!');
              }),
        ],
      ),
    );
  }
}

/*Widget _square() {
  return Container(
    width: 100,
    height: 100,
    margin: const EdgeInsets.all(10),
    decoration:
        BoxDecoration(color: Colors.indigo, border: Border.all(width: 3)),
  );
}

TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter a search term',
        ),
      ),

Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child:
            TextField(decoration: InputDecoration(hintText: 'Need to be done')),*/

Widget _checkboxRow() {
  return Row(
    children: [
      Checkbox(value: false, onChanged: (val) {}),
      const Text('Needs to be Done'),
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {},
      ),
    ],
  );
}

/*Widget _addButton () {
  return Container(
    child: TextButton(
          child: const Text(
            'Klar',
          ),
          onPressed: () {
            debugPrint('Button #1 is clicked!');
          }) ,
  );
}*/
