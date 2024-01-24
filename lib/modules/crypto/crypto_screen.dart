import 'package:flutter/material.dart';
import 'package:view_model_x/view_model_x.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/models/crypto/crypto_model.dart';
import 'package:weather_crypto_app_flutter/modules/crypto/crypto_viewmodel.dart';

class CryptoScreen extends StatefulWidget {
  CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  bool isSearching = false;
  final CryptoViewModel viewModel = locator<CryptoViewModel>();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching? _buildSearchAppBar() : _buildDefaultAppBar(),
      body: StateFlowBuilder(
        stateFlow: viewModel.listCryptoStateFlow,
        builder: (context, List<CryptoItemModel> items) {
          return Container(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
                            child: Image.network(
                                width: 44.0,
                                height: 44.0,
                                items[index].image
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                                style: const TextStyle(
                                  fontSize: 20
                                ),
                                items[index].name
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Checkbox(
                              value: items[index].isChecked,
                              onChanged: (newValue) {
                                setState(() {
                                  _changeCryptoInformation(items[index]);
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Container(
                      height: 1.0,
                      color: Colors.black12,
                      width: double.infinity,
                    ),
                  ],
                  );
                }
            ),
          );
        },
      )
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
          'Криптовалюты'
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
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
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

  void _changeCryptoInformation(CryptoItemModel cryptoItem) {
    viewModel.changeStateOfList(cryptoItem);
  }

  void _searchQuery(String query) {
    viewModel.searchQuery(query);
  }
}