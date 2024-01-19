import 'package:flutter/material.dart';

import '../../../../model/actives/app_logger.dart';
import '../../../../model/actives/translator.dart';
import '../../../common/screens/sections/components/molecules/atoms/content_text_atom.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("LanguageSelector");

class LanguageSelector extends StatelessWidget {
  final _onChange;
  final Translator _translator;

  const LanguageSelector({
    Key? key,
    required void Function(String languageKey) onChange,
    required Translator translator,
  })  : _translator = translator,
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
          .map<MenuItemButton>((String language) {
        return MenuItemButton(
          onPressed: () => _onChange(_translator.parseToLanguageKey(language)),
          child: ContentTextHHH(language),
        );
      }).toList(),
      child: TextButton.icon(
        label: Text(_translator.getDefaultTargetLanguageKey().toUpperCase()),
        onPressed: () => _menuController.open(),
        icon: const Icon(
          Icons.g_translate,
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}
