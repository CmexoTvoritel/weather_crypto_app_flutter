import 'dart:js';

import 'package:flutter/material.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/models/main/main_model.dart';
import 'package:weather_crypto_app_flutter/modules/crypto/crypto_screen.dart';
import 'package:weather_crypto_app_flutter/modules/weathermap/weather_map_screen.dart';
import 'package:weather_crypto_app_flutter/repository/main_repository.dart';

List<MainMenuModel> menuList = [];
late MainRepository repository;

Future<void> main() async {
  await setupLocator();
  repository = locator<MainRepository>();
  menuList = repository.getMenuList();
  runApp(const MyApp());
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
      body: ListView.builder(
        itemCount: menuList.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(menuList[index].nameCard),
                  TextButton(
                    child: const Text('Выбрать'),
                    onPressed: () { _navigateToChoose(menuList[index].typeCard, context); },
                  )
                ],
              ),

            ),
          );
        },
      )
    );
  }
}

void _navigateToChoose(TypeCard typeCard, BuildContext context) {
  switch(typeCard) {
    case TypeCard.crypto:
      Navigator.push(context, MaterialPageRoute(builder: (context) => CryptoScreen()));
      break;
    case TypeCard.map:
      Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherMapScreen()));
      break;
    case TypeCard.weather:
      Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherMapScreen()));
      break;
  }
}

/* TODO:
1. Implement navigation and 4 new pages
2. Parse UI from Figma for that 4 pages and main page
3. Complete Api responses for crypto and weather
4. Learn how to use RV in flutter and implement it in all pages
5. Improve some things and complete it
 */
