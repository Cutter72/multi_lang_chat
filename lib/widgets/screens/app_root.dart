import 'package:flutter/material.dart';

import 'auth_gate_screen.dart';
import 'home_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Multi lang chat",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AuthGateScreen(),
      initialRoute: AuthGateScreen.routeName,
      routes: {
        AuthGateScreen.routeName: (context) {
          return const AuthGateScreen();
        },
        HomeScreen.routeName: (context) {
          return const HomeScreen();
        },
      },
    );
  }
}
