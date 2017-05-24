import "dart:html";
import 'slideshow.dart';
import 'page.dart';
import 'phrase.dart';

final Phrase phrase = new Phrase("en");
final ElementList<Element> bodies = querySelectorAll(".body");
final ElementList<Element> cityButtons = querySelectorAll(".contact-button");
final ElementList<Element> cityNodes = querySelectorAll(".node");
final ElementList<Element> cityOutputs = querySelectorAll(".city-output"); //largeBodyContainer.querySelector("#large-body-city");
final ElementList<Element> addressOutputs = querySelectorAll(".address-output"); //largeBodyContainer.querySelector("#large-body-address");
final ElementList<Element> contactOutputs = querySelectorAll(".contact-output");//largeBodyContainer.querySelector("#large-body-contact");

final NodeValidator validator = new NodeValidatorBuilder.common()..allowNavigation(new EmailUriPolicy());

void main()
{
  new SlideShow(querySelector(".slide-container"));
  Page.init("contact");

  cityButtons.onClick.listen(onButtonClick);
  cityNodes.onClick.listen(onButtonClick);
}

void onButtonClick(Event e)
{
  Element source = e.target;
  cityNodes.classes.remove("open");
  cityButtons.classes.remove("open");
  bodies.classes.remove("hide");

  String target = source.dataset["target"];

  cityOutputs.forEach((e) => e.setInnerHtml(phrase.get("$target")));
  addressOutputs.forEach((e) => e.setInnerHtml(phrase.get("address_$target")));
  contactOutputs.forEach((e) => e.setInnerHtml(phrase.get("contact_$target"), validator: validator));

  querySelector("#node-$target")?.classes?.add("open");
  querySelector("#button-$target")?.classes?.add("open");
}

class EmailUriPolicy implements UriPolicy
{
  EmailUriPolicy();

  bool allowsUri(String uri)
  {
    return uri.startsWith("mailto:");
  }
}