import "dart:html";
import 'page.dart';


void main()
{
  Page.init("contact");

  querySelectorAll(".contact-button").onClick.listen(onButtonClick);
  querySelectorAll(".node").onClick.listen(onButtonClick);
}

void onButtonClick(Event e)
{
  Element source = e.target;
  querySelectorAll(".node").classes.remove("open");
  querySelectorAll(".body").classes.add("hide");

  String target = source.dataset["target"];

  querySelector("#small-body-$target").classes.remove("hide");
  querySelector("#large-body-$target").classes.remove("hide");
  querySelector("#node-$target").classes.add("open");

}