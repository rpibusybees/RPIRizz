import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rizz/browseChat/browsing.dart';
import '../userObjects.dart';

// Creates the profile of your match you are in a Chatroom with
// Shows name, age, photo carousel, about me, and lifestyle/interest bubbles
class MatchProfile extends StatelessWidget {
  final UserData match;

  const MatchProfile(
    {Key? key, 
    required this.match})
      : super(key: key);

  @override
 Widget build(BuildContext context) {
    return  Scaffold(
        // Back arrow and Name+Age
         appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ), 
            onPressed: () {
              Navigator.pop(context); 
            },
          ),
          title: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                   '${match.name}, ${match.getAge()}',
                    style: Theme.of(context).textTheme.displayLarge,
                ),
              );
            },
          ),
          centerTitle: true,
         ),
        // Scrollable ChatPhotoSwipe and InfoCol
        body: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).colorScheme.background, 
            child: Column(
              children: [
                ChatPhotoSwipe(user: match),
                InfoCol(user: match),
              ],
            ),
          ),
        ),
      );
  }
}

// Creates a carousel of images to swipe through 
class ChatPhotoSwipe extends StatefulWidget {
  final UserData? user;
  const ChatPhotoSwipe({Key? key, required this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ChatPhotoSwipeState();
}

class _ChatPhotoSwipeState extends State<ChatPhotoSwipe> {
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
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity! > 0) {
                _controller?.previousPage();
              }
              if (details.primaryVelocity! < 0) {
                _controller?.nextPage();
              }
            },
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.only(top: 225),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
