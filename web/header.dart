library banner;
import 'dart:html';

enum HeaderState
{
  top,
  follow
}

class Header
{
  Header()
  {
    _prevScrollPos = 0;
    _headerElement = querySelector("#header");
    _state = HeaderState.top;

    _headerList = querySelectorAll(".section-title");
    _headerTargets["what_we_do"] = querySelector("#what_we_do");
    _headerTargets["who_we_are"] = querySelector("#who_we_are");
    _headerTargets["our_history"] = querySelector("#our_history");
    _headerTargets["contact_us"] = querySelector("#contact");

    window.document.onScroll.listen((_)
    {
      _headerTargets.values.forEach((e) => e.classes.remove("active"));
      Iterable<Element> passed = _headerList.where(scrollIsBelow);

      if (passed.isNotEmpty) _headerTargets[passed.last.dataset["exp"]].classes.add("active");

      int deltaScroll = _prevScrollPos - window.scrollY;

      /// Scrolling down
      if (deltaScroll < 0)
      {
        offset = 0;
        if (_state == HeaderState.top && window.scrollY >= _headerElement.clientHeight)
        {
          _headerElement.classes.add("scrollfollow");
          _headerElement.classes.remove("scrolltop");
          _headerElement.style.top = (-_headerElement.clientHeight).toString() + "px";
          _state = HeaderState.follow;
        }
        else if (_state == HeaderState.follow && window.scrollY >= _headerElement.clientHeight)
        {
          int cTop = int.parse(_headerElement.style.top.substring(0, _headerElement.style.top.indexOf("px")));
          cTop += deltaScroll;
          if (cTop < -_headerElement.clientHeight) cTop = -_headerElement.clientHeight;
          _headerElement.style.top = cTop.toString() + "px";
        }
      }
      /// Scrolling up (manually)
      else if (deltaScroll > 0 && !autoScrolling)
      {
        offset = _headerElement.getBoundingClientRect().height;
        if (_state == HeaderState.follow && window.scrollY <= 0)
        {
          _headerElement.classes.add("scrolltop");
          _headerElement.classes.remove("scrollfollow");
          _headerElement.style.top = "0px";
          _state = HeaderState.top;
        }
        else if (_state == HeaderState.follow && window.scrollY > 0)
        {
          int cTop = int.parse(_headerElement.style.top.substring(0, _headerElement.style.top.indexOf("px")));
          cTop += deltaScroll;
          if (cTop > 0) cTop = 0;
          _headerElement.style.top = cTop.toString() + "px";
        }
      }
      _prevScrollPos = window.scrollY;
    });
  }

  bool scrollIsBelow(Element e)
  {
    num bodyTop = document.body.getBoundingClientRect().top;
    num headerHeight = _headerElement.getBoundingClientRect().height;
    num elemTop = e.getBoundingClientRect().top;
    num offset = elemTop - bodyTop;

    return (window.scrollY >= offset - headerHeight - 100);
  }

  DivElement _headerElement;
  int _prevScrollPos;
  HeaderState _state;
  bool autoScrolling = false;
  num offset = 0;
}
ElementList<Element> _headerList;
Map<String, Element> _headerTargets = new Map();
