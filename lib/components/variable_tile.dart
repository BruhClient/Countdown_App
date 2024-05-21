import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  final String title;
  final String subText;
  void Function() onTap;
  MyTile(
      {super.key,
      required this.title,
      required this.subText,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
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
      subtitle: Text(
        subText,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "Rubik",
        ),
      ),
    );
  }
}
