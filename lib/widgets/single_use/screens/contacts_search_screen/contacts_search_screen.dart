import 'package:flutter/material.dart';

import '../../../../model/actives/app_logger.dart';
import 'sections/input_section.dart';
import 'sections/result_section.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("ContactsSearchScreen");

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
    _initTextFieldsListeners();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: -12,
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

  void _initTextFieldsListeners() {
    _logger.v("initTextFieldsListeners");
    if (!_isFieldsListenersInitialized) {
      nameFieldController.addListener(_updateState);
      emailFieldController.addListener(_updateState);
      _isFieldsListenersInitialized = true;
    }
  }

  void _updateState() {
    _logger.v("fieldsListener");
    setState(() {});
  }
}
