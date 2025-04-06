import 'package:bmi_calculator/my_shared_preference.dart';
import 'package:bmi_calculator/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MySharedPreference pref = MySharedPreference();
  await pref.init();
  GetIt.instance.registerSingleton<MySharedPreference>(pref);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontFamily: "AJ-Kunheing-06");
    return CupertinoApp(
      title: 'BMI Calculator',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemIndigo,
        applyThemeToAll: true,
        textTheme: CupertinoTextThemeData(
          textStyle: textStyle,
          actionSmallTextStyle: textStyle,
          actionTextStyle: textStyle,
          navActionTextStyle: textStyle,
          navLargeTitleTextStyle: textStyle,
          navTitleTextStyle: textStyle,
          tabLabelTextStyle: textStyle,
          dateTimePickerTextStyle: textStyle,
          pickerTextStyle: textStyle,
        ),
      ),
      routes: {"/": (ctx) => HomePage()},
    );
  }
}
