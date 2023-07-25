/// Handles where the user puts in their photos
library photos.dart;
import 'package:flutter/material.dart';
import 'spacingbox.dart';
import 'consts.dart';
import 'nextbutton.dart';
import 'login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

/// Needed for the [PhotoPageState] class.
class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PhotosPageState();
}

class PhotosPageState extends State<PhotosPage> {
  String imageUrl = "";

  // you guessed it
  uploadImageToDatabase() async{
    ImagePicker imagepicker = ImagePicker();

    XFile? file = await imagepicker.pickImage(source: ImageSource.gallery);

    User? user = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;
    Reference cloudStorage = FirebaseStorage.instance.ref().child('images');

    String fileName = DateTime.now().microsecondsSinceEpoch.toString();

    await cloudStorage.child('name').putFile(File(file!.path));
    imageUrl = await cloudStorage.child(fileName).getDownloadURL();
    
    await db.collection('users').doc(user!.uid).update({'imageUrl':imageUrl});
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {    

    // setstate bs
    Image img = Image.asset('images/marioluigi.jpg');

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
                'Put up to six photos here',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
            
            Container(
              child: IconButton(
                icon: img,
                onPressed: (){
                  uploadImageToDatabase();
                  setState(() {
                    img = Image.network(imageUrl);
                  });
                },
                tooltip: "upload photo",
              ),
            ),
            const SpacingBox(),
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
          ]
        ),
      )
    );  
  }
}
