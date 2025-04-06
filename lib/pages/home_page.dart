import 'package:bmi_calculator/pages/bmi_page.dart';
import 'package:bmi_calculator/pages/history_page.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Body Mass Index (BMI)",
          style: TextStyle(color: CupertinoColors.black, fontSize: 20),
        ),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.doc_chart),
              label: "History",
            ),
          ],
        ),
        tabBuilder: (ctx, index) {
          return CupertinoTabView(
            builder: (ctx) {
              if (index == 0) {
                return BmiPage();
              } else {
                return HistoryPage();
              }
            },
          );
        },
      ),
    );
  }
}
