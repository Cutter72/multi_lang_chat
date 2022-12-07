import 'package:flutter/material.dart';

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
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: TextField(
                maxLines: 1,
                decoration:
                    InputDecoration(labelText: "Name", border: OutlineInputBorder(), contentPadding: EdgeInsets.all(8)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                    labelText: "Email", border: OutlineInputBorder(), contentPadding: EdgeInsets.all(8)),
              ),
            ),
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
