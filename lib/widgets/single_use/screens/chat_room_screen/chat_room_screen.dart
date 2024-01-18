import 'package:flutter/material.dart';

import '../../../../model/actives/app_logger.dart';
import '../../../../model/actives/google_translator.dart';
import '../../../../model/passives/dtos/chat_room_data.dart';
import 'language_selector.dart';
import 'sections/input_section.dart';
import 'sections/msgs_section.dart';
import 'translate_switch.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("ChatRoomScreen");

class ChatRoomScreen extends StatefulWidget {
  static const routeName = '/chat_room';

  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _messageEditorController = TextEditingController();
  final _translator = MyGoogleTranslator();
  late ChatRoomData _chatRoomData;

  @override
  Widget build(BuildContext context) {
    _initializeChatRoomData(context);
    _initializeSelectedLanguage();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -14,
        title: Text("${_chatRoomData.contactAppUser.displayName}"),
        actions: [
          LanguageSelector(
            charRoomData: _chatRoomData,
            onChange: _onLanguageChange,
            translator: _translator,
          ),
          TranslateSwitch(
            chatRoomData: _chatRoomData,
            onChange: _onTranslateSwitchChange,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MsgsSection(chatRoomData: _chatRoomData),
          ),
          InputSection(
            messageEditorController: _messageEditorController,
            chatRoom: _chatRoomData.chatRoom,
          )
        ],
      ),
    );
  }

  void _initializeChatRoomData(BuildContext context) {
    _logger.v("_initializeChatRoomData");
    _chatRoomData = ModalRoute.of(context)?.settings.arguments as ChatRoomData;
  }

  void _initializeSelectedLanguage() {
    _logger.v("_initializeSelectedLanguage");
    if (_chatRoomData.selectedLanguageKey.isEmpty) {
      _chatRoomData.selectedLanguageKey = _translator
          .getLanguageKey(_translator.getAvailableLanguages().values.first);
    }
  }

  void _onLanguageChange(String newLanguageKey) {
    _logger.v("_onLanguageChange");
    if (newLanguageKey != _chatRoomData.selectedLanguageKey) {
      setState(() {
        _chatRoomData.selectedLanguageKey = newLanguageKey;
      });
    }
  }

  void _onTranslateSwitchChange(bool isTranslationEnabledNewValue) {
    _logger.v("_onTranslateSwitchChange");
    setState(() {
      _chatRoomData.isTranslationEnabled = isTranslationEnabledNewValue;
    });
  }
}
