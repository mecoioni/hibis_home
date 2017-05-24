// Copyright (c) 2015, AppFoundry. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'slideshow.dart';
import 'page.dart';

void main() 
{
  new SlideShow(querySelector(".slide-container"));
  Page.init(null);
}
