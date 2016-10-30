// Copyright (c) 2015, AppFoundry. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';
import 'page.dart';

void main() 
{
  Page.init(null); 
  
//  DivElement buttonSpotContainer = querySelector("#button-spot-container");
//  DivElement buttonHonestyContainer = querySelector("#button-honesty-container");
  
  img["eye_closed"] = new ImageElement(src:"gfx/eye_closed.png");
  img["eye_center"] = new ImageElement(src:"gfx/eye_center.png");
  img["eye_left"] = new ImageElement(src:"gfx/eye_left.png");
  img["eye_right"] = new ImageElement(src:"gfx/eye_right.png");

  runFullSlideshow();    
}

void runFullSlideshow()
{
  /// 1st text ("dont be scared...")
  setElementVisibility(querySelector("#slideshow-text-1"), const Duration(milliseconds:500), const Duration(seconds:2));
  
  /// 2nd text ("...it happens")
  setElementVisibility(querySelector("#slideshow-text-2"), const Duration(seconds:4), const Duration(seconds:2));   
  
  /// 3rd text ("open your eyes")
  setElementVisibility(querySelector("#slideshow-text-3"), const Duration(seconds:7), const Duration(seconds:12));
  ImageElement eyes = querySelector("#slideshow-eyes"); 
  setElementVisibility(eyes, const Duration(seconds:7), const Duration(seconds:12));
  
  new Timer(const Duration(seconds:7), () => eyes.src = img["eye_center"].src);
  new Timer(const Duration(seconds:8), () => eyes.src = img["eye_left"].src);
  new Timer(const Duration(seconds:9), () => eyes.src = img["eye_right"].src);
  new Timer(const Duration(seconds:10), () => eyes.src = img["eye_center"].src);
  new Timer(const Duration(seconds:11), () => eyes.src = img["eye_closed"].src);
  new Timer(const Duration(milliseconds:11250), () => eyes.src = img["eye_center"].src);
  
  /// 4th text ("Find, interpret...")
  setElementVisibility(querySelector("#slideshow-text-4"), const Duration(milliseconds:11750), const Duration(seconds:7));
  setElementScale(querySelector("#slideshow-text-4-1"), const Duration(seconds:13), const Duration(seconds:6));
  setElementScale(querySelector("#slideshow-text-4-2"), const Duration(seconds:14), const Duration(seconds:5));
  setElementScale(querySelector("#slideshow-text-4-3"), const Duration(seconds:15), const Duration(seconds:4), onDone: runFullSlideshow);
}

void setElementVisibility(Element e, Duration delay, Duration duration, {Function onDone : null})
{    
  new Timer(delay, ()
  {
    e.style.opacity = "1";    
    new Timer(duration, ()
    {
      e.style.opacity = "0";
      if (onDone != null) onDone();
    });
  });     
}

void setElementScale(Element e, Duration delay, Duration duration, {Function onDone : null})
{
  new Timer(delay, ()
  {
    e.style.transform = "scale(1,1)"; 
    e.style.opacity = "1";    
    new Timer(duration, ()
    {
      e.style.opacity = "0";
      if (onDone != null) onDone();
    });
  });
}



