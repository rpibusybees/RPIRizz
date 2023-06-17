import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class ToggleImage extends StatefulWidget {
  const ToggleImage({super.key});

  @override
  State<ToggleImage> createState() => _ToggleImageState();
}

class _ToggleImageState extends State<ToggleImage> {
  bool _clicked = true;
  String image =
      'https://staticc.sportskeeda.com/editor/2023/05/c2746-16832605537822-1920.jpg?w=840';

  void _toggleImage() {
    setState(() {
      if (_clicked) {
        image =
            'https://staticc.sportskeeda.com/editor/2023/05/512ae-16832605921264-1920.jpg';
        _clicked = false;
      } else {
        image =
            'https://staticc.sportskeeda.com/editor/2023/05/c2746-16832605537822-1920.jpg?w=840';
        _clicked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      child: InkWell(
        onTap: _toggleImage,
        child: Image.network(
          image,
          width: 600,
          height: 240,
        ),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: SizedBox(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Arima Kana',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(
                  "Alex's future wife",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 0, 0),
                  ),
                )
              ],
            ),
          ),
          const FavoriteWidget()
        ],
      ),
    );
    Color color = Theme.of(context).primaryColorDark;

    Column _buildButtonColumn(Color color, IconData icon, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          )
        ],
      );
    }

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'Call'),
        _buildButtonColumn(color, Icons.near_me, 'Route'),
        _buildButtonColumn(color, Icons.share, 'Share'),
      ],
    );

    Widget textSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Text(
          "Nobody is looking my way. Mom and the manager abandoned me. Even my fans are fixated on my past glory. Please, somebody, look at me. I have been keeping this inside me for years. Tell me you need me, if you do, I'd work my fingers to the bone. Say that I am useful, and I'll work myself to death for you. Somebody just praising my efforts would keep me going forever. Someone. Anyone. Say it's okay for me to be here."),
    );

    return MaterialApp(
      title: 'Ryan Layout Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ryan Layout Demo'),
          backgroundColor: Colors.red[500],
        ),
        body: ListView(
          children: [
            const ToggleImage(),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
