/// This is the page where the user enters their name.
/// This value is stored into the database under the user's id.
library name;

import 'package:flutter/material.dart';
import 'birthday.dart';
import 'consts.dart';
import 'nextbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'spacingbox.dart';


/// Needed for the [NamePageState] class.
class NamePage extends StatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NamePageState();
}

/// Contain sizedBox (for spacing), text, text-field, and button.
/// This is used for saving the user's name to the database
/// and going to the [birthday] page.
class NamePageState extends State<NamePage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // adds name to database
  void addNameToDatabase(String name) async {
    User? user = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;
    await db.collection('users').doc(user!.uid).update({"name": name});
  }

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
            "Please enter a name."
          ),
          title: const Text('Error'),
        ),
      );
  }

  /*
  * Sized Box
  * Text
  * Text Field
  * Confirm button (takes the user to [birthday.dart] and puts name in
  * [addNameToDatabase]))
  */
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SpacingBox(),
            Container(
              padding: Consts.questionPadding,
              child: Text(
                'What is your name?',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
            
            Container(
              padding: Consts.fieldPadding,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1, 
                      color: Theme.of(context).colorScheme.onSurface
                    )
                  ),
                  hintText: 'Name',
                ),
              ),
            ),
            const SpacingBox(),
            Container(
              margin: Consts.bottomButtonPadding,
              child: NextButton(
                onPressed: (){
                  String name = controller.text;
                  if (name.isNotEmpty) {
                    addNameToDatabase(name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BirthdayPage()),
                    );
                  }
                  else{
                    textPopup();
                  }
                  
                }
              ),
            ),
          ]
        ),
      )
    );  
  }
}
