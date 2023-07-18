import 'dart:core';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'consts.dart';

class UserData {
  final String name;
  final num age;
  final String gender;
  final String pronouns;
  final String aboutMe;
  final List<String> photos;
  final List<String> lifesytleInterests;

  UserData(
    this.name,
    this.age,
    this.gender,
    this.pronouns,
    this.aboutMe,
    this.photos,
    this.lifesytleInterests,
  );
}

class FakeData {
  FakeData._();
  static UserData user1 =
      UserData('Ryan', 20, 'Male', 'he/him', 'I am better than alex', [
    'assets/FakePhotos/70960294417--14E3E923-AC0B-439D-8F7F-B2CC414FED27.JPG',
    'assets/FakePhotos/IMG-5031.JPG',
    'assets/FakePhotos/IMG-5204.JPG',
    'assets/FakePhotos/IMG-7894.jpg',
    'assets/FakePhotos/IMG-7916.jpg'
  ], []);
  static UserData user2 =
      UserData('Alex', 19, 'Male?', 'he/him', 'Hello world', [
    'assets/FakePhotos/IMG-4995.PNG',
    'assets/FakePhotos/IMG-5103.JPG',
    'assets/FakePhotos/IMG-5432.JPG',
  ], []);

  static List<UserData> users = [user1, user2];
}

class NameExtraButton extends StatelessWidget {
  final CarouselController? carController;
  final UserData? user;
  final Function()? expandInfo;

  const NameExtraButton(
      {Key? key,
      required this.carController,
      required this.user,
      required this.expandInfo})
      : super(key: key);

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
                    '${user?.name}, ${user?.age}',
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
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PhotoSwipe extends StatefulWidget {
  final UserData? user;
  final Function()? expandInfo;
  const PhotoSwipe({Key? key, required this.user, required this.expandInfo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhotoSwipeState();
}

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
          items: widget.user?.photos
              .map((item) => Image(
                    image: AssetImage(item),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ))
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.75,
            aspectRatio: 1,
            viewportFraction: 1,
            autoPlay: false,
            enableInfiniteScroll: false,
            initialPage: 0,
          ),
        ),
        NameExtraButton(
          carController: _controller,
          user: widget.user,
          expandInfo: widget.expandInfo,
        ),
      ],
    );
  }
}

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

class InfoCol extends StatelessWidget {
  final UserData? user;
  const InfoCol({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Consts.browsePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: Consts.lowPadding,
                child: Icon(Icons.face),
              ),
              Text(user!.pronouns),
            ],
          ),
          Divider(
            thickness: 1,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
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
            child: Text(user!.aboutMe),
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
            child: Text(user!.lifesytleInterests.join(', ')),
          ),
        ],
      ),
    );
  }
}

class BrowsingPage extends StatefulWidget {
  const BrowsingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BrowsingPageState();
}

class _BrowsingPageState extends State<BrowsingPage> {
  List<UserData>? users;
  int? currentUser;
  double? moreInfo;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    users = FakeData.users;
    currentUser = 0;
    moreInfo = 0.0;
    _scrollController = ScrollController();
  }

  onLike() {
    setState(
      () {
        currentUser != null && currentUser! < users!.length - 1
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
        currentUser != null && currentUser! < users!.length - 1
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
    if (users != null) {
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
                  user: users![currentUser ?? 0], expandInfo: expandInfo),
              LikeDislikeButtons(
                currUser: currentUser,
                onLike: onLike,
                onDislike: onDislike,
              ),
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                opacity: moreInfo!,
                child: InfoCol(user: users![currentUser!]),
              ),
            ],
          ),
        ),
      );
    }
    return const Scaffold();
  }
}
