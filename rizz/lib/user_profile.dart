import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userObjects.dart';
import 'name.dart';
import 'login.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
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
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        
        title: Text(
          'Your Profile',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        shadowColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            // TODO ADD SVG IMAGE HERE
            child: Container(),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(userData!.imgUrlList![0]),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${userData!.name}, ${userData!.getAge()}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
               
                  Padding(
                    padding: EdgeInsets.only(left:20, bottom: 20, right: 20, top:20), //apply padding to some sides only
                    child: Text(
                    '${userData!.aboutme}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  ),
                  
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color.fromRGBO(245, 220, 215,
                                1), // Customize the button color here
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              )
                            ]),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                        NamePage()));
                          },
                          icon: const Icon(
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
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color.fromRGBO(188, 83, 100,
                                1), // Customize the button color here
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              )
                            ]),
                        child: ElevatedButton(
                          child: Text(
                            'Log Out',
                            style: Theme.of(context).textTheme.labelMedium,
                          ), // Change the button text to 'About Me'
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              
                              builder: (BuildContext context){
                                
                                return  Container(
                                  height: 250,
                                    color:   Color.fromRGBO(245, 220, 215, 1),
                                    child: Center(
                                     child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                      Text('Are you sure you want to Log out?',  style: Theme.of(context).textTheme.labelLarge),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:Color.fromRGBO(188, 83, 100, 1), // Background color
                                        ),
                                        child: Text(
                                        'Log Out',
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ), // Change the button text to 'About Me'
                                        onPressed:(){
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                        },
                                      ),
                                       ElevatedButton(
                                        
                                        child: Text(
                                        'Cancel',
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ), // Change the button text to 'About Me'
                                        onPressed:(){
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ],
                                     ),

                                  ),
                                 
                                );
                            },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .transparent, // Make the button transparent

                            shadowColor:
                                Colors.transparent, // Hide the button shadow
                          ),
                          
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
