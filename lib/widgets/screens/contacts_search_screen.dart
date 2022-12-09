import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/app_globals.dart';
import '../../model/firestore/app_user.dart';
import '../../model/firestore/keywords.dart';
import '../../model/firestore/keywords_manager.dart';
import '../atoms/sub_title_text.dart';
import '../atoms/text_input_field.dart';
import '../atoms/title_text.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContactsSearchScreen extends StatelessWidget {
  static const routeName = '/contacts-search';
  final TextEditingController nameFieldController = TextEditingController();
  final TextEditingController emailFieldController = TextEditingController();
  final KeywordsManager keywordsManager = KeywordsManager();

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

  void queryUsers(String namePhraseToSearch, String emailPhraseToSearch) async {
    var allKeywords = HashSet<String>();
    allKeywords.addAll(keywordsManager.splitIntoKeywords(namePhraseToSearch));
    allKeywords.addAll(keywordsManager.splitIntoKeywords(emailPhraseToSearch));
    Query<Map<String, dynamic>>? query;
    // Query of different keywords in Firestore is limited to 10 on a single field.
    // https://firebase.google.com/docs/firestore/query-data/queries?hl=en&authuser=1#query_limitations
    if (allKeywords.length > 10) {
      query =
          db.collection("/users").where(Keywords.keywordsKey, arrayContainsAny: allKeywords.toList().sublist(0, 10));
    } else if (allKeywords.length > 0) {
      query = db.collection("/users").where(Keywords.keywordsKey, arrayContainsAny: allKeywords.toList());
    }
    await query?.get().then((snapshot) {
      // TODO show users on the list
      for (var user in snapshot.docs) {
        // TODO pass parsed users to List widget
        print("My.Log.user=${AppUser.fromSnapshotData(user.data()).toString()}");
      }
      return null;
    });
  }

  void clearQueriedUsers() {
    // todo clear loaded users
  }
}
