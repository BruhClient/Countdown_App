import 'package:countdown/pages/home_page.dart';
import 'package:countdown/pages/ippt_page.dart';
import 'package:countdown/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
          name: "home",
          path: "/",
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: HomePage(),
            );
          }),
      GoRoute(
          name: "settings",
          path: "/settings",
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: SettingsPage(),
            );
          }),
      GoRoute(
          name: "IPPT",
          path: "/IPPT",
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: IPPT_Page(),
            );
          }),
    ],
  );
}
