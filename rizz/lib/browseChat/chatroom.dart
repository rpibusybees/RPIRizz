import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../userObjects.dart';
import '../consts.dart';

class ChatPage extends StatefulWidget {
  final MatchData match;
  const ChatPage({Key? key, required this.match}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  User? user;
  String? matchName;
  UserData? userData;
  final db = FirebaseFirestore.instance;
  Stream<QuerySnapshot>? _chatStream;
  bool _loading = false;
  List<ChatData>? chats;

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
      _chatStream = db
          .collection('chats')
          .where('matchID', isEqualTo: widget.match.matchID)
          .withConverter<ChatData>(
            fromFirestore: (snapshot, options) =>
                ChatData.fromFirestore(snapshot, options),
            toFirestore: (chat, options) => chat.toFirestore(),
          )
          .snapshots();
      String matchID = widget.match.users!.keys.firstWhere(
        (element) => element != user!.uid,
        orElse: () => '',
      );
      matchName = widget.match.users![matchID]!.name;
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
            matchName ?? 'Chat',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
          // backgroundColor: Theme.of(context).colorScheme.primary,
          // shadowColor: Theme.of(context).colorScheme.background,
          // elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: Consts.lowPadding,
          child: StreamBuilder<QuerySnapshot>(
            stream: _chatStream,
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
                return const Center(child: Text('Start Chatting'));
              }

              chats = snapshot.data!.docs
                  .map((doc) => doc.data())
                  .cast<ChatData>()
                  .toList();
              // order matches by timestamp
              chats!.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));

              return ListView.builder(
                itemCount: chats!.length,
                itemBuilder: (BuildContext context, int index) {
                  final chat = chats![index];
                  bool isUser = chat.sender == user!.uid ? true : false;
                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: IntrinsicWidth(
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * 0.7),
                        child: ChatListTile(
                          msg: chat.message!,
                          time: chat.formatChatTimestamp(),
                          self: isUser,
                        ),
                      ),
                    ),
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

class ChatListTile extends StatefulWidget {
  final String msg;
  final String time;
  final bool self;

  const ChatListTile({
    Key? key,
    required this.msg,
    required this.time,
    required this.self,
  }) : super(key: key);

  @override
  State<ChatListTile> createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  bool? time;
  @override
  void initState() {
    super.initState();
    time = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.self ? Colors.blue : Colors.green,
      padding: Consts.lowPadding,
      child: ListTile(
        title: Text(widget.msg),
        titleTextStyle: Theme.of(context).textTheme.bodySmall,
        subtitle: time == true
            ? Text(widget.time, style: Theme.of(context).textTheme.titleSmall)
            : null,
        onTap: () {
          setState(() {
            time = !time!;
          });
        },
      ),
    );
  }
}
