/// Handles information about the 
/// gender and lifestyle. This information is
/// used in [gender] and [lifestyle]
library genderlifestyleinfo.dart;

import 'package:flutter/material.dart';

// used for returning a list of gender checkboxes
class Gender  {
  // a list of all of the gender checkboxes
  static final List<GenderCheckbox> checkboxList = [
    GenderCheckbox(gender: "Man"),
    GenderCheckbox(gender: "Woman"),
    GenderCheckbox(gender: "Nonbinary"),   
  ];

  static List<GenderCheckbox> getGenders(){
    return checkboxList;
  }
}

/// Contains the data structure for a gender checkbox. 
/// Used in [GenderPageState].
class GenderCheckbox {

  final String gender;
  bool value;

  GenderCheckbox({
    required this.gender, 
    this.value = false
  });
}

/// Contains a list of Lifestyle Infos
/// Used in [lifestyle].
/// If you want to add more lifestyles,
/// do it here.
class Lifestyles {
  static final List<LifestyleInfo> lifestyleList = [
    LifestyleInfo(lifestyle: "fishing"),
    LifestyleInfo(lifestyle: "gaming"),
    LifestyleInfo(lifestyle: "drinking"),
  ];

  static List<LifestyleInfo> getLifestyles(){
    return lifestyleList;
  }
}

/// Contains data for a single lifestyle.
/// Preference can be 
/// 0 for neutral, 
/// 1 for likes,
/// 2 for dislikes 
class LifestyleInfo {
  final String lifestyle;
  int preference;

  LifestyleInfo({
    required this.lifestyle,
    this.preference = 0,
  });

  int getPreference(){
    return preference;
  }
}

/// Used for making a stateful lifestyle button.
/// Notably, has a LifestyleInfo object.
// ignore: must_be_immutable
class LifestyleButton extends StatefulWidget {
  LifestyleInfo lifeObj;

  LifestyleButton({Key? key, required this.lifeObj}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LifestyleButtonState();
}

class LifestyleButtonState extends State<LifestyleButton> {

  int getPreference(){
    return widget.lifeObj.getPreference();
  }

  Color getColor(){
    if (widget.lifeObj.getPreference() == 0){
      return Theme.of(context).colorScheme.primary;
    }
    if (widget.lifeObj.getPreference() == 1){
      return Theme.of(context).colorScheme.secondary;
    }
    else {
      return Theme.of(context).colorScheme.onBackground;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        setState(() {
          widget.lifeObj.preference = (widget.lifeObj.preference + 1) % 3;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: getColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        elevation: 10,
      ),
      child: Text(widget.lifeObj.lifestyle),
    );
  }  
}

