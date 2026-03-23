import 'package:flutter/material.dart';

import '../../../../model/actives/app_logger.dart';
import '../../../../model/actives/google_translator_impl.dart';
import '../../../../model/actives/translator.dart';
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
  final Translator _translator = GoogleTranslatorImpl();
  late ChatRoomData _chatRoomData;

  @override
  Widget build(BuildContext context) {
    _initializeChatRoomData(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -14,
        title: Text("${_chatRoomData.contact.displayName}"),
        actions: [
          LanguageSelector(
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
            child: MsgsSection(
              chatRoomData: _chatRoomData,
              translator: _translator,
            ),
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

  void _onLanguageChange(String newLanguageKey) {
    _logger.v("_onLanguageChange");
    if (newLanguageKey != _translator.getDefaultTargetLanguageKey()) {
      setState(() {
        _translator.setDefaultTargetLanguageKey(newLanguageKey);
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
