import 'package:flutter/material.dart';
import 'package:view_model_x/view_model_x.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/models/main/main_model.dart';
import 'package:weather_crypto_app_flutter/models/town/town_model.dart';
import 'package:weather_crypto_app_flutter/modules/weathermap/weather_map_viewmodel.dart';

class WeatherMapScreen extends StatefulWidget {
  WeatherMapScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherMapScreenState();

}

class _WeatherMapScreenState extends State<WeatherMapScreen> {

  final WeatherMapViewModel viewModel = locator<WeatherMapViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateFlowBuilder(
        stateFlow: viewModel.listTownsStateFlow,
        builder: (context, List<TownModel> items) {
          return Container(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            onTap: () {
                              _townChoose(items[index], context);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(items[index].townShortName),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(items[index].townName),
                          ),
                        ],
                      )
                    ],
                  );
                }
            ),
          );
        },
      ),
    );
  }

  void _townChoose(TownModel town, BuildContext context) {
    viewModel.setTownName(town, TypeCard.weather);
    Navigator.pop(context);
  }

}