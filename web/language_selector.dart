import 'dart:html';
import 'phrase.dart';

class LanguageSelector
{
  LanguageSelector(Phrase phrase)
  {
    _selectedLanguage = _container.querySelector("#selected-language");
    _selectedLanguage.setInnerHtml(phrase.get("lang_${phrase.language}"));
    _optionsDropdown = _container.querySelector("#selected-language-options");
    _options = querySelectorAll(".language-option").toList(growable: false);

    _container.onClick.listen((e)
    {
      e.stopPropagation();
      _optionsDropdown.classes.remove("hide");
    });
    document.onClick.listen((_) => _optionsDropdown.classes.add("hide"));

    for (Element option in _options) option.onClick.listen(_setActiveLanguage);
  }

  void _setActiveLanguage(MouseEvent e)
  {
    String lang = (e.target as Element).dataset["value"];
    window.location.href = "https://$lang.hibis.com${Uri.base.path}";
  }

  final DivElement _container = querySelector("#language-selector");
  DivElement _optionsDropdown;
  List<Element> _options;
  SpanElement _selectedLanguage;

}
