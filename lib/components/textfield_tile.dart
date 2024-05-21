import 'package:countdown/input_formatters/range_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldTile extends StatefulWidget {
  final String title;
  void Function() onChange;
  String initialValue;
  final TextEditingController textEditingController;
  TextFieldTile({
    super.key,
    this.initialValue = "",
    required this.title,
    required this.onChange,
    required this.textEditingController,
  });

  @override
  State<TextFieldTile> createState() => _TextFieldTileState();
}

class _TextFieldTileState extends State<TextFieldTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.textEditingController.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title,
        style: TextStyle(
          color: const Color.fromRGBO(255, 215, 154, 1),
          fontFamily: "Rubik",
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: const Color.fromRGBO(255, 215, 154, 1),
          width: 4,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      subtitle: TextFormField(
        controller: widget.textEditingController,
        onChanged: (value) => {widget.onChange()},
        scrollPadding: EdgeInsets.zero,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2),
          CustomRangeTextInputFormatter(),
        ],
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "Khand",
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
