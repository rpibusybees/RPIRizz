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
  num age = FakeData.user3.age;
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
              SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:Color.fromRGBO(188, 83, 100, 1), // Customize the button color here
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // You can leave this empty since you don't want any function.
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Colors.transparent, // Make the button transparent
                      shadowColor: Colors.transparent, // Hide the button shadow
                    ),
                    child: Text('Edit About Me',
                        style: Theme.of(context).textTheme.titleSmall,
              ), // Change the button text to 'About Me'
                  ),
                ),
                SizedBox(width: 20), // Add spacing between buttons
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(227, 183, 160, 1), // Customize the button color here
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      editPictures();
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Colors.transparent, // Make the button transparent
                      shadowColor: Colors.transparent, // Hide the button shadow
                    ),
                    child: Text('Edit Pictures',
                        style: Theme.of(context).textTheme.titleSmall,
              ), // Change the button text
                  ),
                ),
            
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            SizedBox(height: 50),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:  Color.fromRGBO(227, 183, 160, 1), // Customize the button color here
              ),
              child: ElevatedButton(
                onPressed: () {
                  editInterests();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent, // Make the button transparent
                  shadowColor: Colors.transparent, // Hide the button shadow
                ),
                child: Text('Edit Interests',
                    style: Theme.of(context).textTheme.titleSmall,
              ), // Change the button text
              ),
            ),
             SizedBox(width: 20), // Add spacing between buttons
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:Color.fromRGBO(188, 83, 100, 1), // Customize the button color here
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      editPictures();
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Colors.transparent, // Make the button transparent
                      shadowColor: Colors.transparent, // Hide the button shadow
                    ),
                    child: Text('Edit Pronouns',
                        style: Theme.of(context).textTheme.titleSmall,
              ), // Change the button text
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
