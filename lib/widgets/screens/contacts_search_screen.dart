import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/atoms/text_input_field.dart';

import '../atoms/sub_title_text.dart';
import '../atoms/title_text.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContactsSearchScreen extends StatelessWidget {
  static const routeName = '/contacts-search';
  final TextEditingController nameFieldController = TextEditingController();
  final TextEditingController emailFieldController = TextEditingController();

  bool _isFieldsListenersInitialized = false;

  ContactsSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initTextFieldsListeners();
    return Scaffold(
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
            const Expanded(child: TitleTextH("Here will be list view")),
            const Divider(),
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
    if (nameFieldController.value.text.length >= 3 || emailFieldController.value.text.length >= 3) {
      queryUsers(nameFieldController.value.text, emailFieldController.value.text);
    } else {
      clearQueriedUsers();
    }
  }

  void queryUsers(String namePhraseToSearch, String emailPhraseToSearch) {
    print("My.Log.query: name=$namePhraseToSearch, email=$emailPhraseToSearch");
    // todo search for users
  }

  void clearQueriedUsers() {
    // todo clear loaded users
  }
}
