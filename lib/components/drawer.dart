import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void goToSettings() {
    context.pop();
    context.pushNamed("settings");
  }

  void goToIPPT() {
    context.pop();
    context.pushNamed("IPPT");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      color: const Color.fromRGBO(25, 25, 25, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Icon(
            Icons.person,
            size: 100,
            color: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(25, 25, 25, 1)),
            ),
            onPressed: goToSettings,
            child: const Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.settings,
                  size: 35,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Khand",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all(
                const Color.fromRGBO(25, 25, 25, 1),
              ),
            ),
            onPressed: goToIPPT,
            child: const Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.calculate,
                  size: 35,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "IPPT Calculator",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Khand",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
