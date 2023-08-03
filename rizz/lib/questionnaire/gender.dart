/// The user will be asked for what
/// gender(s) they identify as.
/// This value(s) will be uploaded
/// into the database.
library gender;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rizz/nextbutton.dart';
import '../consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'genderlifestyleinfo.dart';
import 'lifestyle.dart';

/// Used for making the Gender Page.
class GenderPage extends StatefulWidget {
  const GenderPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GenderPageState();
}

/// Makes the Gender Page.
/// Contains text, a list of checkboxes, and the confirm button.
class GenderPageState extends State<GenderPage> {
  @override
  void initState() {
    super.initState();
  }

  List<GenderCheckbox> checkboxList = Gender.getGenders();
  List<String> getGender() {
    List<String> genders = [];
    for (int i = 0; i < checkboxList.length; i++) {
      if (checkboxList[i].value) {
        genders.add(checkboxList[i].gender);
      }
    }
    return genders;
  }

  // function to upload data to database
  void uploadGenderToDatabase() async {
    User? user = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;
    await db.collection('users').doc(user!.uid).update({"gender": getGender()});
  }

  @override
  Widget build(BuildContext context) {
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
              flex: 1,
              child: ListView.builder(
                itemCount: checkboxList.length,
                itemBuilder: (BuildContext context, int index) {
                  final checkbox = checkboxList[index];
                  return CheckboxListTile(
                      value: checkbox.value,
                      title: Text(checkbox.gender),
                      onChanged: (value) {
                        setState(() {
                          checkbox.value = value ?? false;
                        });
                        print("changing value to $value");
                      });
                },
              ),
            ),
            Container(
              margin: Consts.bottomButtonPadding,
              child: NextButton(onPressed: () {
                uploadGenderToDatabase();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LifestylePage()),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
