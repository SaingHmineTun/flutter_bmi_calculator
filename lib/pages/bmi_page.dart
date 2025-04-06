import 'dart:math';

import 'package:bmi_calculator/my_shared_preference.dart';
import 'package:bmi_calculator/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  late double _deviceWidth, _deviceHeight;
  late int _age;
  late int _weight;
  late int _height;
  late int _gender;

  late MySharedPreference _pref;

  @override
  void initState() {
    super.initState();
    _pref = GetIt.instance.get<MySharedPreference>();
    _age = _pref.getData(_pref.age) ?? 18;
    _weight = _pref.getData(_pref.weight) ?? 100;
    _height = _pref.getData(_pref.height) ?? 60;
    _gender = _pref.getData(_pref.gender) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SizedBox(
        width: _deviceWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_ageWidget(), _weightWidget()],
            ),
            _heightWidget(),
            _genderWidget(),
            _calculateButton(),
          ],
        ),
      ),
    );
  }

  Widget _cardView({
    required String title,
    required double width,
    required Widget value,
    required Widget children,
  }) {
    return Container(
      width: width,
      constraints: BoxConstraints(maxWidth: 300),
      child: Card(
        color: CupertinoColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        shadowColor: CupertinoColors.systemIndigo,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: "AJ-Kunheing-06",
                ),
              ),
              value,
              children,
            ],
          ),
        ),
      ),
    );
  }

  Widget _weightWidget() {
    return _cardView(
      title: "Weight (pounds)",
      value: Text(
        _weight.toString(),
        style: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w600,
          fontFamily: "AJ-Kunheing-06",
        ),
      ),
      width: _deviceWidth * 0.45,
      children: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _weight--;
              });
            },
            icon: Icon(
              CupertinoIcons.minus,
              size: 15,
              color: CupertinoColors.destructiveRed,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _weight++;
              });
            },
            icon: Icon(
              CupertinoIcons.plus,
              size: 15,
              color: CupertinoColors.activeBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _genderWidget() {
    return _cardView(
      title: "Gender",
      width: _deviceWidth * 0.95,
      value: Image.asset(
        width: 75,
        height: 75,
        "assets/images/${_gender == 0 ? "man.png" : "woman.png"}",
      ),
      children: CupertinoSlidingSegmentedControl(
        groupValue: _gender,
        onValueChanged: (newValue) {
          setState(() {
            if (newValue != null) _gender = newValue;
          });
        },
        children: {
          0: Text("Male", style: TextStyle(fontFamily: "AJ-Kunheing-06")),
          1: Text("Female", style: TextStyle(fontFamily: "AJ-Kunheing-06")),
        },
      ),
    );
  }

  Widget _heightWidget() {
    String feet = "${(_height / 12).toInt()} ft";
    int inches = (_height % 12).toInt();
    if (inches != 0) feet += " $inches in";

    return _cardView(
      title: "Height (inches)",
      value: Text(
        feet,
        style: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w600,
          fontFamily: "AJ-Kunheing-06",
        ),
      ),
      width: _deviceWidth * 0.95,
      children: SizedBox(
        width: _deviceWidth * 0.8,
        child: CupertinoSlider(
          value: _height.toDouble(),
          min: 30,
          max: 100,
          onChanged: (newValue) {
            setState(() {
              _height = newValue.toInt();
            });
          },
        ),
      ),
    );
  }

  Widget _ageWidget() {
    return _cardView(
      title: "Age (years)",
      value: Text(
        _age.toString(),
        style: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w600,
          fontFamily: "AJ-Kunheing-06",
        ),
      ),
      width: _deviceWidth * 0.45,
      children: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _age--;
              });
            },
            icon: Icon(
              CupertinoIcons.minus,
              size: 15,
              color: CupertinoColors.destructiveRed,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _age++;
              });
            },
            icon: Icon(
              CupertinoIcons.plus,
              size: 15,
              color: CupertinoColors.activeBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _calculateButton() {
    return CupertinoButton.filled(
      onPressed: () {
        double bmi = calculateBmi(weight: _weight, height: _height);
        _pref
            .writeData(
              height: _height,
              weight: _weight,
              age: _age,
              gender: _gender,
            )
            .then((success) {
              if (success) {
                _showBmiDialog(bmi);
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Something went wrong")));
              }
            });
      },
      child: const Text("Calculate BMI", style: TextStyle(fontSize: 16)),
    );
  }

  void _showBmiDialog(double bmi) {
    String key = getBmiLevel(bmi);
    showCupertinoDialog(
      context: context,
      builder:
          (ctx) => CupertinoAlertDialog(
            title: Text(
              "Body Mass Index",
              style: TextStyle(fontFamily: "AJ-Kunheing-06", fontSize: 22),
            ),
            content: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "Your BMI is ${bmi.toStringAsFixed(2)}.\n${bodyMassIndex[key]!}",
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: "AJ-Kunheing-06", fontSize: 18),
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text("OK"),
                onPressed: () => Navigator.pop(ctx),
              ),
            ],
          ),
    );
  }
}
