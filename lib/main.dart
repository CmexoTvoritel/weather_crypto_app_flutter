import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Главный экран'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}

/* TODO:
1. Implement navigation and 4 new pages (Saturday)
2. Parse UI from Figma for that 4 pages and main page (Saturday)
3. Complete Api responses for crypto and weather (Saturday)
4. Learn how to use RV in flutter and implement it in all pages (Saturday) (I guess i learn it)
5. Improve some things and complete it (Monday/Tuesday)
 */
