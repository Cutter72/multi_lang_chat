import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:multi_lang_chat/widgets/atoms/content_text.dart';
import 'package:multi_lang_chat/widgets/atoms/sub_title_text.dart';
import 'package:multi_lang_chat/widgets/atoms/title_text.dart';

import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
bool _isLocaleInitialized = false;
bool _isFirebaseInitialized = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initLocale();
    initFirebase();
    return MaterialApp(
      title: "Multi lang chat",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }

  void initFirebase() {
    if (!_isFirebaseInitialized) {
      Future.wait([
        Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        )
      ]);
      _isFirebaseInitialized = true;
    }
  }

  void initLocale() {
    if (!_isLocaleInitialized) {
      Future.wait([findSystemLocale()]);
      initializeDateFormatting(Intl.systemLocale);
      _isLocaleInitialized = true;
    }
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TitleTextH("Title H $loremIpsum"),
            SubTitleTextH("Sub Title H $loremIpsum"),
            ContentTextH("Content H $loremIpsum"),
            TitleTextHH("Title HH $loremIpsum"),
            SubTitleTextHH("Sub Title HH $loremIpsum"),
            ContentTextHH("Content HH $loremIpsum"),
            TitleTextHHH("Title HHH $loremIpsum"),
            SubTitleTextHHH("Sub Title HHH $loremIpsum"),
            ContentTextHHH("Content HHH $loremIpsum"),
          ],
        ),
      ),
    );
  }
}
