import 'package:bmi_calculator/my_shared_preference.dart';
import 'package:bmi_calculator/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  late MySharedPreference _pref;
  int? weight, height, age, gender, created;

  @override
  Widget build(BuildContext context) {
    _pref = GetIt.instance.get<MySharedPreference>();
    weight = _pref.getData(_pref.weight);
    height = _pref.getData(_pref.height);
    age = _pref.getData(_pref.age);
    gender = _pref.getData(_pref.gender);
    created = _pref.getData(_pref.created);

    return CupertinoPageScaffold(
      child: Center(child: weight == null ? _noData() : _latestInfo()),
    );
  }

  Widget _latestInfo() {
    double bmi = calculateBmi(weight: weight!, height: height!);
    String level = getBmiLevel(bmi);
    String definition = bodyMassIndex[level]!.split("\n")[1];

    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 5,
          children: [
            Text(
              level.substring(0, 1).toUpperCase() +
                  level.substring(1, level.length),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                fontFamily: "AJ-Kunheing-06",
              ),
            ),
            Text(
              bmi.toStringAsFixed(2),
              style: TextStyle(fontFamily: "AJ-Kunheing-06", fontSize: 40),
            ),
            Text(
              definition,
              style: TextStyle(
                fontSize: 12,
                fontFamily: "AJ-Kunheing-06",
                color: CupertinoColors.activeBlue,
              ),
            ),
            Text(
              DateTime.fromMillisecondsSinceEpoch(created!).toString(),
              style: TextStyle(fontFamily: "AJ-Kunheing-06"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noData() {
    return CupertinoActivityIndicator();
  }
}
