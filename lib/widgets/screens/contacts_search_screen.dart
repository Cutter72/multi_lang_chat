import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/contacts_search_result.dart';

import '../../model/app_globals.dart';
import '../../model/firestore/app_user/app_user.dart';
import '../../model/firestore/db_collections.dart';
import '../../model/firestore/keywords.dart';
import '../../model/firestore/keywords_manager.dart';
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

  final KeywordsManager keywordsManager = KeywordsManager();

  late Future<List<AppUser>> usersQuery;

  @override
  void initState() {
    super.initState();
    usersQuery = queryUsers(nameFieldController.value.text, emailFieldController.value.text);
  }

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
                child: ContactsSearchResult(usersQuery: usersQuery),
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
    setState(() {
      usersQuery = queryUsers(nameFieldController.value.text, emailFieldController.value.text);
    });
  }

  Future<List<AppUser>> queryUsers(String byName, String byEmail) async {
    if (byName.length < 3 && byEmail.length < 3) {
      return [];
    }
    var usersQuery = prepareUsersQuery(byName, byEmail);
    return await usersQuery.get().then((snapshot) {
      // TODO show users on the list
      List<AppUser> usersFromSnapshot = [];
      for (var user in snapshot.docs) {
        // TODO pass parsed users to List widget
        print("My.Log.user=${AppUserMapper.fromMap(user.data()).toString()}");
        usersFromSnapshot.add(AppUserMapper.fromMap(user.data()));
      }
      return usersFromSnapshot;
    });
  }

  Query<Map<String, dynamic>> prepareUsersQuery(String byName, String byEmail) {
    var keywordsToSearch = prepareKeywordsToSearch(byName, byEmail);
    Query<Map<String, dynamic>> query;
    if (keywordsToSearch.length > 10) {
      // Query of different keywords in Firestore is limited to 10 on a single field.
      // https://firebase.google.com/docs/firestore/query-data/queries?hl=en&authuser=1#query_limitations
      query =
          db.collection(users).where(Keywords.keywordsKey, arrayContainsAny: keywordsToSearch.toList().sublist(0, 10));
    } else {
      // Only one arrayContains or arrayContainsAny clause per query is allowed in Firestore.
      // https://firebase.google.com/docs/firestore/query-data/queries?authuser=1#array_membership
      query = db.collection(users).where(Keywords.keywordsKey, arrayContainsAny: keywordsToSearch.toList());
    }
    return query;
  }

  HashSet<String> prepareKeywordsToSearch(String byName, String byEmail) {
    var allKeywords = HashSet<String>();
    allKeywords.addAll(keywordsManager.splitIntoKeywords(byName));
    allKeywords.addAll(keywordsManager.splitIntoKeywords(byEmail));
    allKeywords.difference(allKeywords);
    return allKeywords;
  }
}
