/// Handles where the user puts in their photos
library photos.dart;
import 'package:flutter/material.dart';
import 'spacingbox.dart';
import 'consts.dart';
import 'nextbutton.dart';
import 'login.dart';

/// Needed for the [PhotoPageState] class.
class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PhotosPageState();
}

class PhotosPageState extends State<PhotosPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SpacingBox(),
            Container(
              padding: Consts.questionPadding,
              child: Text(
                'Put up to six photos here',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
            
            
            const SpacingBox(),
            Container(
              margin: Consts.bottomButtonPadding,
              child: NextButton(
                onPressed: (){                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              ),
            ),
          ]
        ),
      )
    );  
  }
}
