import 'dart:async';

import 'package:flutter/material.dart';
import 'package:view_model_x/view_model_x.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/models/main/main_model.dart';
import 'package:weather_crypto_app_flutter/modules/crypto/crypto_screen.dart';
import 'package:weather_crypto_app_flutter/modules/main/main_helper.dart';
import 'package:weather_crypto_app_flutter/modules/main/main_viewmodel.dart';
import 'package:weather_crypto_app_flutter/modules/replace/replace_screen.dart';
import 'package:weather_crypto_app_flutter/modules/weathermap/weather_map_screen.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

late MainViewModel _viewModel;
late MainHelper _helper;

Future<void> main() async {
  await setupLocator();
  _viewModel = locator<MainViewModel>();
  _helper = locator<MainHelper>();
  runApp(const MyApp());
  await _viewModel.initSharedPref();
  _viewModel.collectStates();
  _startUpdateTimer();
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

  late final YandexMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: StateFlowBuilder(
        stateFlow: _viewModel.menuListStateFlow,
        builder: (context, List<MainMenuModel> menuList) {
          return ListView.builder(
            itemCount: menuList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.black12,
                height: 225,
                width: double.infinity,
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 8.0),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 16.0, bottom: 5.0),
                            child: Text(menuList[index].nameCard),
                          ),
                          const Spacer(),
                          Visibility(
                            visible: _helper.conditionButtonsVisible(menuList[index], false),
                            child: Container(
                              width: 33,
                              height: 33,
                              child: IconButton(
                                iconSize: 16,
                                color: Colors.lightBlueAccent,
                                icon: const Icon(Icons.settings),
                                onPressed: () {
                                  _navigateToChoose(menuList[index].typeCard, context);
                                },
                              ),
                            )
                          )
                        ],
                      ),
                      Container(
                        height: 1.0,
                        color: Colors.black12,
                        width: double.infinity,
                      ),
                      Visibility( // Crypto info
                          visible: _helper.conditionShowCrypto(menuList[index]),
                          child: _buildCryptoList()
                      ),
                      Visibility( // Weather info
                          visible: _helper.conditionShowWeather(menuList[index]),
                          child: _buildWeatherView(menuList[index])
                      ),
                      Visibility( // Map info
                          visible: _helper.conditionShowMap(menuList[index]),
                          child: _buildMapView(menuList[index])
                      ),
                      const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                child: Visibility(
                                  visible: _helper.conditionButtonsVisible(menuList[index], true),
                                  child: TextButton(
                                    onPressed: () {
                                      _navigateToChoose(menuList[index].typeCard, context);
                                    },
                                    child: _helper.buildTextTitle('Выбрать', 17)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.lightBlueAccent,
      title: const Text(
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
          'Главный экран'
      ),
      centerTitle: true,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReplaceScreen())
              ).then((value) {
                _viewModel.collectStates();
              });
            },
            child: const Text(
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
                'Править'
            )
        )
      ],
    );
  }

  Container _buildMapView(MainMenuModel item) {
    return Container(
      height: 159,
      width: 320,
      child: Card(
        child: YandexMap(
          onMapCreated: (controller) async {
            _mapController = controller;
            await _mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: Point(
                      latitude: item.mapCityName!.lat,
                      longitude: item.mapCityName!.lon,
                    ),
                    zoom: 9,
                  )
              ),
            );
          },
          mapObjects: _getPlaceMarkObjects(context),
        ),
      ),
    );
  }

  StateFlowBuilder<List<MenuCryptoModel>> _buildCryptoList() {
    return StateFlowBuilder(
      stateFlow: _viewModel.menuCryptoListStateFlow,
      builder: (context, List<MenuCryptoModel> cryptoList) {
        return Container(
            height: 159,
            width: 320,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cryptoList.length,
                itemBuilder: (BuildContext context, int cryptoIndex) {
                  return Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                    cryptoList[cryptoIndex].name
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Image.network(
                                    width: 60.0,
                                    height: 60.0,
                                    cryptoList[cryptoIndex].image
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    style: const TextStyle(
                                        fontSize: 12
                                    ),
                                    cryptoList[cryptoIndex].price
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Text(
                                        style: TextStyle(
                                            color: cryptoList[cryptoIndex].changes >= 0? Colors.green: Colors.red,
                                            fontSize: 12
                                        ),
                                        cryptoList[cryptoIndex].changes.toStringAsFixed(4)
                                    ),
                                  ),
                                  Visibility(
                                      visible: cryptoList[cryptoIndex].changes >= 0,
                                      child: const Icon(
                                          size: 14,
                                          color: Colors.green,
                                          Icons.arrow_upward
                                      )
                                  ),
                                  Visibility(
                                      visible: cryptoList[cryptoIndex].changes < 0,
                                      child: const Icon(
                                          size: 14,
                                          color: Colors.red,
                                          Icons.arrow_downward
                                      )
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                  );
                }
            )
        );
      },
    );
  }

  Container _buildWeatherView(MainMenuModel item) {
    return Container(
      height: 159,
      width: 320,
      child: Card(
        color: Colors.lightBlueAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10.0),
              child: Text(
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                  _helper.getNullOrNotText(item.weatherInfo?.nameTown)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: _helper.buildTextDescription(item.weatherInfo?.weatherName, 13)
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(
                              width: 60.0,
                              height: 60.0,
                              _helper.getNullOrNotText(item.weatherInfo?.icon)
                          ),
                          Text(
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              _helper.getNullOrNotText(item.weatherInfo?.currentTemp)
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _helper.buildTextTitle('Ощущается как '),
                          _helper.buildTextDescription(item.weatherInfo?.feelsLike, 13)
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: _helper.buildTextTitle('Ветер')
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: _helper.buildTextDescription(item.weatherInfo?.wind)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: _helper.buildTextTitle('Давление')
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: _helper.buildTextDescription(item.weatherInfo?.pressure)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: _helper.buildTextTitle('Влажность')
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: _helper.buildTextDescription(item.weatherInfo?.humidity)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: _helper.buildTextTitle('Облачность')
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: _helper.buildTextDescription(item.weatherInfo?.cloudy)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: _helper.buildTextTitle('Видимость')
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: _helper.buildTextDescription(item.weatherInfo?.visibility)
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<PlacemarkMapObject> _getPlaceMarkObjects(BuildContext context) {
      return _viewModel.getTownsList().map(
          (point) => PlacemarkMapObject(
            mapId: MapObjectId('MapObject ${point.townName}'),
            point: Point(latitude: point.cordX, longitude: point.cordY),
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                  'assets/icons/map_point.png',
                ),
                scale: 0.7,
              ),
            ),
          )
      ).toList();
  }

  void _navigateToChoose(TypeCard typeCard, BuildContext context) {
    switch(typeCard) {
      case TypeCard.crypto:
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CryptoScreen())
        ).then((value) {
          _viewModel.collectStates();
          _startUpdateTimer();
        });
        break;
      case TypeCard.map:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WeatherMapScreen(),
                settings: const RouteSettings(arguments: TypeCard.map)
            )
        ).then((value) {
          _viewModel.collectStates();
        });
        break;
      case TypeCard.weather:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WeatherMapScreen(),
                settings: const RouteSettings(arguments: TypeCard.weather)
            )
        ).then((value) {
          _viewModel.collectStates();
        });
        break;
    }
  }
}

void _startUpdateTimer() {
  Timer.periodic(const Duration(seconds: 60), (Timer timer) {
    _viewModel.collectStates();
    if(_viewModel.checkEmptyCrypto()) {
      timer.cancel();
    }
  });
}