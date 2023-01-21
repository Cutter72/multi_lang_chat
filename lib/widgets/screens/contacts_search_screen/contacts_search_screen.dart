import 'package:flutter/material.dart';
import 'package:multi_lang_chat/model/providers/users_provider.dart';
import 'package:multi_lang_chat/widgets/screens/contacts_search_screen/input_section/input_section.dart';

import 'result_section/result_section.dart';

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

  bool _isFieldsListenersInitialized = false;

  @override
  Widget build(BuildContext context) {
    initTextFieldsListeners();
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
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(),
              InputSection(
                nameFieldController: nameFieldController,
                emailFieldController: emailFieldController,
              ),
              const Divider(),
              Expanded(
                child: ResultSection(
                  nameFieldController: nameFieldController,
                  emailFieldController: emailFieldController,
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

  void fieldsListener() {
    setState(() {});
  }
}