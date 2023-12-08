import 'package:flutter/material.dart';

import '../../../../model/actives/app_logger.dart';
import '../../../../model/actives/google_translator.dart';
import '../../../../model/passives/dtos/chat_room_data.dart';
import '../../../common/screens/sections/components/molecules/atoms/content_text_atom.dart';
import 'sections/input_section.dart';
import 'sections/msgs_section.dart';

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
  final _menuController = MenuController();
  final _translator = MyGoogleTranslator();
  late ChatRoomData _chatRoomData;

  @override
  Widget build(BuildContext context) {
    _chatRoomData = ModalRoute.of(context)?.settings.arguments as ChatRoomData;
    if (_chatRoomData.selectedLanguageKey.isEmpty) {
      _chatRoomData.selectedLanguageKey = _translator.getLanguageKey(_translator.getAvailableLanguages().values.first);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("${_chatRoomData.contactAppUser.displayName}"),
        actions: [
          MenuAnchor(
            controller: _menuController,
            anchorTapClosesMenu: true,
            menuChildren: _translator.getAvailableLanguages().values.map<MenuItemButton>((String value) {
              return MenuItemButton(
                onPressed: () => _setSelectedLanguage(_translator.getLanguageKey(value)),
                child: ContentTextHHH(
                  value,
                ),
              );
            }).toList(),
            child: TextButton.icon(
              label: Text(_chatRoomData.selectedLanguageKey.toUpperCase()),
              onPressed: () => _menuController.open(),
              icon: const Icon(Icons.g_translate, color: Colors.deepPurpleAccent),
            ),
          ),
          Transform.scale(
            scale: 0.75,
            child: Switch(
              value: _chatRoomData.isTranslationEnabled,
              onChanged: (isTranslateEnabled) {
                setState(() {
                  _chatRoomData.isTranslationEnabled = isTranslateEnabled;
                });
              },
            ),
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

  void _setSelectedLanguage(String selectedLanguageKey) {
    _logger.v("_setSelectedLanguage");
    if (selectedLanguageKey != _chatRoomData.selectedLanguageKey) {
      setState(() {
        _chatRoomData.selectedLanguageKey = selectedLanguageKey;
      });
    }
  }
}
