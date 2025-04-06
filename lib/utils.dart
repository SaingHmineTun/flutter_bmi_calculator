import 'dart:math';

Map<String, String> bodyMassIndex = {
  "underweight":
      "You are UNDERWEIGHT.\n"
      "Body weight is lower than what's considered healthy.\n"
      "Likely risks:\n"
      "\t- Nutritional deficiencies (e.g. anemia)\n"
      "\t- Weak immune system\n"
      "\t- Fertility issues\n"
      "\t- Higher risk of osteoporosis\n"
      "\t- Fatigue, lower productivity",
  "normal":
      "You are in NORMAL WEIGHT.\n"
      "Healthy body weight for your height.\n"
      "Likely health status:\n"
      "\t- Lowest risk for chronic diseases\n"
      "\t- Good energy levels\n"
      "\t- Lower risk for heart disease, diabetes, and high blood pressure",
  "overweight":
      "You are OVERWEIGHT.\n"
      "Slightly above healthy weight. Not yet obese, but risk is rising.\n"
      "Likely risks:\n"
      "\t- Increased chance of developing:\n"
      "\t\t- Type 2 diabetes\n"
      "\t\t- Hypertension (high BP)\n"
      "\t\t- Heart disease\n"
      "\t- Early warning to manage diet & activity",
  "obese1":
      "You are OBESE CLASS I.\n"
      "Body fat is at a level harmful to health.\n"
      "High risk of:\n"
      "\t- Diabetes\n"
      "\t- Cardiovascular disease (heart attacks, strokes)\n"
      "\t- Metabolic syndrome\n"
      "\t- Sleep apnea\n"
      "Joint problems, back pain",
  "obese2":
      "You are OBESE CLASS II.\n"
      "Severe obesity.\n"
      "Very high risk of:\n"
      "\t- Severe heart disease\n"
      "\t- Stroke\n"
      "\t- Certain cancers (breast, colon)\n"
      "\t- Fatty liver disease\n"
      "\t- Mobility limitations\n"
      "\t- Early mortality",
};

double calculateBmi({required int weight, required int height}) {
  return 703 * (weight / pow(height, 2));
}

String getBmiLevel(double bmi) {
  String key;
  if (bmi < 18.5) {
    key = "underweight";
  } else if (bmi < 22.9) {
    key = "normal";
  } else if (bmi < 24.9) {
    key = "overweight";
  } else if (bmi < 29.9) {
    key = "obese1";
  } else {
    key = "obese2";
  }
  return key;
}
