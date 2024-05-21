import 'package:countdown/data/ippt_tables.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class IPPT_Provider extends ChangeNotifier {
  final _myBox = Hive.box("mybox");

  double age = Hive.box("mybox").get("age", defaultValue: 19.0);
  int ageGroup = Hive.box("mybox").get("age group", defaultValue: 1);

  double pushUps = Hive.box("mybox").get("pushups", defaultValue: 20.0);

  double sitUps = Hive.box("mybox").get("situps", defaultValue: 30.0);

  double runningTime = Hive.box("mybox").get("2.4km", defaultValue: 660.0);

  int score = Hive.box("mybox").get("score", defaultValue: 100);

  void updatePushups(double value) {
    pushUps = value;
    _myBox.put("pushups", value);

    notifyListeners();
  }

  void updateSitups(double value) {
    sitUps = value;
    _myBox.put("situps", value);
    notifyListeners();
  }

  void updateRunning(double value) {
    runningTime = value;
    _myBox.put("2.4km", value);
    notifyListeners();
  }

  void updateAge(double value) {
    age = value;
    _myBox.put("age", value);

    if (age <= 22) {
      _myBox.put("age group", 1);
      ageGroup = 1;
    } else if (age <= 24) {
      _myBox.put("age group", 2);
      ageGroup = 1;
    } else if (age <= 27) {
      _myBox.put("age group", 3);
      ageGroup = 3;
    } else {
      _myBox.put("age group", 4);
      ageGroup = 4;
    }

    notifyListeners();
  }

  void updateAgeGroup(int value) {
    ageGroup = value;
    _myBox.put("age group", value);
    notifyListeners();
  }

  void calculateScore() {
    final tablePushups = pushupTable[ageGroup]!;
    final tableSitups = situpTable[ageGroup]!;
    final tableRunning = runningTable[ageGroup]!;

    int total_score = 0;
    try {
      int push_up_score = tablePushups[pushUps.round()];
      total_score += push_up_score;
    } catch (e) {
      total_score += 25;
    }

    try {
      int sit_up_score = tableSitups[sitUps.round()];
      total_score += sit_up_score;
    } catch (e) {
      total_score += 25;
    }

    double time_tracker = 1100;
    bool score_tabulated = false;

    for (var i = 0; i < tableRunning.length; i++) {
      if (runningTime <= time_tracker) {
        time_tracker -= 10;
      } else {
        score_tabulated = true;
        total_score += tableRunning[i];
        break;
      }
    }

    if (!score_tabulated) {
      total_score += 50;
    }

    _myBox.put("score", total_score);
    score = total_score;
  }
}
