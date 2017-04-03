import "dart:html";
import 'page.dart';


void main()
{
  Page.init("contact");
  
  List<Element> buttons = querySelectorAll(".button");
  buttons.forEach((Element button)
  {
    String city = button.id.substring("button-".length);
    List<Element> bodies = querySelectorAll("#body-" + city).toList(growable: true);
    bodies.addAll(querySelectorAll("#body-" + city + "-small"));

    Element node = querySelector("#node-" + city);
    
    button.onMouseOver.listen((_) => toggleBody(bodies, node));
    button.onTouchStart.listen((_) => toggleBody(bodies, node));
  });
  
  
  List<Element> nodes = querySelectorAll(".node");
  nodes.forEach((Element node)
  {
    if (node.id.length == 0) return;
    
    String city = node.id.substring("node-".length);    
    List<Element> bodies = querySelectorAll("#body-" + city);
        
    node.onClick.listen((_) => toggleBody(bodies, node));
    node.onTouchStart.listen((_) => toggleBody(bodies, node));
  });
  
  ElementList<ImageElement> closeButtons = querySelectorAll(".body-close");
  closeButtons.forEach((img)
  {
    img.onClick.listen((_)
    {
      img.parent.style.display = "none";
      querySelectorAll(".node").style.display = "block";
    });
  });
}

void toggleBody(List<Element> bodies, Element node)
{
  querySelectorAll(".body").forEach((Element b)
  {
    b.style.display = "none";        
  });      
         
  querySelectorAll(".node").style.display = "block";
  
  bodies.forEach((Element body)
  {
    body.style.display = "block";
  });
  node.style.display = "none";
}