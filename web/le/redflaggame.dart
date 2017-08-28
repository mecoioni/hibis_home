// Copyright (c) 2015, AppFoundry. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import '../phrase.dart';
import 'package:elements/elements.dart' show StopwatchElement;

int flagNumber = 1;
int foundAnswers = 0;

void main()
{ 
  new FlagsGame("flags1.json");
}

class FlagsGame
{
  FlagsGame(String jsonFile)
  {
    HttpRequest.getString(jsonFile).then(_load).catchError((e) => print(e));    
    _completed = false;
  }
  
  void _load(String response)
  {
    try
    {
      Map<String, Map<String, dynamic>> data = JSON.decode(response);
      String host = Uri.base.host;
      String lang = (host.indexOf(".") == 2) ? host.substring(0, 2) : "en";

      Phrase phrase = new Phrase(lang);
      querySelectorAll(".lang-exp").forEach((Element e) => e.setInnerHtml(phrase.get(e.dataset["exp"]), validator: new TrustedNodeValidator()));

      _properties = data[lang];
    }
    on FormatException catch(e,s)
    {
      print(e);
      print(s);
      return;
    }
    
    if (!_properties.containsKey("background")) throw new StateError("Loading FlagsGame: Missing required key: background");    
    if (!_properties.containsKey("triggers")) throw new StateError("Loading FlagsGame: Missing required key: triggers");
    if (!_properties.containsKey("title")) throw new StateError("Loading FlagsGame: Missing required key: title");
    if (!_properties.containsKey("description")) throw new StateError("Loading FlagsGame: Missing required key: description");
    if (!_properties.containsKey("time-description")) throw new StateError("Loading FlagsGame: Missing required key: time-description");
    if (!_properties.containsKey("result")) throw new StateError("Loading FlagsGame: Missing required key: result");
    if (!_properties.containsKey("conclusion")) throw new StateError("Loading FlagsGame: Missing required key: conclusion");    
    if (!_properties.containsKey("limit")) throw new StateError("Loading FlagsGame: Missing required key: limit");


    _answerLimit = _properties["limit"];
    _canvas = querySelector("#flags-canvas");
    _canvas.style.width = (_properties.containsKey("w")) ? _properties["w"] : "300px";
    _canvas.style.height = (_properties.containsKey("h")) ? _properties["h"] : "300px";       
    _canvas.style.backgroundImage = "url(" + _properties["background"] + ")";        
    
    _triggers = new List<Trigger>();
    List<Map<String, String>> triggerProperties = _properties["triggers"];
    triggerProperties.forEach((trigger)
    {
      _triggers.add(new Trigger(trigger, _canvas, querySelector("#answers"), onFound : _evaluateCompleted));
    });      
    
    _title = querySelector("#flags-title");    
    _title.innerHtml = _properties["title"];
    
    _description = querySelector("#flags-conclusion");
    _description.innerHtml = _properties["description"];
    
    _timeDescription = new ParagraphElement();
    _timeDescription.innerHtml = _properties["time-description"];
    _timeDescription.className = "strong";
    _timeDescription.id = "time-description";
    _title.children.add(_timeDescription);
    
    _stopwatch = new StopwatchElement(60000, querySelector("#stopwatch-container"), delay:new Duration(seconds:2), onDone:_showRemainingAnswers);
    
    _conclusion = _properties["conclusion"];

    querySelectorAll(".unresolved").style.opacity = "1";
  }
  
  void _showRemainingAnswers()
  {       
    LIElement separator = null;
    if (_completed == false)
    {
      if (foundAnswers > 0)
      {
        separator = new LIElement();
        separator.className = "invisible fade";
        HRElement hr = new HRElement();
        separator.children.add(hr);
        querySelector("#answers").children.add(separator);
      }
      _completed = true;
      
      _triggers.forEach((Trigger trigger)
      {
        trigger.disable();    
      });      
    }       
     
    new Timer(const Duration(seconds:7), ()
    {
      if (separator != null) separator.style.opacity = "1";
      _triggers.forEach((Trigger trigger)
      {
        if (trigger.isNotFound) trigger.show();
      });
    });

    String result = _properties["result"];
    _timeDescription.innerHtml = result.replaceFirst("%", foundAnswers.toString()); //"You found " + (foundAnswers).toString() + " flag(s)!";
    
    new Timer(const Duration(seconds:2), ()
    {
      //ParagraphElement conclusion = querySelector("#flags-conclusion");
      _description.innerHtml = _conclusion;
    });
    
    _stopwatch.stop();
  }
  
  void _evaluateCompleted()
  {    
    if (foundAnswers >= _answerLimit && _completed == false)
    {      
      _showRemainingAnswers();             
    }
  }
  
  bool _completed;
  Map<String, dynamic> _properties;    
  DivElement _canvas;
  List<Trigger> _triggers;
  HeadingElement _title;
  ParagraphElement _description;
  ParagraphElement _timeDescription;
  StopwatchElement _stopwatch;
  String _conclusion;
  int _answerLimit; /// the number of answers that must be answered before evaluateCompleted() passes
}

typedef void FoundCallback();

class Trigger
{
  Trigger(Map<String, String> properties, DivElement triggerContainer, this._answerContainer, { FoundCallback onFound : null })
  {

    if (properties == null || triggerContainer == null || _answerContainer == null) throw new ArgumentError.notNull();
    if (!properties.containsKey("flag")) throw new StateError("Loading FlagsGame: Missing required key: flag");
    if (!properties.containsKey("description")) throw new StateError("Loading FlagsGame: Missing required key: description");
    if (!properties.containsKey("w")) throw new StateError("Loading FlagsGame: Missing required key: w");
    if (!properties.containsKey("h")) throw new StateError("Loading FlagsGame: Missing required key: h");
    if (!properties.containsKey("x")) throw new StateError("Loading FlagsGame: Missing required key: x");
    if (!properties.containsKey("y")) throw new StateError("Loading FlagsGame: Missing required key: y");

    _flagSrc = properties["flag"];
    
    _onFound = onFound;
    
    _userFound = false;    
    _flag = new ImageElement();
    _flag.src = _flagSrc;    
    _flag.className = "flag";
    
    _flagNumber = new SpanElement();
    _answerNumber = new SpanElement();    
    _flagNumber.className = "flag-number";
    _answerNumber.className = "answer-number";        
    
    if (properties.containsKey("btw-flag"))
    {      
      _btwFlag = new ImageElement();
      _btwFlag.src = properties["btw-flag"];
      _btwFlag.className = "btw-flag";
    }        
    
    _zone = new DivElement();      
    _zone.className = "trigger-zone fade";      
    _zone.style.width = properties["w"];
    _zone.style.height = properties["h"];      
    _zone.style.left = properties["x"];
    _zone.style.top = properties["y"];        
    _clickListener = _zone.onClick.listen(show);     
    triggerContainer.children.add(_zone);
    _zone.children.add(_flagNumber);
    
    _answer = new LIElement();           
    SpanElement text = new SpanElement();
    text.appendHtml(properties["description"]);
    _answer.children.add(text);
    _answer.className = "invisible fade";
    
    if (_btwFlag != null)
    {
      _btwAnswer = new LIElement();
      if (properties.containsKey("btw-description")) _btwAnswer.appendHtml(properties["btw-description"]);
      else _btwAnswer.appendHtml(properties["description"]);
      _btwAnswer.className = "invisible fade";
    }
  }
  
  void disable()
  {
    if (_clickListener != null) _clickListener.cancel();
  }
  
  bool show([Event e = null])
  {
    if (_userFound == true) return false;    
    _userFound = (e != null);    
    
    if (_userFound) foundAnswers++;
    
    /// if the user didnt find this zone, and it has a btw-flag, delay and show btw-flag + btw-description (instead of regular)
    if (!_userFound && _btwFlag != null)
    {
      _zone.children.add(_btwFlag);
      _zone.children.add(_flag);
      ImageElement answerFlag = new ImageElement(src:_flagSrc);
      answerFlag.className = "answer-number";
      _btwAnswer.children.insert(0, answerFlag);
      _answerContainer.children.add(_btwAnswer);
      _flagNumber.innerHtml = flagNumber.toString();
      new Timer(const Duration(seconds:8), ()
      {        
        _zone.style.opacity = "1";                                          
        new Timer(const Duration(milliseconds:300), () => _btwAnswer.style.opacity = "1");
      });      
    }
    else if (!_userFound)
    {
      _zone.children.add(_flag);      
      _zone.style.opacity = "1";      
      ImageElement answerFlag = new ImageElement(src:_flagSrc);
      answerFlag.className = "answer-number";
      _answer.children.insert(0, answerFlag);
      _answerContainer.children.add(_answer);
      new Timer(const Duration(milliseconds:300), () => _answer.style.opacity = "1");
      _flagNumber.innerHtml = flagNumber.toString();
      flagNumber++;      
    }
    else
    {      
      _answer.children.insert(0,_answerNumber);          
      _zone.children.add(_flag);      
      _zone.style.opacity = "1";
           
      _answerContainer.children.add(_answer);
      new Timer(const Duration(milliseconds:300), () => _answer.style.opacity = "1");
      _flagNumber.innerHtml = _answerNumber.innerHtml = flagNumber.toString();
      flagNumber++;
    }        
    
    /// set user found to true regardless, to prevent the user from clicking it again
    _userFound = true;
    
    if (_onFound != null) _onFound(); 
    
    return true;   
  }
  
  bool get isNotFound => !_userFound;
  LIElement get btwAnswer => _btwAnswer; 
  
  bool _userFound;
  DivElement _zone;
  UListElement _answerContainer;
  LIElement _answer;
  LIElement _btwAnswer;
  ImageElement _flag;
  ImageElement _btwFlag;    
  SpanElement _flagNumber, _answerNumber;  
  FoundCallback _onFound; 
  
  StreamSubscription _clickListener;
  String _flagSrc;
}

/// A [NodeValidator] which allows everything.
class TrustedNodeValidator implements NodeValidator
{
  bool allowsElement(Element element) => true;
  bool allowsAttribute(element, attributeName, value) => true;
}

