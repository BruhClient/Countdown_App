import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String category;
  final String stat;

  const InfoTile(
      {super.key,
      required this.icon,
      required this.category,
      required this.stat});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        tileColor: const Color.fromRGBO(35, 35, 35, 1),
        title: Text(
          category,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Khand",
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          stat,
          maxLines: 1,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Khand",
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(
          icon,
          size: 40,
        ),
      ),
    );
  }
}
