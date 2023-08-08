/// This page will ask for the user's birthday
/// and save it to the database

library birthday;
import 'package:flutter/material.dart';
import 'package:rizz/nextbutton.dart';
import 'package:rizz/spacingbox.dart';
import '../consts.dart';
import 'gender.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

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

  bool isValid(String year, String month, String day){
    
    if(year.length != 4){
      return false;
    }
    int yearNum = int.parse(year);
    int monthNum = int.parse(month);
    int dayNum = int.parse(day);

    if(yearNum > DateTime.now().year){
      return false;
    }
    if(monthNum > 12 || monthNum < 1){
      return false;
    }

    var daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31];
    var daysInMonthLeap = [31,29,31,30,31,30,31,31,30,31,30,31];

    if(yearNum % 4 == 0){
      if(daysInMonthLeap[monthNum-1] < dayNum){
        return false;
      }
    }
    else{
      if(daysInMonth[monthNum-1] < dayNum){
        return false;
      }
    }

    return true;
  }

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
            "Please enter a valid birthday."
          ),
          title: const Text('Error'),
        ),
      );
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
                      inputFormatters:[
                        FilteringTextInputFormatter.digitsOnly
                      ],
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
                String year = yearController.text;
                String month = monthController.text;
                String day = dayController.text;
                if (isValid(year, month, day)){
                  // the entry was valid
                  if (month.length < 2) {month = "0$month";}
                  if (day.length < 2) {day = "0$day";}
                  String yearmonthday = year + month + day;
                  DateTime birthday = DateTime.parse(yearmonthday);
                  addBirthdayToDatabase(birthday);
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GenderPage()),
                  );
                }
                else{
                  // say the entry was not valid
                  textPopup();
                }
                
              })
            ),
          ]
        ),
      )
    );  
  }
}
