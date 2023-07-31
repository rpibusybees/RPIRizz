import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String? aboutme;
  final Timestamp? birthday;
  final String? email;
  final List<dynamic>? gender;
  final List<dynamic>? imgUrlList;
  final bool? isSetUp;
  final List<dynamic>? myDislikes;
  final List<dynamic>? myLikes;
  final String? name;
  final List<dynamic>? seeking;
  final List<dynamic>? theirDislikes;
  final List<dynamic>? theirLikes;
  final String? uid;

  UserData({
    this.aboutme,
    this.birthday,
    this.email,
    this.gender,
    this.imgUrlList,
    this.isSetUp,
    this.myDislikes,
    this.myLikes,
    this.name,
    this.seeking,
    this.theirDislikes,
    this.theirLikes,
    this.uid,
  });

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
      aboutme: data?['aboutme'],
      birthday: data?['birthday'],
      email: data?['email'],
      gender: data?['gender'],
      imgUrlList: data?['imgUrlList'],
      isSetUp: data?['isSetUp'],
      myDislikes: data?['myDislikes'],
      myLikes: data?['myLikes'],
      name: data?['name'],
      seeking: data?['seeking'],
      theirDislikes: data?['theirDislikes'],
      theirLikes: data?['theirLikes'],
      uid: data?['uid'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (aboutme != null) 'aboutme': aboutme,
      if (birthday != null) 'birthday': birthday,
      if (email != null) 'email': email,
      if (gender != null) 'gender': gender,
      if (imgUrlList != null) 'imgUrlList': imgUrlList,
      if (isSetUp != null) 'isSetUp': isSetUp,
      if (myDislikes != null) 'myDislikes': myDislikes,
      if (myLikes != null) 'myLikes': myLikes,
      if (name != null) 'name': name,
      if (seeking != null) 'seeking': seeking,
      if (theirDislikes != null) 'theirDislikes': theirDislikes,
      if (theirLikes != null) 'theirLikes': theirLikes,
      if (uid != null) 'uid': uid,
    };
  }

  int getAge() {
    // Convert the birthDate Timestamp to a DateTime object
    DateTime birthDateTime = birthday?.toDate() ?? DateTime.now();

    // Get the current date as a DateTime object
    DateTime currentDate = DateTime.now();

    // Calculate the difference between the current date and the birth date in years
    int ageInYears = currentDate.year - birthDateTime.year;

    // Check if the birth date hasn't occurred yet this year
    if (currentDate.month < birthDateTime.month ||
        (currentDate.month == birthDateTime.month &&
            currentDate.day < birthDateTime.day)) {
      ageInYears--;
    }

    return ageInYears;
  }
}
