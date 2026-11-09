import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:hovedopgave_flutter_app/screen/about_us_screen.dart';
import 'package:hovedopgave_flutter_app/screen/board_screen.dart';
import 'package:hovedopgave_flutter_app/screen/secretariat_screen.dart';
import 'package:hovedopgave_flutter_app/widgets/app_shell.dart';

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
      routes: {
        '/about-us': (context) => const AboutUsScreen(),
        '/board': (context) => const BoardScreen(),
        '/secretariat': (context) => const SecretariatScreen(),
        '/main': (context) => const MyHomePage(title: 'Danmarks Private Skoler'),
      },
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
    return AppShell(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      body: Center(
        //arranges children vertically in a column
        child: Column(
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
