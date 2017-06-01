import 'dart:async';
import 'dart:html';
import 'dart:math' show Random;

class SlideShow
{
  SlideShow(this._container)
  {
    _imageList.forEach(_container.append);
    _container.style.position = "relative";
    _container.style.marginBottom = "1rem";
    _container.style.backgroundColor = "white";

    for (int i = 0; i < _imageList.length; i++)
    {
      ImageElement img = _imageList[i];
      img.alt = "slide-$i";
      img.className = "no-height";
      img.style.display = "block";
      img.style.position = "relative";
      img.style.transition = "opacity 600ms ease";
      img.style.width = "100%";
      img.style.zIndex = "1";
      _container.append(img);
    }

    HeadingElement textStrip = new HeadingElement.h2();
    textStrip.classes.add("lang-exp");
    textStrip.dataset["exp"] = "frontpage_title";
    textStrip.style.textTransform = "inherit";
    textStrip.style.backgroundColor = "rgba(0,0,0,0.6)";
    textStrip.style.color = "white";
    textStrip.style.padding = "0.4em 0.1em";
    textStrip.style.margin = "-7rem auto 0 auto";
    textStrip.style.textAlign = "center";
    textStrip.style.position = "relative";
    textStrip.style.zIndex = "2";

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
  final String width = "1400px";
  final Random _rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  final Element _container;
}