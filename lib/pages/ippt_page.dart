import 'package:countdown/components/RunningSliderTile.dart';
import 'package:countdown/components/slider_tile.dart';
import 'package:countdown/provider/IPPT_Provider.dart';
import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class IPPT_Page extends StatefulWidget {
  const IPPT_Page({super.key});

  @override
  State<IPPT_Page> createState() => _IPPT_PageState();
}

class _IPPT_PageState extends State<IPPT_Page> {
  @override
  Widget build(BuildContext context) {
    context.read<IPPT_Provider>().calculateScore();
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
      body: ListView(
        padding: const EdgeInsets.all(20),
        shrinkWrap: false,
        children: [
          Center(
            child: Text(
              context.watch<IPPT_Provider>().score.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 100,
                fontFamily: "Khand",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliderTile(
            initialValue: context.watch<IPPT_Provider>().age,
            title: "Age",
            min: 18,
            max: 30,
            onChange: (value) {
              context.read<IPPT_Provider>().updateAge(value);
              context.read<IPPT_Provider>().calculateScore();
            },
            label: true,
          ),
          const SizedBox(height: 15),
          SliderTile(
            initialValue: context.watch<IPPT_Provider>().pushUps,
            title: "Push Ups",
            max: 60,
            onChange: (value) {
              context.read<IPPT_Provider>().updatePushups(value);

              context.read<IPPT_Provider>().calculateScore();
            },
            label: true,
          ),
          const SizedBox(
            height: 15,
          ),
          SliderTile(
            initialValue: context.watch<IPPT_Provider>().sitUps,
            title: "Sit Ups",
            max: 60,
            onChange: (value) {
              context.read<IPPT_Provider>().updateSitups(value);
              context.read<IPPT_Provider>().calculateScore();
            },
            label: true,
          ),
          const SizedBox(
            height: 15,
          ),
          RunningSliderTile(
            initialValue: context.watch<IPPT_Provider>().runningTime,
            title: "2.4km Run",
            onChange: (value) {
              context.read<IPPT_Provider>().updateRunning(value);
              context.read<IPPT_Provider>().calculateScore();
            },
            division: 1000,
            label: true,
            min: 420,
            max: 1200,
          ),
        ],
      ),
    );
  }
}
