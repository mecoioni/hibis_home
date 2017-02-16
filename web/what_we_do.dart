import 'dart:async';
import 'dart:html';
import 'page.dart';


DivElement more = querySelector("#more");
DivElement pads = querySelector("#pad-buttons");
DivElement button = querySelector("#more-button");
bool moreVisible = false;

void main()
{
  Page.init("what_we_do");
    
  //querySelector("#more-button").onClick.listen(toggleExtraContent);
  
  /// pads
  /*
  querySelector("#fraud-button").onClick.listen((_) => showPopup("fraud"));
  querySelector("#knowledge-button").onClick.listen((_) => showPopup("knowledge"));
  querySelector("#corruption-button").onClick.listen((_) => showPopup("corruption"));
  querySelector("#effectiveness-button").onClick.listen((_) => showPopup("effectiveness"));
  
  querySelector("#fraud-close").onClick.listen((_) => hidePopup("fraud"));
  querySelector("#knowledge-close").onClick.listen((_) => hidePopup("knowledge"));
  querySelector("#corruption-close").onClick.listen((_) => hidePopup("corruption"));
  querySelector("#effectiveness-close").onClick.listen((_) => hidePopup("effectiveness"));
   */
}

/*
void toggleExtraContent([Event e = null])
{
  if (moreVisible)
  {     
    more.style.maxHeight = "0";    
    new Timer(const Duration(milliseconds:500), ()
    {
      //pads.style.display = "inline";
      button.innerHtml = "Read more +";
    });
  }
  else
  {        
    button.innerHtml = "Read less -";
    more.style.maxHeight = "3300px";        
    //pads.style.display = "none";
  }  
  moreVisible = !moreVisible; 
}

void hidePopup(String name)
{
  DivElement background = querySelector("#popup-$name");
  if (background != null)
  {
    background.style.display = "none";
    background.style.opacity = "0";
  }
}

void showPopup(String name)
{
  DivElement background = querySelector("#popup-$name");
  if (background != null)
  {
    background.style.display = "block";
    background.style.opacity = "1";
  }
}
*/