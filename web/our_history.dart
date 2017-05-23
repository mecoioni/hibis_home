import "dart:html";
import 'slideshow.dart';
import 'page.dart';

void main()
{
  new Slideshow(querySelector(".slide-container"));
  Page.init("our_history");
  
}