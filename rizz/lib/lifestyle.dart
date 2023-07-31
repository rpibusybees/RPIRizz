/// This page handles the lifestyles that
/// the user has. We create a lifestyle button which
/// has a lifestyle info object in it
library lifestyle.dart;

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rizz/seeking.dart';
import 'consts.dart';
import 'genderlifestyleinfo.dart';
import 'nextbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Used to create a
/// [LifestylePageState]
class LifestylePage extends StatefulWidget {
  const LifestylePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LifestylePageState();
}

class LifestylePageState extends State<LifestylePage> {
  @override
  void initState() {
    super.initState();
  }

  List<LifestyleInfo> lifestyles = Lifestyles.getLifestyles();

  // returns the likes as a string
  List<String> getLikes() {
    List<String> likes = [];
    for (int i = 0; i < lifestyles.length; i++) {
      if (lifestyles[i].preference == 1) {
        likes.add(lifestyles[i].lifestyle);
      }
    }
    return likes;
  }

  // returns the dislikes as a string
  List<String> getDislikes() {
    List<String> dislikes = [];
    for (int i = 0; i < lifestyles.length; i++) {
      if (lifestyles[i].preference == 2) {
        dislikes.add(lifestyles[i].lifestyle);
      }
    }
    return dislikes;
  }

  // Upload lifestlyes the user feels about THEMSELF
  void uploadLifestyleToDatabase() async {
    User? user = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;
    await db
        .collection('users')
        .doc(user!.uid)
        .update({"myLikes": getLikes(), "myDislikes": getDislikes()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: Consts.lifestyleBubblePadding,
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            Container(
              padding: Consts.titleQuestionPadding,
              child: Text(
                'I like/dislike...',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Click once to like and twice to dislike',
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: lifestyles
                      .map((lifestyle) => LifestyleButton(lifeObj: lifestyle))
                      .toList(),
                ),
              ),
            ),
            Container(
              margin: Consts.bottomButtonPadding,
              child: NextButton(onPressed: () {
                uploadLifestyleToDatabase();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SeekingPage()),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
