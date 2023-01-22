import 'package:flutter/material.dart';

import '../../../../model/providers/users_provider.dart';
import '../../../atoms/sub_title_text.dart';
import 'result_component/result_component.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ResultSection extends StatelessWidget {
  const ResultSection({
    Key? key,
    required this.nameFieldController,
    required this.emailFieldController,
  }) : super(key: key);

  final TextEditingController nameFieldController;
  final TextEditingController emailFieldController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SubTitleTextHHH("Results:"),
        ),
        Expanded(
          child: ContactsSearchResult(
            usersQuery: UsersProvider.queryUsers(
              nameFieldController.value.text,
              emailFieldController.value.text,
            ),
          ),
        ),
      ],
    );
  }
}
