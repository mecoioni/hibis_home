library banner;
import 'dart:async';
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
    _headerElement = querySelector('#header');
    _state = HeaderState.top;

    _headerList = querySelectorAll('.section-title');
    _headerTargets['what_we_do'] = querySelector('#what_we_do');
    _headerTargets['who_we_are'] = querySelector('#who_we_are');
    _headerTargets['our_history'] = querySelector('#our_history');
    _headerTargets['contact_us'] = querySelector('#contact');

    onScrollListener = window.document.onScroll.listen(onScroll);
  }

  void onScroll(Event e)
  {
    for (final e in _headerTargets.values) {
      e.classes.remove('active');
    }
    
    final passed = _headerList.where(scrollIsBelow);

    if (passed.isNotEmpty) _headerTargets[passed.last.dataset['exp']].classes.add('active');

    final deltaScroll = _prevScrollPos - window.scrollY;

    /// Scrolling down
    if (deltaScroll < 0)
    {
      offset = 0;
      if (_state == HeaderState.top && window.scrollY >= _headerElement.clientHeight)
      {
        _headerElement.classes.add('scrollfollow');
        _headerElement.classes.remove('scrolltop');
        _headerElement.style.top = '${-_headerElement.clientHeight}px';
        _state = HeaderState.follow;
      }
      else if (_state == HeaderState.follow && window.scrollY >= _headerElement.clientHeight)
      {
        var cTop = int.parse(_headerElement.style.top.substring(0, _headerElement.style.top.indexOf('px')));
        cTop += deltaScroll;
        if (cTop < -_headerElement.clientHeight) cTop = -_headerElement.clientHeight;
        _headerElement.style.top = '${cTop}px';
      }
    }
    /// Scrolling up
    else if (deltaScroll > 0)
    {
      offset = _headerElement.getBoundingClientRect().height;

      if (offset > 0 && deltaScroll > 200)
      {
        onScrollListener.cancel();
        window.scrollBy(0, -offset);
        onScrollListener = window.document.onScroll.listen(onScroll);
      }

      if (_state == HeaderState.follow && window.scrollY <= 0)
      {
        _headerElement.classes.add('scrolltop');
        _headerElement.classes.remove('scrollfollow');
        _headerElement.style.top = '0px';
        _state = HeaderState.top;
      }
      else if (_state == HeaderState.follow && window.scrollY > 0)
      {


        var cTop = int.parse(_headerElement.style.top.substring(0, _headerElement.style.top.indexOf('px')));
        cTop += deltaScroll;
        if (cTop > 0) cTop = 0;
        _headerElement.style.top = '${cTop}px';
      }
    }
    _prevScrollPos = window.scrollY;
  }

  bool scrollIsBelow(Element e)
  {
    final bodyTop = document.body.getBoundingClientRect().top;
    final headerHeight = _headerElement.getBoundingClientRect().height;
    final elemTop = e.getBoundingClientRect().top;
    final offset = elemTop - bodyTop;

    return (window.scrollY >= offset - headerHeight - 100);
  }

  DivElement _headerElement;
  int _prevScrollPos;
  HeaderState _state;
  num offset = 0;
}

StreamSubscription<Event> onScrollListener;
ElementList<Element> _headerList;
Map<String, Element> _headerTargets = {};
