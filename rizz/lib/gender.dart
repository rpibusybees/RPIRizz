/// The user will be asked for what
/// gender(s) they identify as.
/// This value(s) will be uploaded 
/// into the database.
library gender;
import 'package:flutter/material.dart';
import 'package:rizz/nextbutton.dart';
import 'consts.dart';
import 'login.dart';

/// Used for making the Gender Page.
class GenderPage extends StatefulWidget{
  const GenderPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GenderPageState();
}

/// Makes the Gender Page. 
/// Contains text, a list of checkboxes, and the confirm button.
class GenderPageState extends State<GenderPage>{

  @override
  void initState() {
    super.initState();
  }

  // a list of all of the checkboxes
  final checkboxList = [
    genderCheckbox(gender: "Man"),
    genderCheckbox(gender: "Woman"),
    genderCheckbox(gender: "Nonbinary"),

  ];

  @override
  Widget build(BuildContext context){
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Container(
            padding: Consts.titleQuestionPadding,
            child: Text(
              'What do you identify as?',
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              
            )
          ),
          NextButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }
          ),
        ],
      ),
    );

    
  }
}


class genderCheckbox {
  String gender;
  bool value;

  genderCheckbox({required this.gender, this.value = false});
}