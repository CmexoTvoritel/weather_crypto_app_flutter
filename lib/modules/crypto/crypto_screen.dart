import 'package:flutter/cupertino.dart';
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

  final CryptoViewModel viewModel = locator<CryptoViewModel>();
  List<CryptoItemModel> cryptoList = [];

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
      body: StateFlowBuilder(
        stateFlow: viewModel.listCryptoStateFlow,
        builder: (context, List<CryptoItemModel> items) {
          return Container(
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Card(
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(items[index].name)
                        ],
                      ),
                    ),
                  );
                }
            ),
          );
        },
      )
    );
  }
  
}