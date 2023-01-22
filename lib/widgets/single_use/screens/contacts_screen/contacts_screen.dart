import 'package:flutter/material.dart';

import '../../../../storage/persistent/firestore/providers/contacts_provider.dart';
import '../contacts_search_screen/contacts_search_screen.dart';
import '../developer_screen.dart';
import 'sections/accepted_contacts_section.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContactsScreen extends StatelessWidget {
  static const routeName = '/contacts';

  const ContactsScreen({Key? key}) : super(key: key);

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
    Navigator.pushNamed(context, ContactsSearchScreen.routeName);
  }

  void _goToDeveloperScreen(BuildContext context) {
    Navigator.pushNamed(context, DeveloperScreen.routeName);
  }
}
