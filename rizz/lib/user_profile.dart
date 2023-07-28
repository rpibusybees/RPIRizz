import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userObjects.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserData? userData;
  User? user;
  bool? loading;

  final db = FirebaseFirestore.instance;

  void getUserData() async {
    final docRef = db.collection('users').doc(user!.uid).withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData user, SetOptions? options) =>
              user.toFirestore(),
        );
    final userSnap = await docRef.get();
    userData = userSnap.data();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    loading = true;
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Profile',
              style: Theme.of(context).textTheme.displayLarge),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(userData!.imgUrlList![0]),
              ),
              SizedBox(height: 20),
              Text(
                '${userData!.name}, ${userData!.getAge()}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 20),
              Text(
                '${userData!.aboutme}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromRGBO(245, 220, 215,
                            1), // Customize the button color here
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // You can leave this empty since you don't want any function.
                      },
                      icon: Icon(
                        Icons.person_2_rounded,
                        size: 24.0,
                        color: Colors.black,
                      ),
                      label: Text(
                        'Edit Information',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromRGBO(
                            188, 83, 100, 1), // Customize the button color here
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: ElevatedButton(
                      onPressed: () {
                        // You can leave this empty since you don't want any function.
                      },
                      style: ElevatedButton.styleFrom(
                        primary:
                            Colors.transparent, // Make the button transparent

                        shadowColor:
                            Colors.transparent, // Hide the button shadow
                      ),
                      child: Text('Log Out',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium), // Change the button text to 'About Me'
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
