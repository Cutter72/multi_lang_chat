import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../../model/actives/keywords_splitter.dart';
import '../../../../model/passives/daos/app_user/app_user.dart';
import '../../../../model/passives/keywords.dart';
import '../../../runtime/app_globals.dart';
import '../db.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class UsersProvider {
  static final KeywordsSplitter _keywordsSplitter = KeywordsSplitter();
  static final List<AppUser> _queryUsersResult = [];
  static final Set<String> _previousKeywordsToSearch = {};

  static Future<List<AppUser>> queryUsers(String byName, String byEmail) async {
    if (byName.length < 3 && byEmail.length < 3) {
      return [];
    }
    var keywordsToSearch = _prepareKeywordsToSearch(byName, byEmail);
    if (setEquals(keywordsToSearch, _previousKeywordsToSearch)) {
      return _queryUsersResult;
    } else {
      _previousKeywordsToSearch
        ..clear()
        ..addAll(keywordsToSearch);
    }
    var usersQuery = _prepareUsersQuery(keywordsToSearch);
    return await usersQuery.get().then((snapshot) {
      List<AppUser> usersFromSnapshot = [];
      for (var user in snapshot.docs) {
        print("My.Log.user=${user.data()}");
        usersFromSnapshot.add(user.data());
      }
      _queryUsersResult
        ..clear()
        ..addAll(usersFromSnapshot)
        ..sort(
          (thisUser, otherUser) {
            return thisUser.compareTo(otherUser);
          },
        );
      return _queryUsersResult;
    });
  }

  static Query<AppUser> _prepareUsersQuery(Set<String> keywordsToSearch) {
    Query<AppUser> query;
    if (keywordsToSearch.length > 10) {
      // Query of different keywords in Firestore is limited to 10 on a single field.
      // https://firebase.google.com/docs/firestore/query-data/queries?hl=en&authuser=1#query_limitations
      query = Db.users
          .where(Keywords.keywordsKey, arrayContainsAny: keywordsToSearch.toList().sublist(0, 10))
          .where(FieldPath.documentId, isNotEqualTo: lauUid);
    } else {
      // Only one arrayContains or arrayContainsAny clause per query is allowed in Firestore.
      // https://firebase.google.com/docs/firestore/query-data/queries?authuser=1#array_membership
      query = Db.users
          .where(Keywords.keywordsKey, arrayContainsAny: keywordsToSearch.toList())
          .where(FieldPath.documentId, isNotEqualTo: lauUid);
    }
    return query;
  }

  static Set<String> _prepareKeywordsToSearch(String byName, String byEmail) {
    return _keywordsSplitter.splitIntoKeywords("$byName $byEmail");
  }
}
