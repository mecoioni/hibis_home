import 'dart:async';
import 'dart:html';
import 'dart:math' show Random;

class SlideShow
{
  SlideShow(this._container)
  {
    _container.style.backgroundColor = "#000";
    _imageList.forEach(_container.append);
    for (int i = 0; i < _imageList.length; i++)
    {
      ImageElement img = _imageList[i];
      img.alt = "slide-$i";
      img.className = "no-height";
      img.style.transition = "opacity 600ms ease";
      _container.append(img);
    }

    HeadingElement textStrip = new HeadingElement.h2();
    textStrip.classes.add("lang-exp");
    textStrip.dataset["exp"] = "frontpage_title";
    textStrip.style.position = "absolute";
    textStrip.style.textTransform = "inherit";
    textStrip.style.bottom = "10%";
    textStrip.style.backgroundColor = "rgba(0,0,0,0.6)";
    textStrip.style.color = "white";
    textStrip.style.padding = "0.4em 0.1em";
    textStrip.style.margin = "0";
    textStrip.style.textAlign = "center";
    textStrip.style.width = "100%";

    _container.append(textStrip);


    _currentIndex = _rnd.nextInt(_imageList.length);
    _imageList[_currentIndex].classes.remove("no-height");

    new Timer.periodic(const Duration(seconds:10), nextRandomImage);
  }

  void nextRandomImage(Timer t)
  {
    int prevIndex = _currentIndex;
    while (_currentIndex == prevIndex) _currentIndex = _rnd.nextInt(_imageList.length);

    _imageList[prevIndex].style.opacity = _imageList[_currentIndex].style.opacity = "0";
    new Timer(const Duration(milliseconds: 600), ()
    {
      _imageList[prevIndex].classes.add("no-height");
      _imageList[_currentIndex].style.opacity = "1";
      _imageList[_currentIndex].classes.remove("no-height");
    });
  }

  final List<ImageElement> _imageList =
  [
    new ImageElement(src: "gfx/slide_1.jpg"),
    new ImageElement(src: "gfx/slide_2.jpg"),
    new ImageElement(src: "gfx/slide_3.jpg"),
    new ImageElement(src: "gfx/slide_4.jpg"),
    new ImageElement(src: "gfx/slide_5.jpg"),
    new ImageElement(src: "gfx/slide_6.jpg"),
    new ImageElement(src: "gfx/slide_7.jpg"),
    new ImageElement(src: "gfx/slide_8.jpg"),
    new ImageElement(src: "gfx/slide_9.jpg"),
    new ImageElement(src: "gfx/slide_10.jpg")
  ];

  int _currentIndex;
  final Random _rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  final Element _container;
}