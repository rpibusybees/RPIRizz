/// This page will ask for the user's birthday
/// and save it to the database

library birthday;
import 'package:flutter/material.dart';
import 'package:rizz/nextbutton.dart';
import 'package:rizz/spacingbox.dart';
import 'consts.dart';
import 'gender.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BirthdayPage extends StatefulWidget{
  const BirthdayPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BirthdayPageState();
}

class BirthdayPageState extends State<BirthdayPage>{
    final TextEditingController yearController = TextEditingController();
    final TextEditingController monthController = TextEditingController();
    final TextEditingController dayController = TextEditingController();

    @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    yearController.dispose();
    monthController.dispose();
    dayController.dispose();
    super.dispose();
  }

  // adds birthday to database
  void addBirthdayToDatabase(DateTime birthday) async {
    //parse through birthday to get day month year
    User? user = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;
    await db.collection('users').doc(user!.uid).update({"birthday": birthday});
  }

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
                'What is your date of birth?',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
            
            Container(
              padding: Consts.fieldPadding,
              child: Row(
                children: [ 
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: monthController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1, 
                            color: Theme.of(context).colorScheme.onSurface
                          )
                        ),
                        hintText: "Month"
                      )
                    ),
                  ),

                  const SizedBox(
                    width: 15
                    ),

                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: dayController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1, 
                            color: Theme.of(context).colorScheme.onSurface
                          )
                        ),
                        hintText: "Day"
                      )
                    ),
                  ),

                  const SizedBox(
                    width: 15
                    ),

                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: yearController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1, 
                            color: Theme.of(context).colorScheme.onSurface
                          )
                        ),
                        hintText: "Year"
                      )
                    ),
                  ),
                ]
              )
            ),
            const SpacingBox(),
            Container(
              margin: Consts.bottomButtonPadding,
              child: NextButton(onPressed: (){
                // TODO: See if birthday is valid
                String year = yearController.text;
                String month = monthController.text;
                String day = dayController.text;
                String yearmonthday = year + month + day;
                DateTime birthday = DateTime.parse(yearmonthday);
                addBirthdayToDatabase(birthday);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GenderPage()),
                );
              })
            ),
          ]
        ),
      )
    );  
  }
}
