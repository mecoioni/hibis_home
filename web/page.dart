import 'dart:html';

/// Preload images
Map<String, ImageElement> img = new Map<String, ImageElement>();


class Page
{  
  static void init(String id)
  {
    DivElement header = querySelector("#header");
    DivElement footer = querySelector("#footer");
    
    if (header == null || footer == null) throw new StateError("Missing HTML element");
    
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

        /// external links are not allowed in html import, update the linkedin link here instead
        (querySelector("#linkedin_icon") as AnchorElement).href = "https://www.linkedin.com/company/hibis-europe-limited";

        /// special cases: don't show game buttons on contact page, also set the color of the buttons as marked when on the games
        if (id == "contact") querySelector("#game-buttons").remove();
        else if (id == "flags") querySelector("#button-flags").classes.add("bgcolor-blue1");
        else if (id == "honesty") querySelector("#button-honesty").classes.add("bgcolor-blue1");
      });            
    });
  }
    
  /// Custom html import properties - importing links and buttons are disabled by default
  static final NodeValidatorBuilder htmlValidator = new NodeValidatorBuilder.common()
    ..allowImages(new UriPolicy())    
    ..allowElement('a', attributes: ['href', 'data-target', 'data-toggle'])
    ..allowElement('p', attributes: ['style'])
    ..allowElement('div', attributes: ['style'])
    ..allowElement('span', attributes: ['class'])
    ..allowElement('SPAN', attributes: ['class'])
    ..allowElement('button', attributes: ['data-target', 'data-toggle'])
    ..allowElement('img', uriPolicy: new UriPolicy(), attributes: ['src'])
    ..allowElement('IMG', uriPolicy: new UriPolicy(), attributes: ['src'])
    ..allowElement('iframe', attributes: ['src', 'seamless']);

  /// Import html from external document, replaces everything in the specified container
  static void _importHtml(DivElement container, String url, {Function onDone : null})
  { 
    if (container == null) throw new ArgumentError.notNull("container");
    
    HttpRequest.getString(url).then((String response)
    {         
      container.setInnerHtml(response, validator:htmlValidator);
      
      
      
      
      if (onDone != null) onDone();      
    }).catchError((e) { print(e.toString()); });
  }
  
  static void _toggleMicroMenu(Event e)
  {
    Element nav = querySelector("#hamburger-menu");
    nav.style.visibility = (nav.style.visibility == "visible") ? "hidden" : "visible";
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

  
  
}