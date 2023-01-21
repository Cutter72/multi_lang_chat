import 'package:flutter/material.dart';
import 'package:multi_lang_chat/model/app_globals.dart';
import 'package:multi_lang_chat/widgets/atoms/content_text.dart';

import '../../../../model/firestore/app_user/app_user.dart';
import 'contacts_search_result_list_item.dart';

class ContactsSearchResult extends StatelessWidget {
  final Future<List<AppUser>> usersQuery;

  const ContactsSearchResult({
    Key? key,
    required this.usersQuery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: usersQuery,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (snapshot.data?.isEmpty ?? true) {
                    return const Align(alignment: Alignment.topCenter, child: ContentTextHHH("No users found."));
                  } else {
                    return ContactsSearchResultListItem(user: snapshot.data?[index] ?? loggedAppUser);
                  }
                },
                itemCount: itemCount(snapshot.data),
              );
            } else {
              return Align(
                  alignment: Alignment.topCenter,
                  child: ContentTextHHH("No data. Something went wrong: ${snapshot.error}"));
            }
          }
        });
  }

  int? itemCount(List<AppUser>? data) {
    // minimum 1 to show No items text if null or empty
    if (data?.isNotEmpty ?? false) {
      return data?.length;
    } else {
      return 1;
    }
  }
}
