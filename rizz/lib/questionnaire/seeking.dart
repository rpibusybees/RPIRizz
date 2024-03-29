/// This page is about the genders that the user
/// is seeking out for in others.
library seeking.dart;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rizz/nextbutton.dart';
import '../consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'genderlifestyleinfo.dart';
import 'lifestylequiz.dart';

/// Used for making the Seeking Page.
class SeekingPage extends StatefulWidget{
  const SeekingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SeekingPageState();
}

/// Makes the Seeking Page. 
/// Contains text, a list of checkboxes, and the confirm button.
class SeekingPageState extends State<SeekingPage>{

  @override
  void initState() {
    super.initState();
  }

  List<GenderCheckbox> checkboxList = Gender.getGenders();
  List<String> getGender(){
    List<String> genders = [];
    for(int i = 0; i < checkboxList.length; i++){
      if(checkboxList[i].value){
         genders.add(checkboxList[i].gender);
      }
    }
    return genders;
  }

  // function to upload data to database
  void uploadSeekingToDatabase() async{
    User? user = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;
    await db.collection('users').doc(user!.uid).update({"seeking": getGender()});
  }

    // pop-up for when no genders are added
  // for when the user puts in an empty name
  void textPopup(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
          content: const Text(
            "Please select at least one gender."
          ),
          title: const Text('Error'),
        ),
      );
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
                'I am looking to date a ',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
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
                  if (!Gender.noneChecked()){
                    uploadSeekingToDatabase();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LifestyleQuizPage()),
                    );
                  }
                  else {
                    textPopup();
                  }

                }
              ),
            ),
          ],
        ),
      ),
    );    
  }
}