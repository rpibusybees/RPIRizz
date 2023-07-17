/// This is the page where the user enters their name.
/// This value is stored into the database under the user's id.
library name;

import 'package:flutter/material.dart';
import 'test.dart';

/// Needed for the [NamePageState] class.
class NamePage extends StatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NamePageState();
}

/// Contains the text and text-field where the user
/// is prompted and enters their name.
class NamePageState extends State<NamePage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // adds name to database
  void addNameToDatabase(String name) {
    print(name);
  }

  @override
  Widget build(BuildContext context) {

            // Text(
            //   'What is your name?',
            //   style: Theme.of(context).textTheme.displayLarge,
            //   textAlign: TextAlign.center,
            // ),

            // TextField(
            //   controller: controller,
            //   decoration: const InputDecoration(
            //     hintText: 'Name',
            //   ),
            // ),

          // ElevatedButton(
          //   onPressed: () {
          //     // add the user's name to the database
          //     // move to the next page
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //       builder: (context) => const TestPage()),
          //     );
          //     String name = controller.text;
          //     addNameToDatabase(name);
          //   },
          // child: const Text('Confirm'),
          // ),

          // please work

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background
      )
    );
  }
}
