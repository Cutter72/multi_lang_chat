import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../model/firestore/db_collections.dart';
import '../app_globals.dart';
import '../firestore/app_user/app_user.dart';
import '../firestore/keywords.dart';
import '../firestore/keywords_manager.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class UsersProvider with ChangeNotifier {
  final KeywordsManager keywordsManager = KeywordsManager();
  final List<AppUser> _queryUsersResult = [];
  final Set<String> _previousKeywordsToSearch = {};

  UsersProvider();

  List<AppUser> get appUsers => _queryUsersResult;

  Future<List<AppUser>> queryUsers(String byName, String byEmail) async {
    if (byName.length < 3 && byEmail.length < 3) {
      return [];
    }
    var keywordsToSearch = prepareKeywordsToSearch(byName, byEmail);
    if (setEquals(keywordsToSearch, _previousKeywordsToSearch)) {
      return _queryUsersResult;
    } else {
      _previousKeywordsToSearch
        ..clear()
        ..addAll(keywordsToSearch);
    }
    var usersQuery = prepareUsersQuery(keywordsToSearch);
    return await usersQuery.get().then((snapshot) {
      List<AppUser> usersFromSnapshot = [];
      for (var user in snapshot.docs) {
        print("My.Log.user=${AppUserMapper.fromMap(user.data()).toString()}");
        usersFromSnapshot.add(AppUserMapper.fromMap(user.data()));
      }
      _queryUsersResult
        ..clear()
        ..addAll(usersFromSnapshot);
      notifyListeners();
      return _queryUsersResult;
    });
  }

  Query<Map<String, dynamic>> prepareUsersQuery(Set<String> keywordsToSearch) {
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

  Set<String> prepareKeywordsToSearch(String byName, String byEmail) {
    var allKeywords = HashSet<String>();
    allKeywords.addAll(keywordsManager.splitIntoKeywords(byName));
    allKeywords.addAll(keywordsManager.splitIntoKeywords(byEmail));
    allKeywords.difference(allKeywords);
    return allKeywords;
  }
}
