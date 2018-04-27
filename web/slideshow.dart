import 'dart:async';
import 'dart:html';
import 'dart:math' show Random;

class SlideShow {
  SlideShow(this._container) {
    _imageList.forEach(_container.append);
    _container.style
      ..position = 'relative'
      ..marginBottom = '1rem'
      ..backgroundColor = 'white';

    for (var i = 0; i < _imageList.length; i++) {
      final img = _imageList[i]
        ..alt = 'slide-$i'
        ..className = 'no-height'
        ..style.display = 'block'
        ..style.position = 'relative'
        ..style.transition = 'opacity 100ms ease'
        ..style.width = '100%'
        ..style.zIndex = '1';
      _container.append(img);
    }

    final textStrip = new HeadingElement.h2()
    ..classes.add('lang-exp')
    ..dataset['exp'] = 'frontpage_title'
    ..style.textTransform = 'inherit'
    ..style.backgroundColor = 'rgba(0,0,0,0.6)'
    ..style.color = 'white'
    ..style.padding = '0.4em 0.1em'
    ..style.margin = '-7rem auto 0 auto'
    ..style.textAlign = 'center'
    ..style.position = 'relative'
    ..style.zIndex = '2';

    _container.append(textStrip);

    _currentIndex = _rnd.nextInt(_imageList.length);
    _imageList[_currentIndex].classes.remove('no-height');

    new Timer.periodic(const Duration(seconds: 30), nextRandomImage);
  }

  void nextRandomImage(Timer t) {
    final prevIndex = _currentIndex;
    while (_currentIndex == prevIndex)
      _currentIndex = _rnd.nextInt(_imageList.length);

    _imageList[prevIndex].style.opacity =
        _imageList[_currentIndex].style.opacity = '0';
    new Timer(const Duration(milliseconds: 600), () {
      _imageList[prevIndex].classes.add('no-height');
      _imageList[_currentIndex].style.opacity = '1';
      _imageList[_currentIndex].classes.remove('no-height');
    });
  }

  final List<ImageElement> _imageList = [
    new ImageElement(src: 'gfx/slide_1.jpg'),
    new ImageElement(src: 'gfx/slide_2.jpg'),
    new ImageElement(src: 'gfx/slide_3.jpg'),
    new ImageElement(src: 'gfx/slide_4.jpg'),
    new ImageElement(src: 'gfx/slide_5.jpg'),
    new ImageElement(src: 'gfx/slide_6.jpg'),
    new ImageElement(src: 'gfx/slide_7.jpg'),
    new ImageElement(src: 'gfx/slide_8.jpg'),
    new ImageElement(src: 'gfx/slide_9.jpg'),
    new ImageElement(src: 'gfx/slide_10.jpg'),
    new ImageElement(src: 'gfx/slide_11.jpg'),
    new ImageElement(src: 'gfx/slide_12.jpg'),
  ];

  int _currentIndex;
  final String width = '1400px';
  final Random _rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  final Element _container;
}
