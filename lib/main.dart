import 'package:flutter/material.dart';
import 'AddItemView.dart';
import 'package:provider/provider.dart';
import 'checkbox.dart';

void main() {
  var state = MyState();

  runApp(
    ChangeNotifierProvider(create: (context) => state, child: MyApp()),
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
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
        actions: [
          IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: () {
                //Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => SecondView()));
              }),
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) => ListOfTodos(state.list),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var newItem = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddItemView()));
          Provider.of<MyState>(context, listen: false).addItems(newItem);
        },
      ),
    );
  }
}

class Items {
  String message;

  Items({required this.message});
}

class ListOfTodos extends StatelessWidget {
  final List<Items> list;
  ListOfTodos(this.list);

  Widget build(BuildContext context) {
    return ListView(children: list.map((sak) => _todo(context, sak)).toList());
  }

  Widget _todo(context, sak) {
    return ListTile(
        leading: MyStatefulWidget(),
        title: Text(sak.message),
        trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              var state = Provider.of<MyState>(context, listen: false);
              state.removeItem(sak);
            }));
  }
}
