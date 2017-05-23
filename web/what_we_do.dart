import 'dart:async';
import 'dart:html';
import 'slideshow.dart';
import 'page.dart';


DivElement more = querySelector("#more");
DivElement pads = querySelector("#pad-buttons");
DivElement button = querySelector("#more-button");
bool moreVisible = false;

void main()
{
  new Slideshow(querySelector(".slideshow-container"));
  Page.init("what_we_do");

  querySelectorAll(".collapse-toggle").forEach((e) => e.onClick.listen(toggleCollapsed));
}

void toggleCollapsed(Event e)
{
  Element source = e.target;
  Element target = querySelector("#${source.dataset["target"]}");
  if (target.classes.contains("collapsed"))
  {
    source.classes.add("open");
    target.classes.remove("collapsed");
  }
  else
  {
    source.classes.remove("open");
    target.classes.add("collapsed");
  }


}