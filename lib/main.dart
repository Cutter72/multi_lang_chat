import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:multi_lang_chat/widgets/atoms/content_text.dart';

import 'firebase_options.dart';

late FirebaseFirestore db;
bool _isLocaleInitialized = false;
bool _isFirebaseInitialized = false;

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

void main() async {
  await initFirebase();
  await initLocale();
  FirebaseUIAuth.configureProviders([
    PhoneAuthProvider(),
    EmailAuthProvider(),
    // ... other providers
  ]);
  runApp(const MyApp());
}

Future initFirebase() async {
  if (!_isFirebaseInitialized) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    db = FirebaseFirestore.instance;
    _isFirebaseInitialized = true;
  }
}

Future initLocale() async {
  if (!_isLocaleInitialized) {
    await findSystemLocale();
    await initializeDateFormatting(Intl.systemLocale);
    _isLocaleInitialized = true;
  }
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
        // home: const MyHomePage(),

        home: SignInScreen(
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              if (!state.user!.emailVerified) {
                Navigator.pushNamed(context, '/verify-email');
              } else {
                Navigator.pushReplacementNamed(context, '/profile');
              }
            }),
            VerifyPhoneAction((context, _) {
              Navigator.pushNamed(context, '/phone');
            }),
          ],
        ),
        routes: {
          // ...other routes
          '/phone': (context) => PhoneInputScreen(actions: [
                SMSCodeRequestedAction((context, action, flowKey, phoneNumber) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SMSCodeInputScreen(
                        flowKey: flowKey,
                      ),
                    ),
                  );
                }),
              ]),
        });
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
      body: StreamBuilder(
        stream: db.collection("msgs/").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return const ContentTextHHH("Error");
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                return ContentTextHHH(snapshot.data?.docs[index]['text'] ?? "null");
                // return ContentTextHHH("snapshot.data?.docs[index]['text']");
              },
            );
          }
          return const ContentTextHHH("No data");
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        FirebaseFirestore.instance.collection("msgs/").snapshots().listen((collectionSnapshot) {
          collectionSnapshot.docs.forEach((documentSnapshot) {
            print(documentSnapshot['text']);
          });
        });
      }),
    );
  }
}
