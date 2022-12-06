import 'package:flutter/material.dart';

import '../atoms/content_text.dart';
import '../atoms/sub_title_text.dart';
import '../atoms/title_text.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class AuthSelectionScreen extends StatelessWidget {
  static const routeName = "/auth-selection";

  const AuthSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SelectionContainer.disabled(child: Text("Sign in")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleTextH("Welcom to multilang chat!"),
            SubTitleTextH("Please use one of below methods to sign in."),
            Expanded(
                child: Container(
              constraints: BoxConstraints(minWidth: 96, minHeight: 96, maxWidth: 144, maxHeight: 144),
              child: FittedBox(
                child: Icon(Icons.login),
                fit: BoxFit.contain,
              ),
            )),
            ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.email_outlined),
                  ContentTextHH("Use email"),
                ],
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.phone_enabled_outlined),
                  ContentTextHH(
                    "Use phone number",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
