import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  final String age = "AGE";
  final String height = "HEIGHT";
  final String weight = "WEIGHT";
  final String gender = "GENDER";
  final String created = "CREATED";

  late SharedPreferences _pref;

  Future<SharedPreferences> init() async {
    _pref = await SharedPreferences.getInstance();
    return _pref;
  }

  Future<bool> writeData({
    required int height,
    required int weight,
    required int age,
    required int gender,
  }) async {
    final results = await Future.wait([
      _pref.setInt(this.age, age),
      _pref.setInt(this.height, height),
      _pref.setInt(this.weight, weight),
      _pref.setInt(this.gender, gender),
      _pref.setInt(created, DateTime.now().millisecondsSinceEpoch)
    ]);

    return results.every((result) => result);
  }

  int? getData(String key) {
    return _pref.getInt(key);
  }
}
