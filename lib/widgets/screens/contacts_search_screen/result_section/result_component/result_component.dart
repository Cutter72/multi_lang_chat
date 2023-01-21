import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/atoms/content_text.dart';

import '../../../../../../model/firestore/app_user/app_user.dart';
import 'contact_list_subcomponent/contact_list_subcomponent.dart';

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
            return const _WaitingIndicator();
          } else {
            if (snapshot.hasData) {
              return ContactList(snapshot.data!);
            } else {
              return _SomethingWentWrong(snapshot.error!);
            }
          }
        });
  }
}

class _WaitingIndicator extends StatelessWidget {
  const _WaitingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _SomethingWentWrong extends StatelessWidget {
  final Object error;

  const _SomethingWentWrong(
    this.error, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ContentTextHHH("No data. Something went wrong: $error"),
    );
  }
}
