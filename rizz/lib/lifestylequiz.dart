/// This page handles the lifestyles that
/// the user wants in others. We create a lifestyle button which
/// has a lifestyle info object in it
library lifestylequiz.dart;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rizz/seeking.dart';
import 'consts.dart';
import 'genderlifestyleinfo.dart';
import 'nextbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'aboutme.dart';

/// Used to create a 
/// [LifestylequizPageState]
class LifestyleQuizPage extends StatefulWidget{
  const LifestyleQuizPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LifestyleQuizPageState();
}

class LifestyleQuizPageState extends State<LifestyleQuizPage>{

  @override
  void initState() {
    super.initState();
  }

  List<LifestyleInfo> lifestyles = Lifestyles.getLifestyles();

  // returns the likes as a string
  List<String> getLikes(){
    List<String> likes = [];
    for(int i = 0; i < lifestyles.length; i++){
      if(lifestyles[i].preference == 1){
         likes.add(lifestyles[i].lifestyle);
      }
    }
    return likes;
  }

  // returns the dislikes as a string
  List<String> getDislikes(){
    List<String> dislikes = [];
    for(int i = 0; i < lifestyles.length; i++){
      if(lifestyles[i].preference == 2){
        dislikes.add(lifestyles[i].lifestyle);
      }
    }
    return dislikes;
  }

  // Upload lifestlyes the user feels about THEMSELF
  void uploadLifestyleQuizToDatabase() async {
    User? user = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;
    await db.collection('users').doc(user!.uid).update({"theirLikes": getLikes(), "theirDislikes": getDislikes()});
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
                'Lifestyle Quiz',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: lifestyles.length,
                itemBuilder: (BuildContext context, int index){
                  final lifestyle = lifestyles[index];
                  return LifestyleButton(lifeObj: lifestyle);
                },
              ),
            ),
            
            Container(
              margin: Consts.bottomButtonPadding,
              child: NextButton(
                onPressed: (){
                  uploadLifestyleQuizToDatabase();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutMePage()),
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