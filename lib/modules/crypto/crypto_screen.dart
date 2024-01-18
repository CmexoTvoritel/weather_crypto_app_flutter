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
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Image.network(
                                width: 24.0,
                                height: 24.0,
                                items[index].image
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
                            child: Text(items[index].name),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Checkbox(
                              value: items[index].isChecked,
                              onChanged: (newValue) {
                                setState(() {
                                  _changeCryptoInformation(items[index], index);
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

  void _changeCryptoInformation(CryptoItemModel cryptoItem, int index) {
    viewModel.changeStateOfList(cryptoItem, index);
  }
  
}