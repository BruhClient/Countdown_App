import 'package:countdown/components/slider_tile.dart';
import 'package:countdown/components/textfield_tile.dart';
import 'package:countdown/components/variable_tile.dart';
import 'package:countdown/provider/counterProvider.dart';
import 'package:countdown/provider/utilitiyProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController payday_controller = TextEditingController();
  final _myBox = Hive.box("mybox");

  double leaves = Hive.box("mybox").get(
    "leaves",
    defaultValue: 14.0,
  );

  double offs = Hive.box("mybox").get(
    "offs",
    defaultValue: 0.0,
  );

  void updateEnlistmentdate() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(
        const Duration(days: 730),
      ),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value != null) {
          final enlistmentDate = UtilityProvider().formatDateTime(value);
          context.read<CounterProvider>().changeEnlistmentDate(
                enlistmentDate,
              );

          if (_myBox.get("ORD Date") == null) {
            final value1 = value.add(
              const Duration(days: 669),
            );
            final ord = UtilityProvider().formatDateTime(value1);

            context.read<CounterProvider>().changeORDDate(
                  ord,
                );
          }

          updateRemainingDays();
          updateTotalDays();
        }
      },
    );
  }

  void updatePromotionDate() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(
        const Duration(days: 730),
      ),
      lastDate: DateTime.now().add(
        const Duration(days: 730),
      ),
    ).then(
      (value) {
        if (value != null) {
          DateTime now = DateTime.now();

          int days_to_promotion = value.difference(now).inDays + 1;

          String value1 = UtilityProvider().formatDateTime(value);

          context.read<CounterProvider>().chnagePromotionDate(value1);

          context
              .read<CounterProvider>()
              .changeDaysToPromotion(days_to_promotion);
        }
      },
    );
  }

  void updateORDdate() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 730),
      ),
    ).then((value) {
      if (value != null) {
        final ord_date = UtilityProvider().formatDateTime(value);

        context.read<CounterProvider>().changeORDDate(ord_date);

        if (_myBox.get("Enlistment Date") == null) {
          final value1 = value.subtract(
            const Duration(days: 669),
          );
          final enlistment = UtilityProvider().formatDateTime(value1);

          context.read<CounterProvider>().changeEnlistmentDate(enlistment);
        }

        context.read<CounterProvider>().changeTotalDays(
              _myBox.get("Enlistment Date"),
              ord_date,
            );
        updateRemainingDays();
      }
    });
  }

  void updateRemainingDays() {
    context.read<CounterProvider>().changeRemainingDays();
  }

  void updateTotalDays() {
    context.read<CounterProvider>().changeTotalDays(
          _myBox.get("Enlistment Date"),
          _myBox.get("ORD Date"),
        );
  }

  void updatePayDay(String value) {
    context.read<CounterProvider>().changePayday(value);
  }

  void updateLeaves(double value) {
    setState(() {
      leaves = value;
    });
    context.read<CounterProvider>().changeLeaves(value);
  }

  void updateOffs(double value) {
    setState(() {
      offs = value;
    });
    context.read<CounterProvider>().changeOffs(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 39, 39, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            MyTile(
              title: "Enlistment date",
              subText: context.watch<CounterProvider>().enlistmentDate,
              onTap: updateEnlistmentdate,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTile(
              title: "ORD date",
              subText: context.watch<CounterProvider>().ordDate,
              onTap: updateORDdate,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTile(
              title: "Promotion Date",
              subText: context.watch<CounterProvider>().promotionDate,
              onTap: updatePromotionDate,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldTile(
              title: "PAY DAY",
              initialValue: context.watch<CounterProvider>().payDay.toString(),
              onChange: () => updatePayDay(payday_controller.text),
              textEditingController: payday_controller,
            ),
            const SizedBox(
              height: 10,
            ),
            SliderTile(
              initialValue: leaves,
              title: "Leaves",
              onChange: updateLeaves,
            ),
            const SizedBox(height: 10),
            SliderTile(
              initialValue: offs,
              title: "Offs",
              onChange: updateOffs,
            ),
          ],
        ),
      ),
    );
  }
}
