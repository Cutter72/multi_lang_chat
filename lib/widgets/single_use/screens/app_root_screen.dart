import 'package:flutter/material.dart';

import '../../../model/actives/app_logger.dart';
import 'auth_gate_screen.dart';
import 'chat_room_screen/chat_room_screen.dart';
import 'contacts_screen/contacts_screen.dart';
import 'contacts_search_screen/contacts_search_screen.dart';
import 'developer_screen.dart';
import 'user_settings_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("AppRootScreen");

class AppRootScreen extends StatelessWidget {
  const AppRootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Multi lang chat",
      // hides debug badge
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: AuthGateScreen.routeName,
      routes: {
        AuthGateScreen.routeName: (context) {
          _logger.i("Routing to AuthGateScreen");
          return const AuthGateScreen();
        },
        ContactsScreen.routeName: (context) {
          _logger.i("Routing to ContactsScreen");
          return const ContactsScreen();
        },
        ContactsSearchScreen.routeName: (context) {
          _logger.i("Routing to ContactsSearchScreen");
          return const ContactsSearchScreen();
        },
        UserSettingsScreen.routeName: (context) {
          _logger.i("Routing to UserSettingsScreen");
          return const UserSettingsScreen();
        },
        DeveloperScreen.routeName: (context) {
          _logger.i("Routing to DeveloperScreen");
          return const DeveloperScreen();
        },
        ChatRoomScreen.routeName: (context) {
          _logger.i("Routing to ChatRoomScreen");
          return const ChatRoomScreen();
        },
      },
    );
  }
}
