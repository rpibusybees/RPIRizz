import 'package:flutter/material.dart';
import 'consts.dart';

class FakeData {
  /*  Photos
      Name,
      Age,
      Grade Level??!
      Pronouns
      About Me - fill in box
      Lifestyle + interests 
  */
}

class PhotoSwipe extends StatefulWidget {
  const PhotoSwipe({super.key});

  @override
  State<StatefulWidget> createState() => _PhotoSwipeState();
}

class _PhotoSwipeState extends State<PhotoSwipe> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        //if (details.primaryVelocity < 0) {
          // User swiped left
          //print('User swiped left');
       // }
      },
      child: const Center(
        child: Text('PhotoSwipe'),
      ),
    );
  }
}

class BrowsingPage extends StatefulWidget {
  const BrowsingPage({super.key});

  @override
  State<StatefulWidget> createState() => _BrowsingPageState();
}

class _BrowsingPageState extends State<BrowsingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browsing'),
      ),
      body: const Center(
        child: Column(
          children: [
            Text('Browsing'),
            InfoCol()
          ],
        ),
      ),
    );
  }
}

class InfoCol extends StatelessWidget {
  const InfoCol({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Center(
            child: Expanded(
                child: Container(
                  padding: Consts.browsePadding,
                    child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [  
                      const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: Consts.lowPadding,
                                child: Icon(Icons.face),
                              ),
                              Text('Pronouns'),
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
                          child: const Text('about me text here'),
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
                          child: const Text('interests go here'),
                        ),
                       ],
                    ),
                ),
            ),
      );
  }
}