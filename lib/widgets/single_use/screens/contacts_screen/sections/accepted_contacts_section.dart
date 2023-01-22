import 'package:flutter/material.dart';

import '../../../../../model/passives/daos/contacts/contacts.dart';
import '../../../../numerous_use/screens/sections/components/contact_list_component.dart';
import '../../../../numerous_use/screens/sections/components/molecules/atoms/something_went_wrong_atom.dart';
import '../../../../numerous_use/screens/sections/components/molecules/atoms/waiting_indicator_atom.dart';
import 'components/open_chat_contact_icon_btn_component.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class AcceptedContactsSection extends StatelessWidget {
  final Future<Contacts> contactsQuery;

  const AcceptedContactsSection({
    Key? key,
    required this.contactsQuery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: contactsQuery,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaitingIndicator();
          } else {
            if (snapshot.hasData) {
              return ContactList(snapshot.data!.accepted.values.toList(),
                  trailingBtn: (user) => OpenChatContactIconBtn(user));
            } else {
              return SomethingWentWrong(snapshot.error!);
            }
          }
        });
  }
}
