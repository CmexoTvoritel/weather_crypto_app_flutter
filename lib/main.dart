import 'package:flutter/material.dart';
import 'package:view_model_x/view_model_x.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/models/main/main_model.dart';
import 'package:weather_crypto_app_flutter/modules/crypto/crypto_screen.dart';
import 'package:weather_crypto_app_flutter/modules/main/main_viewmodel.dart';
import 'package:weather_crypto_app_flutter/modules/weathermap/weather_map_screen.dart';
import 'package:weather_crypto_app_flutter/preferences/shared_preferences.dart';

late MainViewModel _viewModel;
late SharedPref _sharedPref;

Future<void> main() async {
  await setupLocator();
  _viewModel = locator<MainViewModel>();
  _sharedPref = locator<SharedPref>();
  runApp(const MyApp());
  await _sharedPref.init();
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
      body: StateFlowBuilder(
        stateFlow: _viewModel.menuListStateFlow,
        builder: (context, List<MainMenuModel> menuList) {
          return ListView.builder(
            itemCount: menuList.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [ //TODO: Visibility like container
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
