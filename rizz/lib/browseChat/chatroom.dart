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
  TextEditingController? _controller;
  GlobalKey<FormState>? _formKey;
  ScrollController? _scrollController;
  bool? firstLoad;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _controller = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _scrollController = ScrollController();
    firstLoad = true;
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

  void scrollDown() {
    if (_scrollController == null) return;
    _scrollController!.animateTo(
      _scrollController!.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Consts.loadingHeart;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          matchName ?? 'Chat',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimaryContainer),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: Consts.lowPadding,
              child: StreamBuilder<QuerySnapshot>(
                stream: _chatStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    controller: _scrollController,
                    itemCount: chats!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final chat = chats![index];
                      bool isUser = chat.sender == user!.uid ? true : false;
                      // scroll to the bottom of the screen whenever a new message is sent
                      if (index == chats!.length - 1) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((_) => scrollDown());
                      }
                      // on initial load, scroll to the bottom of the screen
                      if (index == 0 && firstLoad == true) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((_) => scrollDown());
                        firstLoad = false;
                      }
                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: IntrinsicWidth(
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.sizeOf(context).width * 0.7),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SendMessage(
                  controller: _controller,
                  formKey: _formKey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.assistant_navigation, //arrow_circle_up_outlined
                    size: 50,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onPressed: () async {
                    if (_formKey!.currentState!.validate()) {
                      final chat = ChatData(
                        matchID: widget.match.matchID,
                        message: _controller!.text,
                        timestamp: Timestamp.now(),
                        sender: user!.uid,
                      );
                      await db.collection('chats').add(chat.toFirestore());

                      await db
                          .collection('matches')
                          .doc(widget.match.matchID)
                          .update({
                        'newestMessage': _controller!.text,
                        'timestamp': Timestamp.now(),
                      });
                      _controller!.clear();
                      // scrollDown();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
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
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: widget.self
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.primary,
          padding: Consts.chatPadding,
          child: ListTile(
            title: Text(widget.msg),
            titleTextStyle: Theme.of(context).textTheme.bodyMedium,
            subtitle: time == true
                ? Text(widget.time,
                    style: Theme.of(context).textTheme.titleSmall)
                : null,
            onTap: () {
              setState(() {
                time = !time!;
              });
            },
          ),
        ),
      ),
    );
  }
}

class SendMessage extends StatelessWidget {
  final TextEditingController? controller;
  final GlobalKey<FormState>? formKey;

  const SendMessage({
    Key? key,
    required this.controller,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
        child: TextFormField(
          maxLength: 160,
          maxLines: null,
          autocorrect: false,
          autofocus: false,
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  // add onSecondary as border color
                  color: Theme.of(context).colorScheme.onSecondary,
                  width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error, width: 2),
            ),
            labelText: 'Message ...',
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            labelStyle: Theme.of(context).textTheme.labelMedium,
          ),
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.done,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a message';
            }
            return null;
          },
        ),
      ),
    );
  }
}
