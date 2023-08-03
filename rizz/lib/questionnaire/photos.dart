/// Handles where the user puts in their photos
library photos.dart;

import 'package:flutter/material.dart';
import 'package:rizz/header.dart';
import '../spacingbox.dart';
import '../consts.dart';
import '../nextbutton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';

/// Needed for the [PhotoPageState] class.
class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PhotosPageState();
}

/// Makes the PhotosPage. Contains six
/// [UploadPhotoButton]
class PhotosPageState extends State<PhotosPage> {
  List<String> imageUrlList = List.filled(6, '');

  /// uploads imgUrlList to Firebase
  /// uploads actual image files to Firestore
  uploadImagesToDatabase() async {
    User? user = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;
    Reference cloudStorage = FirebaseStorage.instance.ref().child('images');
    List<String> nonEmptyUrlList = [];

    // get the non-empty elements
    for (int i = 0; i < 6; i++) {
      if (imageUrlList[i].isNotEmpty) {
        // add to Firestore
        String fileName = DateTime.now().microsecondsSinceEpoch.toString();
        await cloudStorage.child(fileName).putFile(File(imageUrlList[i]));
        // add to non-empty element list
        nonEmptyUrlList
            .add(await cloudStorage.child(fileName).getDownloadURL());
      }
    }

    // make a list with non-empty elements

    await db
        .collection('users')
        .doc(user!.uid)
        .update({'imgUrlList': nonEmptyUrlList, "isSetUp": true});
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
                    'Put up to six photos here',
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    UploadPhotoButton(photoNum: 1, urlList: imageUrlList),
                    UploadPhotoButton(photoNum: 2, urlList: imageUrlList),
                    UploadPhotoButton(photoNum: 3, urlList: imageUrlList)
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    UploadPhotoButton(photoNum: 4, urlList: imageUrlList),
                    UploadPhotoButton(photoNum: 5, urlList: imageUrlList),
                    UploadPhotoButton(photoNum: 6, urlList: imageUrlList)
                  ])
                ]),
                const SpacingBox(),
                Container(
                  margin: Consts.bottomButtonPadding,
                  child: NextButton(onPressed: () {
                    uploadImagesToDatabase();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HeaderPage()),
                    );
                  }),
                ),
              ]),
        ));
  }
}

/// Used for [UploadPhotoButtonState]
// ignore: must_be_immutable
class UploadPhotoButton extends StatefulWidget {
  final int photoNum;
  List<String> urlList;
  UploadPhotoButton({Key? key, required this.photoNum, required this.urlList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => UploadPhotoButtonState();
}

/// The button that prompts an image.
class UploadPhotoButtonState extends State<UploadPhotoButton> {
  XFile? image;

  XFile? getImage() {
    return image;
  }

  /// sets the image that this button displays
  void setImage() async {
    ImagePicker imagepicker = ImagePicker();
    XFile? pickedImage =
        await imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
      widget.urlList[widget.photoNum - 1] = pickedImage.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        iconSize: (MediaQuery.sizeOf(context).width / 7),
        icon: image != null
            ? Image.file(File(image!.path))
            : const Icon(Icons.add_photo_alternate_outlined),
        onPressed: () async {
          setImage();
        },
        tooltip: "upload photo",
      ),
    );
  }
}
