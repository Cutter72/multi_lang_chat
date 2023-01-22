import 'package:flutter/material.dart';

import 'input_section/input_section.dart';
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
          ],
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
