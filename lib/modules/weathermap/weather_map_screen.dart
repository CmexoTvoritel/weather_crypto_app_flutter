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
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  final WeatherMapViewModel viewModel = locator<WeatherMapViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching? _buildSearchAppBar() : _buildDefaultAppBar(),
      body: StateFlowBuilder(
        stateFlow: viewModel.listTownsStateFlow,
        builder: (context, List<TownModel> items) {
          return Container(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      _townChoose(items[index], context, ModalRoute.of(context)?.settings.arguments as TypeCard);
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
                              child: Text(
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  items[index].townShortName
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: Text(
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  items[index].townName
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 1.0,
                          color: Colors.black12,
                          width: double.infinity,
                        )
                      ],
                    ),
                  );
                }
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildDefaultAppBar() {
    return AppBar(
      backgroundColor: Colors.lightBlueAccent,
      title: const Text(
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
          'Выбор города'
      ),
      centerTitle: true,
      leading: IconButton(
        color: Colors.white,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
            color: Colors.white,
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
            icon: const Icon(Icons.search)
        )
      ],
    );
  }

  PreferredSizeWidget _buildSearchAppBar() {
    return AppBar(
      backgroundColor: Colors.lightBlueAccent,
      leading: IconButton(
        color: Colors.white,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            isSearching = false;
          });
        },
      ),
      title: TextField(
        controller: searchController,
        decoration: const InputDecoration(
            hintText: 'Поиск...'
        ),
        onChanged: (query) {
          _searchQuery(query);
        },
      ),
      actions: [
        IconButton(
            color: Colors.white,
            onPressed: () {
              searchController.clear();
              _searchQuery("");
            },
            icon: const Icon(Icons.clear)
        )
      ],
    );
  }

  void _townChoose(TownModel town, BuildContext context, TypeCard type) {
    viewModel.setTownName(town, type);
    viewModel.searchQuery("");
    Navigator.pop(context);
  }

  void _searchQuery(String query) {
    viewModel.searchQuery(query);
  }

}