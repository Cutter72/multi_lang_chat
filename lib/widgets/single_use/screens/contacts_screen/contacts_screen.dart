import 'package:flutter/material.dart';

import '../../../../model/actives/app_logger.dart';
import '../../../../storage/persistent/firestore/providers/contacts_provider.dart';
import '../contacts_search_screen/contacts_search_screen.dart';
import '../developer_screen.dart';
import 'sections/accepted_contacts_section.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("ContactsScreen");

class ContactsScreen extends StatefulWidget {
  static const routeName = '/contacts';

  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(onPressed: () => _goToContactsSearchScreen(context), icon: const Icon(Icons.person_search)),
          IconButton(onPressed: () => _goToDeveloperScreen(context), icon: const Icon(Icons.developer_board)),
        ],
      ),
      body: AcceptedContactsSection(contactsQuery: ContactsProvider.fetchContacts()),
    );
  }

  void _goToContactsSearchScreen(BuildContext context) {
    _logger.v("_goToContactsSearchScreen");
    Navigator.pushNamed(context, ContactsSearchScreen.routeName).then((value) => setState(() {}));
  }

  void _goToDeveloperScreen(BuildContext context) {
    _logger.v("_goToDeveloperScreen");
    Navigator.pushNamed(context, DeveloperScreen.routeName).then((value) => setState(() {}));
  }
}
