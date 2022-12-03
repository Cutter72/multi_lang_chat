import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/atoms/content_text.dart';
import 'package:multi_lang_chat/widgets/atoms/sub_title_text.dart';
import 'package:multi_lang_chat/widgets/atoms/title_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Multi lang chat",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SelectionContainer.disabled(child: Text("Multi lang chat")),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: const [
              TitleTextH(text: "Title H"),
              SubTitleTextH(text: "Sub Title H"),
              ContentTextH(text: "Content H"),
            ],
          ),
          Row(
            children: const [
              TitleTextHH(text: "Title HH"),
              SubTitleTextHH(text: "Sub Title HH"),
              ContentTextHH(text: "Content HH"),
            ],
          ),
          Row(
            children: const [
              TitleTextHHH(text: "Title HHH"),
              SubTitleTextHHH(text: "Sub Title HHH"),
              ContentTextHHH(text: "Content HHH"),
            ],
          ),
        ],
      ),
    );
  }
}
