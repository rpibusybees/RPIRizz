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
  String userProfilePictureUrl =
      FakeData.user3.profilephoto;
  String aboutMe = FakeData.user3.aboutMe;
  String pronoun = FakeData.user3.pronouns;


  void editPictures() {
    // Implement the logic for the "Edit Pictures" button here.
    // For simplicity, we'll just print a message for demonstration purposes.
    print('Edit Pictures button pressed.');
  }

  void editInterests() {
    // Implement the logic for the "Edit Interests" button here.
    // For simplicity, we'll just print a message for demonstration purposes.
    print('Edit Interests button pressed.');
  }

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
                userName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 5),
              Text(
                pronoun,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  editPictures();
                },
                child: Text('Edit Pictures'),
              ),
              ElevatedButton(
                onPressed: () {
                  editInterests();
                },
                child: Text('Edit Interests'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
