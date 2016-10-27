// Copyright (c) 2015, AppFoundry. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:math' show Random;
import 'page.dart';

int evilScore;
int evilbarContainerWidth;

void main()
{  
  new HonestyGame("honesty1.json");
}

class HonestyGame
{
  HonestyGame(String jsonFile)
  {
    HttpRequest.getString(jsonFile).then(_load).catchError((e) => print(e));
    _drawnQuestions = 0;
  }
  
  double _lerp(num min, num max, double t) 
  {
    return min + t * (max - min);
  }
  
  void _load(String data)
  {    
    Map<String, dynamic> dataMap = JSON.decode(data);    
    if (!dataMap.containsKey("questions")) throw new StateError("Missing required key: questions");
    if (!(dataMap["questions"] is List<String>)) throw new StateError("Invalid data: questions");
    if ((dataMap["questions"] as List<String>).isEmpty) throw new StateError("Invalid data: no questions");
    if (!dataMap.containsKey("feedback")) throw new StateError("Missing required key: feedback");
    if (!dataMap.containsKey("finally")) throw new StateError("Missing required key: finally");
    if (!dataMap.containsKey("prefix")) throw new StateError("Missing required key: prefix");
    if (!dataMap.containsKey("start-question")) throw new StateError("Missing required key: start-question");
    
    querySelector("#start-question").innerHtml = dataMap["start-question"];
    
    /// css animation is not fully supported in android, do it here instead
    _toggleScaleRecursive(querySelector("#angel"));
    new Timer(const Duration(seconds:1), () => _toggleScaleRecursive(querySelector("#devil")));    
        
    querySelector("#start-yes-button").onClick.first.then((_)
    {
      ParagraphElement p = new ParagraphElement();
      SpanElement part1 = new SpanElement();
      SpanElement part2 = new SpanElement();
      part1.innerHtml = "That's good, so please answer the following questions ";
      part2.innerHtml = "honestly.";
      _toggleBlinkRecursive(part2);
      
      p.children.add(part1);
      p.children.add(part2);
      _parseStart(p);
    });
    querySelector("#start-no-button").onClick.first.then((_)
    {
      ParagraphElement p = new ParagraphElement();
      p.innerHtml = "Not much point taking the test then, is there? But there are of course different levels of honesty - so why not take the test anyway?";
      _parseStart(p);
    });
    
    _feedback = dataMap["feedback"];   
    _finalFeedback = dataMap["finally"];
    _questionsPerPage = (dataMap.containsKey("per_page")) ? dataMap["per_page"] : 4;
    _questionPool = dataMap["questions"];    
    _totalQuestions = (dataMap.containsKey("total")) ? dataMap["total"] : _questionPool.length;  
    
    evilScore = 0;    
    _rnd = new Random();
    _currentQuestions = new List<Question>();    
    querySelector("#question-prefix").innerHtml = dataMap["prefix"];
          
    _container = querySelector("#question-container");
    _evilBar = querySelector("#evilbar");
    
    // Calculate the max influence of each question on the evilbar 
    Rectangle evilbarContainerRect = querySelector("#evilbar-container").getClientRects().first;
    evilbarContainerWidth = (evilbarContainerRect.right - evilbarContainerRect.left).toInt();    
    _questionScoreMax = (evilbarContainerWidth ~/ _totalQuestions);
          
    _clickListener = window.onClick.listen((_)
    {
      /// if all questions of the current page has been clicked, pull new questions from the pool
      try
      {        
        _currentQuestions.firstWhere((Question q) => !q.selected);                
      }
      on StateError catch (e) { _pullQuestions(_questionsPerPage); }       
      
      int currentBarWidth = ((evilbarContainerWidth ~/ 2) + evilScore);      
      _evilBar.style.width = currentBarWidth.toString() + "px";    
      
      int red = _lerp(0, 200, currentBarWidth/evilbarContainerWidth).toInt();
      _evilBar.style.backgroundColor = "rgba($red,175,175,255)";                      
    });    
    
    _pullQuestions(_questionsPerPage);
    Page.init("honesty");    
  }
  
  void _pullQuestions(int num_questions)
  {    
    _currentQuestions.clear();
    _container.children.clear();
        
    /// print conclusion based on current score, and cancel window.onclick subscription
    if (_questionPool.isEmpty || _drawnQuestions >= _totalQuestions)
    {
      _clickListener.cancel();
      while (_feedback.keys.length > 1)
      {        
        /// find the first key where the key has lower value than evilscore
        try
        {
          String found = _feedback.keys.firstWhere((String key)
          {
            return (evilScore < int.parse(key));        
          }); 
          if (found != null) _feedback.remove(found);
        }
        on StateError catch (e) { break; }
      }
      
      Element prefix = querySelector("#question-prefix");
      prefix.innerHtml = _feedback.values.first["title"];
      prefix.style.textAlign = "center";      
                 
      Element feedback = querySelector("#honesty-feedback");
      feedback.innerHtml = _feedback.values.first["description"];

      /// "Do you have any suggestions for other questions?" currently only for result "saint" 
      /// Must be put after feedback has been populated
      DivElement suggestions = querySelector("#honesty-suggestions");
      if (suggestions != null)
      { 
        SpanElement suggestionButton = querySelector("#honesty-suggestions-button");
        TextAreaElement suggestionTextArea = querySelector("#honesty-suggestions-textarea");
        if (suggestionButton != null && suggestionTextArea != null)
        {
          suggestionButton.onClick.firstWhere((_)
          {
            if (suggestionTextArea.value.isEmpty) return false;
            suggestions.children.clear();
            ParagraphElement thanks = new ParagraphElement();
            thanks.innerHtml = "Thank you!";
            thanks.style.textAlign = "center";
            suggestions.children.add(thanks);    
            return true;
          });
        }
      }             
      
      querySelector("#honesty-submit-job-function").style.display = "block";
      querySelector("#post-job-button").onClick.first.then((_)
      {
        querySelector("#honesty-submit-job-function").remove();
      });
      
      Element finalFeedback = querySelector("#honesty-final-feedback");
      finalFeedback.innerHtml = _finalFeedback;
      new Timer(const Duration(seconds:5), ()
      {        
        finalFeedback.style.opacity = "1";
      });
    }    
    else
    {    
      /// pull [num_questions] random questions from the pool    
      for (int i = 0; i < num_questions; i++)
      { 
        if (_questionPool.isEmpty || _drawnQuestions >= _totalQuestions) break;      
        String question = _questionPool[_rnd.nextInt(_questionPool.length)];
        
        /// If we roll 9 on d10, negate the score 
        bool negate = (_rnd.nextInt(10) + 1 == 10);
        int evilPoints = _rnd.nextInt(_questionScoreMax) + 1;
        if (negate == true) evilPoints *= -1;
        
        _currentQuestions.add(new Question(question, _container, evilPoints));                      
        _questionPool.remove(question);
        
        _drawnQuestions++;
      }
    }
  } 
  
  void _parseStart(ParagraphElement answer)
  {
    querySelector("#start-yes-button").remove();
    querySelector("#start-no-button").remove();
    querySelector("#start-answer").children.add(answer);
    
    new Timer(const Duration(seconds:4), ()
    {
      querySelector("#honesty-start-container").remove();
      querySelector("#honesty-game-container").style.visibility = "visible";
    });
  }
  
  void _toggleScaleRecursive(Element e)
  {
    e.style.transform = (e.style.transform == "scale(1, 1)") ? "scale(0.8, 0.8)" : "scale(1, 1)";
    new Timer(const Duration(seconds:1), () => _toggleScaleRecursive(e));        
  }
  
  void _toggleBlinkRecursive(Element e)
  {
    e.style.visibility = (e.style.visibility == "visible") ? "hidden" : "visible";
    new Timer(const Duration(milliseconds:500), () => _toggleBlinkRecursive(e));
  }
  
  
  Random _rnd;
  DivElement _evilBar;  
  DivElement _container;
  List<Question> _currentQuestions;
  Map<String, Map<String, String>> _feedback;
  String _finalFeedback;
  int _questionScoreMax;
  int _questionsPerPage;
  int _totalQuestions;
  int _drawnQuestions;
  List<String> _questionPool;
  
  var _clickListener;
}

class Question
{
  Question(String value, DivElement container, this._evilPoints)
  {
    if (value == null || value.isEmpty) throw new ArgumentError.notNull("value");
    if (container == null) throw new ArgumentError.notNull("container");    
    _root = new DivElement();
    _root.className = "question";
    _question = new ParagraphElement();
    _question.innerHtml = value;    
    _yes = new ImageElement(src:"gfx/honesty_yes.png");
    _no = new ImageElement(src:"gfx/honesty_no.png");    
    _selected = false;     
    _yes.onClick.first.then((_)
    {
      if (!_selected)
      {         
        evilScore += _evilPoints;
        int halfWidth = evilbarContainerWidth ~/ 2;
        if (evilScore < -halfWidth) evilScore = -halfWidth;
        _yes.style.opacity = "1";
        _no.style.opacity = "0.1";
        _selected = true;
      }       
    });    
    _no.onClick.first.then((_)
    {      
      if (!_selected)
      {                
        evilScore -= _evilPoints;
        int halfWidth = evilbarContainerWidth ~/ 2;
        if (evilScore > halfWidth) evilScore = halfWidth;
        _yes.style.opacity = "0.1";
        _no.style.opacity = "1";
        _selected = true;
      }
    });
    
    DivElement alternatives = new DivElement();
    alternatives.className = "alt";
    
    _root.children.add(_question);
    alternatives.children.add(_yes);
    alternatives.children.add(_no);
    _root.children.add(alternatives);
    container.children.add(_root);
  }
  
  bool get selected => _selected;
  ImageElement get yes => _yes;  
  ImageElement get no => _no;
  
  int _evilPoints;
  bool _selected;
  DivElement _root;
  ParagraphElement _question;
  ImageElement _yes;
  ImageElement _no;  
}