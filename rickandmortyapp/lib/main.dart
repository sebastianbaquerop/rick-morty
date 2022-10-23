import 'package:flutter/material.dart';
import 'package:rickandmortyapp/crossword/screens/crossword_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rickandmortyapp/rick_morty/screens/rick_morty_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      "https://rickandmortyapi.com/graphql",
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(cache: GraphQLCache(), link: httpLink),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Rick & Morty Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blueGrey,
        ),
        home: const MyHomePage(title: 'Rick and Morty App'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Center(child: Text(widget.title)),
          backgroundColor: Colors.black54,
          bottom: const TabBar(tabs: [Text('Crossword'), Text('Rick&Morty')]),
        ),
        body: TabBarView(children: [
          Container(
              decoration: BoxDecoration(color: Colors.black26),
              child: Crossword()),
          Container(
              decoration: BoxDecoration(color: Colors.grey),
              child: RickAndMorty())
        ]),
      ),
    );
  }
}
