/// Used to provide spacing to Widgets in certain spaces
library spacingbox.dart;
import 'package:flutter/material.dart';

/// Used for spacing out certain components 
/// in [Birthday] and [Name] pages
class SpacingBox extends StatelessWidget {

  final int HEIGHT_SPACING = 20;

  const SpacingBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // note the irony of Expanded()
    // and height
    return Expanded(
      child: SizedBox(
        height: (MediaQuery.of(context).size.height)/HEIGHT_SPACING,
      )
    );
  }
}

// Example usage:
// const SpacingBox();
            