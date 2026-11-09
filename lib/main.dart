import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Danmarks Private Skoler',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 111, 40, 40))),
      home: const MyHomePage(title: 'Danmarks Private Skoler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

// This method is rerun every time setState is called, for instance as done
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Main title of the app bar, which is an InkWell widget that allows for a tap gesture.
        //Returns to the first route in the navigation stack when tapped. Aka home page
        title: InkWell(
          onTap: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: Image.asset(
          'assets/images/DPS-Logo.png',
          height: 40,
          ),
        ),
        //Smaller round logo, also InkWell for tap gesture, returns to home page when tapped.
         actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Image.asset(
              'assets/images/DPS-Round-Logo.png',
              height: 50,
              ),
            ),
          ),
        ],
      ),
      //Burger menu:
      drawer: Drawer(
        child: ListView(
          // Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.stars),
              title: const Text('Medlemsskolern'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
