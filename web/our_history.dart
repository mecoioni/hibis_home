import "dart:html";
import 'slideshow.dart';
import 'page.dart';

void main()
{
  new SlideShow(querySelector(".slide-container"));
  Page.init("our_history");
  
}