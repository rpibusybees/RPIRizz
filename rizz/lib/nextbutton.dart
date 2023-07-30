/// This library makes a button that can be used
/// to go from one page to another.
/// It carries on the style of buttons in this app.
library nextbutton.dart;

import 'package:flutter/material.dart';

/// Contains the button. Make sure to define
/// the onPressed function. 
/// Use Consts.bottomButtonPadding
/// if you want the same margin space
class NextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const NextButton({
    Key? key,
    required this.onPressed,
    this.buttonText = 'Confirm',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        elevation: 10,
      ),
      child: Text(buttonText),
    );
  }
}

// Example implementation:
// NextButton(
//   onPressed: (){
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginPage()),
//     );
//   }
// ),