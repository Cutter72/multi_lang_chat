import 'package:flutter/material.dart';

import '../../../../../../model/firestore/app_user/app_user.dart';
import '../../../../atoms/something_went_wrong.dart';
import '../../../../atoms/waiting_indicator.dart';
import '../../../../components/contact_list/contact_list.dart';
import 'add_remove_contact_icon_btn.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
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
            return const WaitingIndicator();
          } else {
            if (snapshot.hasData) {
              return ContactList(snapshot.data!, trailingBtn: (user) => AddRemoveContactIconBtn(user));
            } else {
              return SomethingWentWrong(snapshot.error!);
            }
          }
        });
  }
}
