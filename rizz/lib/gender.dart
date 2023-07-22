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
  final List<GenderCheckbox> checkboxList = [
    GenderCheckbox(gender: "Man"),
    GenderCheckbox(gender: "Woman"),
    GenderCheckbox(gender: "Nonbinary"),
  ];

  // function to upload data to database
  void uploadGenderToDatabase(checkboxList){

  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
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
            Expanded(
              child: ListView.builder(
                itemCount: checkboxList.length,
                itemBuilder: (BuildContext context, int index){
                  final checkbox = checkboxList[index];
                  return CheckboxListTile(
                    value: checkbox.value,
                    title: Text(checkbox.gender), 
                    onChanged: (value){
                      setState(() {
                        checkbox.value = value ?? false;
                      });
                      print("changing value to $value");
                    }
                  );
                },
              ),
            ),
            
            Container(
              margin: Consts.bottomButtonPadding,
              child: NextButton(
                onPressed: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );

                }
              ),
            ),
          ],
        ),
      ),
    );

    
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