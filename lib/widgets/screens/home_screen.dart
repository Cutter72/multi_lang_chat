import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/atoms/title_text.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SelectionContainer.disabled(child: Text("Home screen")),
      ),
      body: const Center(child: TitleTextH("Home screen")),
    );
  }
}
