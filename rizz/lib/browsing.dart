import 'package:flutter/material.dart';

class FakeData {}

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
        if (details.primaryVelocity < 0) {
          // User swiped left
          print('User swiped left');
        }
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
          ],
        ),
      ),
    );
  }
}
