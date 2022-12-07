import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/atoms/text_input_field.dart';

import '../atoms/sub_title_text.dart';
import '../atoms/title_text.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContactsSearchScreen extends StatelessWidget {
  static const routeName = '/contacts-search';

  const ContactsSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts search"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Divider(),
            SubTitleTextHHH("Search by:"),
            TextInputField("Name"),
            TextInputField("Email"),
            Divider(),
            SubTitleTextHHH("Results:"),
            Expanded(child: TitleTextH("Here will be list view")),
            Divider(),
          ],
        ),
      ),
    );
  }
}
