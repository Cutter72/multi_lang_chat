import 'package:flutter/material.dart';

import '../../../../model/actives/app_logger.dart';
import '../../../../model/actives/google_translator_impl.dart';
import '../../../../model/passives/dtos/chat_room_data.dart';
import '../../../common/screens/sections/components/molecules/atoms/content_text_atom.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("LanguageSelector");

class LanguageSelector extends StatelessWidget {
  final _charRoomData;
  final _onChange;
  final _translator;

  const LanguageSelector({
    Key? key,
    required ChatRoomData charRoomData,
    required void Function(String languageKey) onChange,
    required GoogleTranslatorImpl translator,
  })  : _translator = translator,
        _charRoomData = charRoomData,
        _onChange = onChange,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _menuController = MenuController();
    return MenuAnchor(
      controller: _menuController,
      anchorTapClosesMenu: true,
      menuChildren: _translator
          .getAvailableLanguages()
          .values
          .map<MenuItemButton>((String value) {
        return MenuItemButton(
          onPressed: () => _onChange(_translator.getLanguageKey(value)),
          child: ContentTextHHH(
            value,
          ),
        );
      }).toList(),
      child: TextButton.icon(
        label: Text(_charRoomData.selectedLanguageKey.toUpperCase()),
        onPressed: () => _menuController.open(),
        icon: const Icon(Icons.g_translate, color: Colors.deepPurpleAccent),
      ),
    );
  }
}
