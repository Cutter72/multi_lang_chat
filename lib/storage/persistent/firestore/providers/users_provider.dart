import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../../model/actives/app_logger.dart';
import '../../../../model/actives/keywords_splitter.dart';
import '../../../../model/passives/daos/app_user/app_user.dart';
import '../../../../model/passives/keywords.dart';
import '../../../runtime/app_globals.dart';
import '../db.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("UsersProvider");

class UsersProvider {
  static const int _wordsLimit = 10;
  static final KeywordsSplitter _keywordsSplitter = KeywordsSplitter();
  static final List<AppUser> _queryUsersResult = [];
  static final Set<String> _previousKeywordsToSearch = {};

  static Future<List<AppUser>> queryUsers(String byName, String byEmail) async {
    _logger.v("queryUsers");
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

  static Set<String> _prepareKeywordsToSearch(String byName, String byEmail) {
    _logger.v("_prepareKeywordsToSearch");
    return _keywordsSplitter.splitIntoKeywords("$byName $byEmail");
  }

  static Query<AppUser> _prepareUsersQuery(Set<String> keywordsToSearch) {
    _logger.v("_prepareUsersQuery");
    Query<AppUser> query;
    if (keywordsToSearch.length > _wordsLimit) {
      // Query of different keywords in Firestore is limited to 10 on a single field.
      // https://firebase.google.com/docs/firestore/query-data/queries?hl=en&authuser=1#query_limitations
      query = _prepareWordsLimitedQuery(keywordsToSearch, _wordsLimit);
    } else {
      // Only one arrayContains or arrayContainsAny clause per query is allowed in Firestore.
      // https://firebase.google.com/docs/firestore/query-data/queries?authuser=1#array_membership
      query = _prepareWordsQuery(keywordsToSearch);
    }
    return query;
  }

  static Query<AppUser> _prepareWordsLimitedQuery(Set<String> keywordsToSearch, int wordsLimit) {
    _logger.v("_prepareWordsLimitedQuery");
    return Db.users
        .where(Keywords.keywordsKey, arrayContainsAny: keywordsToSearch.toList().sublist(0, wordsLimit))
        .where(FieldPath.documentId, isNotEqualTo: lauUid);
  }

  static Query<AppUser> _prepareWordsQuery(Set<String> keywordsToSearch) {
    _logger.v("_prepareWordsQuery");
    return Db.users
        .where(Keywords.keywordsKey, arrayContainsAny: keywordsToSearch.toList())
        .where(FieldPath.documentId, isNotEqualTo: lauUid);
  }
}
