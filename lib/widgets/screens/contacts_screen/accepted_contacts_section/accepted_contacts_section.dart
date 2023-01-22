import 'package:flutter/material.dart';

import '../../../../model/firestore/contacts.dart';
import '../../../atoms/something_went_wrong.dart';
import '../../../atoms/waiting_indicator.dart';
import '../../../components/contact_list/contact_list.dart';
import 'open_chat_contact_icon_btn.dart';

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
