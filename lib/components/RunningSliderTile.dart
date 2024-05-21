import 'package:countdown/provider/utilitiyProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RunningSliderTile extends StatefulWidget {
  final String title;
  void Function(double value) onChange;
  double min;
  double max;
  int division;
  double initialValue;

  bool label;
  RunningSliderTile({
    super.key,
    required this.initialValue,
    required this.title,
    required this.onChange,
    this.max = 30,
    this.min = 0,
    this.division = 30,
    this.label = false,
  });

  @override
  State<RunningSliderTile> createState() => _RunningSliderTileState();
}

class _RunningSliderTileState extends State<RunningSliderTile> {
  double sliderValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sliderValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Color.fromRGBO(255, 215, 154, 1),
            fontFamily: "Rubik",
          ),
        ),
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromRGBO(255, 215, 154, 1),
            width: 4,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        trailing: widget.label
            ? Text(
                UtilityProvider().getDuration(
                  widget.initialValue.round(),
                ),
                style: const TextStyle(fontSize: 30, fontFamily: "khand"),
              )
            : null,
        subtitle: Slider(
          min: widget.min,
          max: widget.max,
          value: sliderValue,
          onChanged: (value) {
            setState(() {
              sliderValue = value;
            });

            widget.onChange(value);
          },
          divisions: widget.division,
          label: "${widget.initialValue.round()}",
          thumbColor: Colors.grey,
          activeColor: const Color.fromRGBO(255, 215, 154, 1),
          inactiveColor: Colors.white,
          autofocus: true,
          secondaryActiveColor: Colors.black,
        ));
  }
}
