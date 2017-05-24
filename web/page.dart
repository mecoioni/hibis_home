import 'dart:html';
import 'phrase.dart';


/// Preload images
Map<String, ImageElement> img = new Map<String, ImageElement>();

class Page
{  
  static void init(String id)
  {
    DivElement header = querySelector("#header");
    DivElement footer = querySelector("#footer");

    _importHtml(header, "inc/header.html", onDone:()
    {      
      if (id != null && querySelector("#$id") != null) querySelector("#$id").classes.add("active");

      /// external links are not allowed in html import, update the academy top link here instead
      (querySelector("#academy") as AnchorElement).href = "http://fraudacademy.hibis.com";
      (querySelector("#academy_small") as AnchorElement).href = "http://fraudacademy.hibis.com";

      /// micro nav
      querySelector("#hamburger").onClick.listen(_toggleMicroMenu);  
      querySelector("#micro-nav-list").children.forEach((LIElement li)
      {
        li.children.first.onClick.listen((_) => querySelector("#hamburger-menu").style.visibility = "hidden");
      });                        
      _importHtml(footer, "inc/footer.html", onDone:()
      {
        List<Element> unresolved = querySelectorAll(".unresolved");        
        unresolved.forEach((Element e)
        {
          e.style.opacity = "1";
        });

        _populatePhrases();
      });            
    });
  }

  /// Import html from external document, replaces everything in the specified container
  static void _importHtml(DivElement container, String url, {Function onDone : null})
  { 
    if (container == null) throw new ArgumentError.notNull("container");
    
    HttpRequest.getString(url).then((String response)
    {         
      container.setInnerHtml(response, validator: new TrustedNodeValidator());
      if (onDone != null) onDone();      
    }).catchError((e) { print(e.toString()); });
  }
  
  static void _toggleMicroMenu(Event e)
  {
    Element nav = querySelector("#hamburger-menu");
    nav.style.visibility = (nav.style.visibility == "visible") ? "hidden" : "visible";
  }

  static void _populatePhrases()
  {
    if (Uri.base.queryParameters.containsKey("lang")) phrase.language = window.sessionStorage["lang"] = Uri.base.queryParameters["lang"];

    else if (window.sessionStorage.containsKey("lang"))
    {
      phrase.language = window.sessionStorage["lang"];
    }

    querySelectorAll(".lang-exp").forEach((Element e) => e.setInnerHtml(phrase.get(e.dataset["exp"]), validator: new TrustedNodeValidator()));
  }
  
  static String getUrlParam(String key)
  {
    if (key == null) throw new ArgumentError.notNull("key");
    if (window.location.search.isEmpty) return null;
    String query = window.location.search.substring(1);
    List<String> vars = query.split("&");
    for (int i = 0; i < vars.length; i++)
    {
      List<String> pair = vars[i].split("=");
      if (pair[0] == key) return pair[1];
    }
    
    return null;
  }
  static Phrase phrase = new Phrase("en");
}

/// A [NodeValidator] which allows everything.
class TrustedNodeValidator implements NodeValidator
{
  bool allowsElement(Element element) => true;
  bool allowsAttribute(element, attributeName, value) => true;
}