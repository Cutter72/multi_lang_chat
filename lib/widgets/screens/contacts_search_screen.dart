import 'package:flutter/material.dart';
import 'package:multi_lang_chat/model/providers/users_provider.dart';
import 'package:multi_lang_chat/widgets/contacts_search_result.dart';

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

  final usersProvider = UsersProvider();

  bool _isFieldsListenersInitialized = false;

  @override
  Widget build(BuildContext context) {
    initTextFieldsListeners(context);
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
                  usersQuery: usersProvider.queryUsers(
                    nameFieldController.value.text,
                    emailFieldController.value.text,
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  void initTextFieldsListeners(BuildContext context) {
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
