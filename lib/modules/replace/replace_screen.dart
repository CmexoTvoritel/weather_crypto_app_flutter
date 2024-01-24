import 'package:flutter/material.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/modules/replace/replace_view_model.dart';

class ReplaceScreen extends StatefulWidget {
  ReplaceScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ReplaceScreenState();

}

class _ReplaceScreenState extends State<ReplaceScreen> {
  final ReplaceViewModel _viewModel = locator<ReplaceViewModel>();
  late List<String> menuList;

  @override
  void initState() {
    menuList = _viewModel.getCurrentMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            'Главный экран'
        ),
        actions: [
          TextButton(
              onPressed: () {
                  saveListAndExit();
              },
              child: const Text(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),
                  'Готово'
              )
          )
        ],
      ),
      body: Card(
        margin: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: menuList.length * 47,
          child: ReorderableListView.builder(
            itemCount: menuList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                key: ValueKey(index),
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 8.0, top: 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                          child: Text(
                              menuList[index]
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
                          child: Icon(
                              Icons.menu
                          ),
                        ),
                      ],
                    ),
                  ),
                  index != 2 ? Container(
                    height: 1.0,
                    margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                    color: Colors.black12,
                    width: double.infinity,
                  ) : Container(),
                ],
              );
            }, onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if(newIndex >= menuList.length) {
                newIndex = 2;
              } else if(newIndex > oldIndex) {
                newIndex = -1;
              }
              final item = menuList.removeAt(oldIndex);
              menuList.insert(newIndex, item);
            });
          },
          ),
        )
      ),
    );
  }

  Future<void> saveListAndExit() async {
    await _viewModel.saveStates(menuList);
    Navigator.pop(context);
  }

}