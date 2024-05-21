import 'package:countdown/provider/utilitiyProvider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class CounterProvider extends ChangeNotifier {
  final _myBox = Hive.box("mybox");

  String enlistmentDate = Hive.box("mybox").get(
    "Enlistment Date",
    defaultValue: "NOT ENTERRED YET",
  );
  String ordDate = Hive.box("mybox").get(
    "ORD Date",
    defaultValue: "NOT ENTERRED YET",
  );
  String promotionDate = Hive.box("mybox").get(
    "Promotion Date",
    defaultValue: "NOT ENTERRED YET",
  );

  int totalDays = Hive.box("mybox").get("total days", defaultValue: 365);

  int remainingDays =
      Hive.box("mybox").get("remaining days", defaultValue: 365);

  int payDay = Hive.box("mybox").get(
    "pay day",
    defaultValue: 8,
  );

  int daystoPromotion = Hive.box("mybox").get(
    "days to promotion",
    defaultValue: 365,
  );

  double leaves = Hive.box("mybox").get(
    "leaves",
    defaultValue: 14.0,
  );

  double offs = Hive.box("mybox").get(
    "offs",
    defaultValue: 0.0,
  );

  void changeEnlistmentDate(String value) {
    _myBox.put("Enlistment Date", value);
    enlistmentDate = value;
    notifyListeners();
  }

  void changeORDDate(String value) {
    _myBox.put("ORD Date", value);
    ordDate = value;
    notifyListeners();
  }

  void chnagePromotionDate(String value) {
    _myBox.put("Promotion Date", value);
    promotionDate = value;
    notifyListeners();
  }

  void changeTotalDays(String EnlistmentDate, String ORDDate) {
    Duration total_days1 =
        DateTime.parse(ORDDate).difference(DateTime.parse(EnlistmentDate));

    totalDays = total_days1.inDays;
    _myBox.put("total days", total_days1.inDays);

    notifyListeners();
  }

  void changeDaysToPromotion(int value) {
    _myBox.put("days to promotion", value);
    daystoPromotion = value;
    notifyListeners();
  }

  bool isPromoted() {
    return daystoPromotion <= 0;
  }

  int calculateWorkingDays() {
    final ORDDate = Hive.box("mybox").get("ORD Date");

    if (ORDDate != null && _myBox.get("remaining days") != null) {
      DateTime now = UtilityProvider().getCurrentTime();
      int start = now.weekday;
      int days_remaining = remainingDays;

      int working_days = 0;

      for (var i = days_remaining; i > 0; i--) {
        start++;
        if (start >= 8) {
          start = 1;
        }

        if (start <= 5) {
          working_days++;
        }
      }

      return working_days;
    }
    return 0;
  }

  void changeRemainingDays() {
    final ORDDate = Hive.box("mybox").get("ORD Date");

    if (ORDDate != null) {
      Duration remaining_time = DateTime.parse(ORDDate)
          .difference(UtilityProvider().getCurrentTime());

      int daysRemaining = remaining_time.inDays;

      remainingDays = daysRemaining;

      _myBox.put("remaining days", remainingDays);
    }
  }

  void changePayday(value) {
    if (value != null && value != "") {
      value = int.parse(value);

      payDay = value;
      _myBox.put("pay day", value);
      notifyListeners();
    }
  }

  void changeLeaves(value) {
    if (value != null) {
      leaves = value;
      _myBox.put("leaves", value);
      notifyListeners();
    }
  }

  void changeOffs(value) {
    if (value != null) {
      offs = value;
      _myBox.put("offs", value);
      notifyListeners();
    }
  }

  bool isORD() {
    return remainingDays <= 0;
  }
}
