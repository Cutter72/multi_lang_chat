import 'package:flutter/material.dart';
import 'package:multi_lang_chat/model/firestore/contacts.dart';

import '../../../atoms/something_went_wrong.dart';
import '../../../atoms/waiting_indicator.dart';
import '../../contacts_search_screen/result_section/result_component/contact_list_subcomponent/contact_list_subcomponent.dart';

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
              return ContactList(snapshot.data!.accepted.values.toList());
            } else {
              return SomethingWentWrong(snapshot.error!);
            }
          }
        });
  }
}
