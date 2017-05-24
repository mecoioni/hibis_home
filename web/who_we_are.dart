import 'dart:html';
import 'slideshow.dart';
import 'page.dart';

void main()
{
  new SlideShow(querySelector(".slide-container"));
  Page.init("who_we_are");
}
