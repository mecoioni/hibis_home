import 'dart:html';
import 'page.dart';

void main()
{
  Page.init("who_we_are");
  
  /*
  ElementList<DivElement> cardContainers = querySelectorAll(".card-container");
  cardContainers.forEach((DivElement card)
  {    
    card.onMouseEnter.listen((_) => toggleCard(card));
    card.onMouseLeave.listen((_) => toggleCard(card));    
    card.onTouchStart.listen((_) => toggleCard(card));    
  });
  */
  /*
  DivElement moreButton = querySelector("#more-button");
  moreButton.onClick.listen((_)
  {
    DivElement page1 = querySelector("#page-1");
    DivElement page2 = querySelector("#page-2");
    
    if (page1.style.display == "none")
    {    
      page2.style.display = "none";
      page1.style.display = "block";
      moreButton.innerHtml = "More +";
    }
    else
    {
      page1.style.display = "none";
      page2.style.display = "block";
      moreButton.innerHtml = "Back -";
    }
  });
  */
}

/*
void toggleCard(DivElement card)
{
  if (card.children.first.style.transform == "rotateY(180deg)")
  {
    card.children.first.style.transform = "rotateY(0deg)";
    card.children.last.style.transform = "rotateY(-180deg)";
  }
  else
  {
    card.children.first.style.transform = "rotateY(180deg)";
    card.children.last.style.transform = "rotateY(0deg)";
  }  
}*/