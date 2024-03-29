/// This is the page where the user enters their name.
/// This value is stored into the database under the user's id.
library aboutme;

import 'package:flutter/material.dart';
import 'photos.dart';
import '../consts.dart';
import '../nextbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../spacingbox.dart';

/// Needed for the [AboutMePageState] class.
class AboutMePage extends StatefulWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AboutMePageState();
}

/// Contain sizedBox (for spacing), text, text-field, and button.
/// This is used for saving the user's name to the database
/// and going to the [birthday] page.
class AboutMePageState extends State<AboutMePage> {
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

  void textPopup() {
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
        content: const Text("Please make an about me under 100 characters."),
        title: const Text('Error'),
      ),
    );
  }

  void emptyString() {
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
        content: const Text("Please enter an about me."),
        title: const Text('Error'),
      ),
    );
  }

  // adds about me text to database
  void addAboutMeToDatabase(String aboutme) async {
    User? user = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;
    await db.collection('users').doc(user!.uid).update({"aboutme": aboutme});
  }

  /*
  * Sized Box
  * Text
  * Text Field
  * Confirm button (takes the user to [birthday.dart] and puts aboutme in
  * [addAboutMeToDatabase]))
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
                    'About Me',
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
                              color: Theme.of(context).colorScheme.onSurface)),
                      hintText: 'About You',
                    ),
                  ),
                ),
                const SpacingBox(),
                Container(
                  margin: Consts.bottomButtonPadding,
                  child: NextButton(onPressed: () {
                    String aboutme = controller.text;
                    if (aboutme.length < 100 && aboutme.isNotEmpty) {
                      addAboutMeToDatabase(aboutme);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PhotosPage()),
                      );
                    } else if (aboutme.isEmpty) {
                      emptyString();
                    } else {
                      textPopup();
                    }
                  }),
                ),
              ]),
        ));
  }
}
