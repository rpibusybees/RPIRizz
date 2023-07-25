import 'package:flutter/material.dart';
import 'user.dart';

void main() {
  runApp(UserProfileApp());
}

class UserProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      home: UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String userName = FakeData.user3.name;
  String userProfilePictureUrl = FakeData.user3.profilephoto;
  String aboutMe = FakeData.user3.aboutMe;
  num age = FakeData.user3.age;
  String pronoun = FakeData.user3.pronouns;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Profile',
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
                radius: 70,
                backgroundImage: NetworkImage(userProfilePictureUrl),
              ),
              SizedBox(height: 20),
              Text(
                userName + ", " + age.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 5),
              Text(
                pronoun,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 20),
              Text(
                aboutMe,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
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
                        Icons.person_pin_circle,
                        size: 24.0,
                      ),
                      label: Text('Edit Information'),
                    ),
                    //       style: ElevatedButton.styleFrom(
                    //         primary:
                    //             Colors.transparent, // Make the button transparent
                    //         shadowColor: Colors.transparent, // Hide the button shadow
                    //       ),
                    //       child: Text('Edit Information',
                    //           style: Theme.of(context).textTheme.titleSmall,
                    // ), // Change the button text to 'About Me'
                  ),
                ],
              ),
              SizedBox(height: 80),
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
