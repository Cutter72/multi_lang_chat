import 'package:flutter/material.dart';
import 'package:multi_lang_chat/model/providers/contacts_provider.dart';
import 'package:multi_lang_chat/model/providers/users_provider.dart';
import 'package:multi_lang_chat/widgets/contacts_search_result.dart';

import '../../model/firestore/contacts.dart';
import '../atoms/sub_title_text.dart';
import '../atoms/text_input_field.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContactsSearchScreen extends StatefulWidget {
  static const routeName = '/contacts-search';

  const ContactsSearchScreen({Key? key}) : super(key: key);

  @override
  State<ContactsSearchScreen> createState() => _ContactsSearchScreenState();
}

class _ContactsSearchScreenState extends State<ContactsSearchScreen> {
  final TextEditingController nameFieldController = TextEditingController();

  final TextEditingController emailFieldController = TextEditingController();

  final _usersProvider = UsersProvider();

  final _contactsProvider = ContactsProvider();
  var _contacts = Contacts(accepted: [], rejected: [], pending: []);

  bool _isFieldsListenersInitialized = false;
  bool _isContactsInitialized = false;

  @override
  Widget build(BuildContext context) {
    initTextFieldsListeners();
    initContacts();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Contacts search"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Divider(),
              const SubTitleTextHHH("Search by:"),
              TextInputField("Name", controller: nameFieldController),
              TextInputField("Email", controller: emailFieldController),
              const Divider(),
              const SubTitleTextHHH("Results:"),
              Expanded(
                child: ContactsSearchResult(
                  usersQuery: _usersProvider.queryUsers(
                    nameFieldController.value.text,
                    emailFieldController.value.text,
                  ),
                  contacts: _contacts,
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  void initTextFieldsListeners() {
    if (!_isFieldsListenersInitialized) {
      nameFieldController.addListener(fieldsListener);
      emailFieldController.addListener(fieldsListener);
      _isFieldsListenersInitialized = true;
    }
  }

  void initContacts() {
    if (!_isContactsInitialized) {
      _contactsProvider.fetchContacts().then((contacts) {
        setState(() {
          _contacts = contacts;
          _isContactsInitialized = true;
        });
      });
    }
  }

  void fieldsListener() {
    setState(() {});
  }
}
