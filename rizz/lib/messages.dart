import 'package:flutter/material.dart';

import 'consts.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Consts.vertPadding,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Matches', 
            style: Theme.of(context).textTheme.displayLarge,
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          centerTitle: true,
        ),
        body: Padding(
          padding: Consts.lowPadding,
          child: ListView.builder(
            itemCount: matches.length,
            itemBuilder: (BuildContext context, int index) {
              final match = matches[index];
              return CustomListTile(
                profilePicture: match.profilePicture,
                name: match.name,
                newestMsg: match.newestMsg,
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String profilePicture;
  final String name;
  final String newestMsg;

  const CustomListTile({
    Key? key,
    required this.profilePicture,
    required this.name,
    required this.newestMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Consts.lowVertPadding,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
        ),
      child: ListTile(
        leading: Container(
            width: 60,
            height: 60,       
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  width: 2.0,
                  style: BorderStyle.solid,
                  color: Colors.transparent,
                ),
              gradient: LinearGradient(
                colors: [Theme.of(context).colorScheme.secondary, Theme.of(context).colorScheme.tertiary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          child: CircleAvatar(
            //radius: MediaQuery.of(context).size.height / 20,
            backgroundImage: AssetImage(profilePicture),
            radius: 80,
          ),
        ),
        title: Text(name),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        subtitle: Text(
              newestMsg,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
        ),
        subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Brings you to chat')));
        },
      ),
    );
  }
}

class Match {
  final String profilePicture;
  final String name;
  final String newestMsg;

  const Match({
    required this.profilePicture,
    required this.name,
    required this.newestMsg,
  });
}

final List<Match> matches = [
  Match(
    profilePicture: 'assets/barry_profile.jpg',
    name: 'Barry B Benson',
    newestMsg: 'Ya like Jazz',
  ),
  Match(
    profilePicture: 'assets/barry_profile2.jpg',
    name: 'Jane Smith',
    newestMsg: "Hey there, lovely! Are you a queen bee? Because you've got me buzzing with admiration!",
  ),
  Match(
    profilePicture: 'assets/FakePhotos/IMG-5204.JPG',
    name: 'Ryan Hickey',
    newestMsg: "If you give me a chance, I promise to be as sweet as honey and pollinate your world with love! If you give me a chance, I promise to be as sweet as honey and pollinate your world with love!",
  ),
  Match(
    profilePicture: 'assets/FakePhotos/IMG-4995.PNG',
    name: 'Alex Orr',
    newestMsg: "Sup",
  ),
  // Add more messages here
];