import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../userObjects.dart';
import '../consts.dart';
import 'chatroom.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  User? user;
  UserData? userData;
  final db = FirebaseFirestore.instance;
  Stream<QuerySnapshot>? _mathcesStream;
  bool _loading = false;
  List<MatchData>? matches;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    getUserData();
  }

  void getUserData() async {
    final docRef = db.collection('users').doc(user!.uid).withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData user, SetOptions? options) =>
              user.toFirestore(),
        );
    final userSnap = await docRef.get();
    userData = userSnap.data();
    setState(() {
      _mathcesStream = db
          .collection('matches')
          .where(FieldPath.documentId, whereIn: userData!.matches)
          .withConverter<MatchData>(
            fromFirestore: (snapshot, options) =>
                MatchData.fromFirestore(snapshot, options),
            toFirestore: (match, options) => match.toFirestore(),
          )
          .snapshots();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
      padding: Consts.vertPadding,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Matches',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          shadowColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: Consts.lowPadding,
          child: StreamBuilder<QuerySnapshot>(
            stream: _mathcesStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.data == null) {
                return const Center(child: Text('No data available'));
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No matches yet'));
              }

              matches = snapshot.data!.docs
                  .map((doc) => doc.data())
                  .cast<MatchData>()
                  .toList();
              // order matches by timestamp
              matches!.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));

              return ListView.builder(
                itemCount: matches!.length,
                itemBuilder: (BuildContext context, int index) {
                  final match = matches![index];
                  final matchedUserUid = match.users!.keys.firstWhere(
                    (uid) => uid != user!.uid,
                    orElse: () => '',
                  );
                  final matchedUserInfo = match.users![matchedUserUid];
                  if (matchedUserInfo == null) return const SizedBox.shrink();
                  return MatchListTile(
                    profilePicture: matchedUserInfo.photo,
                    name: matchedUserInfo.name,
                    newestMsg: match.newestMessage!,
                    nav: () => { Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage(match: match,)),
              )}
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class MatchListTile extends StatelessWidget {
  final String profilePicture;
  final String name;
  final String newestMsg;
  final Function() nav;

  const MatchListTile({
    Key? key,
    required this.profilePicture,
    required this.name,
    required this.newestMsg,
    required this.nav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Consts.lowVertPadding,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
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
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.tertiary
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: CircleAvatar(
            //radius: MediaQuery.of(context).size.height / 20,
            backgroundImage: NetworkImage(profilePicture),
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
        onTap: nav,
      ),
    );
  }
}
