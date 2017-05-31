import 'dart:html';
import 'phrase.dart';

class LanguageSelector
{
  LanguageSelector(Phrase phrase)
  {
    _selectedLanguage = _container.querySelector("#selected-language");
    _selectedLanguage.setInnerHtml(phrase.get("lang_${phrase.language}"));
    _optionsDropdown = _container.querySelector("#selected-language-options");
    _options = _optionsDropdown.querySelectorAll(".language-option").toList(growable: false);

    _selectedLanguage.onClick.listen((e)
      {
        e.stopPropagation();
        _optionsDropdown.classes.remove("hide");
      });
    document.onClick.listen((_) => _optionsDropdown.classes.add("hide"));

    for (DivElement option in _options) option.onClick.listen(_setActiveLanguage);
  }

  void _setActiveLanguage(MouseEvent e)
  {
    window.sessionStorage["lang"] = (e.target as DivElement).dataset["value"];
    window.location.reload();
  }

  final DivElement _container = querySelector("#language-selector");
  DivElement _optionsDropdown;
  List<DivElement> _options;
  SpanElement _selectedLanguage;

}
