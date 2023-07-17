import 'package:flutter/material.dart';

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
  String userName = "John Doe";
  String userEmail = "john.doe@example.com";
  String userProfilePictureUrl =
      "https://randomuser.me/api/portraits/men/1.jpg";
  String aboutMe = "Hi, I'm John! I love coding with Flutter!";

  void updateAboutMe(String value) {
    setState(() {
      aboutMe = value;
    });
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              userEmail,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                initialValue: aboutMe,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'About Me',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  updateAboutMe(value);
                },
              ),
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
    );
  }
}
