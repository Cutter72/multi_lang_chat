import 'package:flutter/material.dart';

import '../../../../../../model/passives/daos/app_user/app_user.dart';
import '../../../../../common/screens/sections/components/contact_list_component.dart';
import '../../../../../common/screens/sections/components/molecules/atoms/something_went_wrong_atom.dart';
import '../../../../../common/screens/sections/components/molecules/atoms/waiting_indicator_atom.dart';
import 'add_remove_contact_icon_btn_component.dart';

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
              return ContactList(
                  users: snapshot.data!,
                  trailingBtn: (user) => AddRemoveContactIconBtn(user));
            } else {
              return SomethingWentWrong(snapshot.error!);
            }
          }
        });
  }
}
