import 'package:countdown/components/router.dart';
import 'package:countdown/provider/IPPT_Provider.dart';
import 'package:countdown/provider/counterProvider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox("mybox");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IPPT_Provider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CounterProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  ); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().router,
      debugShowCheckedModeBanner: false,
    );
  }
}
