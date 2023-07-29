/// This page is used to browse through other users.
library browsing;

import 'dart:core';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'consts.dart';
import 'userObjects.dart';

/// Handles the name and extra button at the bottom of the screen
/// for the [PhotoSwipe] widget.
/// These are the name and info button. The info button expands
/// the [InfoCol] widget onclick.
class InfoOverlay extends StatelessWidget {
  final CarouselController? carController;
  final UserData user;
  final Function()? expandInfo;

  const InfoOverlay(
      {Key? key,
      required this.carController,
      required this.user,
      required this.expandInfo
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! > 0) {
            carController?.previousPage();
          }
          if (details.primaryVelocity! < 0) {
            carController?.nextPage();
          }
        },
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(49, 49, 49, 0),
                Color.fromRGBO(49, 49, 49, 1)
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 225, left: 30, right: 30),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${user.name}, ${user.getAge()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    expandInfo!();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const CircleBorder(),
                    ),
                  ),
                  child: const Icon(
                    Icons.info_outline_rounded,
                    size: 60,
                    color: Color.fromRGBO(49, 49, 49, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Used for making a stateful [PhotoSwipe] widget.
/// This widget is used for the main browsing page.
class PhotoSwipe extends StatefulWidget {
  final UserData? user;
  final Function()? expandInfo;
  const PhotoSwipe(
    {Key? key, 
    required this.user, 
    required this.expandInfo
  })  : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhotoSwipeState();
}

/// Builds the photo swipe (UI related). The carousel is used to swipe
/// through the photos.
class _PhotoSwipeState extends State<PhotoSwipe> {
  CarouselController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.user?.imgUrlList!
              .map((item) => Image.network(
                    item,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ))
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.70,
            aspectRatio: 1,
            viewportFraction: 1,
            autoPlay: false,
            enableInfiniteScroll: false,
            initialPage: 0,
          ),
        ),
        InfoOverlay(
          carController: _controller,
          user: widget.user!,
          expandInfo: widget.expandInfo,
        ),
      ],
    );
  }
}

/// Builds the like and dislike buttons (UI related).
/// These are the buttons at the bottom of the screen.
/// They determine if the user likes or dislikes the current user.
/// The [onLike] and [onDislike] functions are passed in from the
/// [BrowsingPage] widget.
class LikeDislikeButtons extends StatelessWidget {
  final int? currUser;
  final Function()? onLike;
  final Function()? onDislike;
  const LikeDislikeButtons(
      {Key? key,
      required this.currUser,
      required this.onLike,
      required this.onDislike})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .1,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.onError,
                width: 2,
              ),
            ),
            child: IconButton(
              onPressed: onDislike,
              icon: Icon(
                Icons.close_rounded,
                size: 60,
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
              ),
            ),
            child: IconButton(
              onPressed: onLike,
              icon: Icon(
                Icons.favorite_rounded,
                size: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Builds the info column (UI related).
/// This is the column that expands when the info button is pressed.
/// It contains the user's pronouns, about me, and lifestyle and interests.
/// The [user] is passed in from the [BrowsingPage] widget.
class InfoCol extends StatelessWidget {
  final user;
  
  const InfoCol(
    {Key? key, 
    required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Consts.lowPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About Me
          Container(
            padding: Consts.lowPadding,
            child: Text(
              'About Me',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Container(
            padding: Consts.sidePadding,
            child: Text(user!.aboutme!),
          ),
          Divider(
            thickness: 1,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          // Lifestyle and Interests
          Container(
            padding: Consts.lowPadding,
            child: Text(
              'Lifestyle and Interests',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Container(
            padding: Consts.sidePadding,
            child: Text(user!.myLikes.join(', ')),
          ),
        ],
      ),
    );
  }
}

/// Used for making a stateful [BrowsingPage] widget.
/// This widget is used for the main browsing page.
class BrowsingPage extends StatefulWidget {
  const BrowsingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BrowsingPageState();
}

/// Builds the browsing page (UI related). The [users] are used to
/// display the users. The [currentUser] is used to keep track of
/// the current user. The [moreInfo] is used to keep track of if
/// the info column is expanded or not. The [_scrollController] is
/// used to scroll the info column up and down.
class _BrowsingPageState extends State<BrowsingPage> {
  final db = FirebaseFirestore.instance;
  List<UserData>? userList;
  User? user;
  UserData? userData;
  int? currentUser;
  double? moreInfo;
  ScrollController? _scrollController;
  bool? loading;

  @override
  void initState() {
    super.initState();
    loading = true;
    user = FirebaseAuth.instance.currentUser;
    userList = [];
    getUserData();
    currentUser = 0;
    moreInfo = 0.0;
    _scrollController = ScrollController();
  }

  void getUserData() async {
    final docRef = db.collection('users').doc(user!.uid).withConverter(
      fromFirestore: UserData.fromFirestore, 
      toFirestore: (UserData user, SetOptions? options) => user.toFirestore(),
    );
    final userSnap = await docRef.get();
    userData = userSnap.data();
    await db.collection('users').withConverter(
      fromFirestore: UserData.fromFirestore, 
      toFirestore: (UserData user, SetOptions? options) => user.toFirestore(),
    ).where('gender', whereIn: [['Man']]).get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          // takes doc and converts it to a UserData object
          UserData tempData = doc.data() as UserData;
          userList!.add(tempData);
        }
      }
    );
    setState(() {
      loading = false;
    });
  }

  onLike() {
    setState(
      () {
        currentUser != null && currentUser! < userList!.length - 1
            ? currentUser = currentUser! + 1
            : currentUser = 0;
        moreInfo = 0.0;
        _scrollController!.animateTo(
          _scrollController!.position.minScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  onDislike() {
    setState(
      () {
        currentUser != null && currentUser! < userList!.length - 1
            ? currentUser = currentUser! + 1
            : currentUser = 0;
        moreInfo = 0.0;
        _scrollController!.animateTo(
          _scrollController!.position.minScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  scrollUp() {
    _scrollController!.animateTo(
      _scrollController!.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  scrollDown() {
    _scrollController!.animateTo(
      _scrollController!.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  expandInfo() {
    setState(() {
      if (moreInfo == 0.0) {
        scrollDown();
      } else {
        scrollUp();
      }
      moreInfo == 0.0 ? moreInfo = 1.0 : moreInfo = 0.0;
    });
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading == false && userList!.isEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'No users found',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }
    if (loading == false) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .025,
              ),
              PhotoSwipe(
                  user: userList![currentUser ?? 0], expandInfo: expandInfo),
              LikeDislikeButtons(
                currUser: currentUser,
                onLike: onLike,
                onDislike: onDislike,
              ),
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                opacity: moreInfo!,
                child: InfoCol(user: userList![currentUser!]),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
