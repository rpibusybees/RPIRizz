import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Consts {
  Consts._();
  static const EdgeInsets registerPadding =
      EdgeInsets.symmetric(horizontal: 30, vertical: 50);
  static const EdgeInsets loginPadding =
      EdgeInsets.symmetric(horizontal: 30, vertical: 100);

  // padding used to separate question from the textfield
  static const EdgeInsets questionPadding = EdgeInsets.only(bottom: 25);

  // padding used to give some space from the horizontal bounds
  static const EdgeInsets fieldPadding = EdgeInsets.only(left: 30, right: 30);

  // padding used to space the bottom button out from
  // the other components
  static const EdgeInsets bottomButtonPadding =
      EdgeInsets.only(top: 50, bottom: 50);

  // padding used to space the questions in the
  // gender and lifestyle pages
  static const EdgeInsets titleQuestionPadding = EdgeInsets.only(top: 50);
  
  static const EdgeInsets midPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 20);
  static const EdgeInsets lowPadding =
      EdgeInsets.symmetric(horizontal: 10, vertical: 10);
  static const EdgeInsets sidePadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 0);
  static const EdgeInsets vertPadding =
      EdgeInsets.symmetric(horizontal: 0, vertical: 20);
  static const EdgeInsets lowVertPadding =
      EdgeInsets.symmetric(horizontal: 0, vertical: 15);
  static const EdgeInsets noPadding =
      EdgeInsets.symmetric(horizontal: 0, vertical: 0);
  // padding used for containing the lifestyle and other bubbles
  // in the lifestyle quiz
  static const EdgeInsets lifestyleBubblePadding =
      EdgeInsets.only(left: 15, right: 15);
  static const EdgeInsets chatPadding =
      EdgeInsets.symmetric(horizontal: 2, vertical: 2);
  static const Center loadingHeart =  Center(
        child: SpinKitPumpingHeart(
        color: Color.fromRGBO(188, 83, 100, 1),
        size: 50.0,
      ),
      );
}
