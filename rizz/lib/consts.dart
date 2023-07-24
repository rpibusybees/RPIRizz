import 'package:flutter/material.dart';

class Consts {
  Consts._();
  static const EdgeInsets registerPadding =
      EdgeInsets.symmetric(horizontal: 30, vertical: 50);
  static const EdgeInsets loginPadding =
      EdgeInsets.symmetric(horizontal: 30, vertical: 100);

  // padding used to separate question from the textfield
  static const EdgeInsets questionPadding = 
      EdgeInsets.only(bottom: 25);
  
  // padding used to give some space from the horizontal bounds
  static const EdgeInsets fieldPadding =
    EdgeInsets.only(left: 30, right: 30);

  // padding used to space the bottom button out from
  // the other components
  static const EdgeInsets bottomButtonPadding =
    EdgeInsets.only(top: 50, bottom: 100);

  // padding used to space the questions in the 
  // gender and lifestyle pages
  static const EdgeInsets titleQuestionPadding =
    EdgeInsets.only(top: 50);

}
