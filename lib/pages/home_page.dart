import 'package:confetti/confetti.dart';
import 'package:countdown/components/drawer.dart';
import 'package:countdown/components/info_tile.dart';
import 'package:countdown/provider/IPPT_Provider.dart';
import 'package:countdown/provider/counterProvider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ConfettiController confettiControllerLeft;
  late ConfettiController confettiControllerRight;

  String getPercentage(completed, total) {
    if (completed >= total) {
      return "100%";
    }
    return "${((completed / total) * 100).floor()}%";
  }

  void OWADIO() {
    confettiControllerLeft.play();
    confettiControllerRight.play();
  }

  String dayDifference(day1) {
    int now = DateTime.now().day;

    if (now > day1) {
      return (day1 + 30 - now).abs().toString();
    }
    return (day1 - now).abs().toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    confettiControllerLeft =
        ConfettiController(duration: const Duration(seconds: 10));

    confettiControllerRight =
        ConfettiController(duration: const Duration(seconds: 10));

    context.read<CounterProvider>().changeRemainingDays();
  }

  @override
  Widget build(BuildContext context) {
    int totalDays = context.watch<CounterProvider>().totalDays;
    int completedDays =
        totalDays - context.watch<CounterProvider>().remainingDays;

    if (totalDays <= completedDays) {
      OWADIO();
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 25, 25, 1),
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: RefreshIndicator(
                color: const Color.fromRGBO(25, 25, 25, 1),
                onRefresh: () async {
                  context.read<CounterProvider>().changeRemainingDays();
                  setState(() {});
                },
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  children: [
                    CircularPercentIndicator(
                      animation: true,
                      animationDuration: 1000,
                      circularStrokeCap: CircularStrokeCap.round,
                      radius: MediaQuery.of(context).size.width / 2.5,
                      lineWidth: 12,
                      percent: completedDays >= totalDays
                          ? 1
                          : (completedDays / totalDays),
                      center: Container(
                        padding: const EdgeInsets.all(80),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(49, 49, 49, 1),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              completedDays >= totalDays
                                  ? "0"
                                  : (totalDays - completedDays).toString(),
                              style: const TextStyle(
                                fontFamily: "Khand",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 70,
                                height: 1,
                              ),
                            ),
                            const Text(
                              "days to ORD",
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: "Rubik",
                                color: Color.fromRGBO(255, 215, 154, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      progressColor: const Color.fromRGBO(255, 215, 154, 1),
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InfoTile(
                                icon: Icons.percent_rounded,
                                category: "Percentage",
                                stat: getPercentage(completedDays, totalDays),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InfoTile(
                                icon: Icons.analytics,
                                category: "Working Days",
                                stat: context
                                    .read<CounterProvider>()
                                    .calculateWorkingDays()
                                    .toString(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              InfoTile(
                                icon: Icons.account_balance_wallet,
                                category: "Leaves",
                                stat:
                                    "${context.watch<CounterProvider>().leaves}",
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InfoTile(
                                icon: Icons.account_balance,
                                category: "Promotion",
                                stat:
                                    context.read<CounterProvider>().isPromoted()
                                        ? "0 !"
                                        : context
                                            .watch<CounterProvider>()
                                            .daystoPromotion
                                            .toString(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              InfoTile(
                                icon: Icons.run_circle,
                                category: "IPPT Score",
                                stat: context
                                    .watch<IPPT_Provider>()
                                    .score
                                    .toString(),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InfoTile(
                                icon: Icons.beach_access,
                                category: "Offs",
                                stat:
                                    "${context.watch<CounterProvider>().offs}",
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              InfoTile(
                                icon: Icons.holiday_village,
                                category: "Completed",
                                stat: "$completedDays",
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InfoTile(
                                icon: Icons.money,
                                category: "Pay Day",
                                stat: dayDifference(
                                    context.watch<CounterProvider>().payDay),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ConfettiWidget(
                confettiController: confettiControllerLeft,
                blastDirection: 3.14 + 3.14 * (3 / 5), // radial value - LEFT
                particleDrag: 0.05, // apply drag to the confetti
                emissionFrequency: 0.03,
                maxBlastForce: 100, // how often it should emit
                numberOfParticles: 20, // number of particles to emit
                // gravity - or fall speed
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink
                ], // manually specify the colors to be used

                strokeColor: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ConfettiWidget(
                confettiController: confettiControllerRight,
                blastDirection: 3.14 + 3.14 * (2 / 5), // radial value - LEFT
                particleDrag: 0.05, // apply drag to the confetti
                emissionFrequency: 0.03,
                maxBlastForce: 100, // how often it should emit
                numberOfParticles: 20, // number of particles to emit
                // gravity - or fall speed
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink
                ], // manually specify the colors to be used

                strokeColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
