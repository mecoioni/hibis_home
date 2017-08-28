// Copyright (c) 2015, AppFoundry. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'slideshow.dart';
import 'page.dart';
import 'phrase.dart';

final Phrase phrase = new Phrase("en");
final ElementList<Element> bodies = querySelectorAll(".body");
final ElementList<Element> cityButtons = querySelectorAll(".contact-button");
final ElementList<Element> cityNodes = querySelectorAll(".node");
final ElementList<Element> cityOutputs = querySelectorAll(".city-output");
final ElementList<Element> addressOutputs = querySelectorAll(".address-output");
final ElementList<Element> contactOutputs = querySelectorAll(".contact-output");
final NodeValidator validator = new NodeValidatorBuilder.common()..allowNavigation(new EmailUriPolicy());

void main()
{
  new SlideShow(querySelector(".slide-container"));

  querySelectorAll(".collapse-toggle").onClick.listen(toggleCollapsed);
  querySelectorAll(".arrow-up-icon").onClick.listen((_) => window.scrollTo(0, 0));

  cityButtons.onClick.listen(onButtonClick);
  cityNodes.onClick.listen(onButtonClick);

  Page.init(null);
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
