import 'package:flutter/material.dart';

/// Used for making a stateful [FieldFactory] widget.
/// This widget is used for making a text field.
class FieldFactory extends StatefulWidget {
  final TextEditingController? controller;
  final TextEditingController? controller2;
  final String? labelPassword;

  const FieldFactory({
    Key? key,
    required this.controller,
    this.controller2,
    this.labelPassword,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      labelPassword == null ? EmailFieldState() : _PassFieldState();
}

/// Builds the text field (UI related). See [EmailFieldState] and
/// [_PassFieldState] for how the logic is handled.
/// This widget is used for making a text field.
class EmailFieldState extends State<FieldFactory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        autocorrect: false,
        autofocus: false,
        controller: widget.controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                // add onSecondary as border color
                color: Theme.of(context).colorScheme.onSecondary,
                width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error, width: 2),
          ),
          labelText: 'Email',
          suffixIcon: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: widget.controller!.clear,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary,
          labelStyle: Theme.of(context).textTheme.labelMedium,
        ),
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your email';
          } else if (!value.endsWith('@rpi.edu')) {
            return 'Please enter a valid rpi email';
          }
          return null;
        },
      ),
    );
  }
}

/// Builds the text field (UI related). See [EmailFieldState] and
/// [_PassFieldState] for how the logic is handled.
/// This widget is used for making a text field.
class _PassFieldState extends State<FieldFactory> {
  bool _obscureText = true;

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        autocorrect: false,
        autofocus: false,
        controller: widget.controller2 ?? widget.controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                // add onSecondary as border color
                color: Theme.of(context).colorScheme.onSecondary,
                width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error, width: 2),
          ),
          labelText: widget.labelPassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).colorScheme.error,
            ),
            onPressed: togglePasswordVisibility,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary,
          labelStyle: Theme.of(context).textTheme.labelMedium,
        ),
        obscureText: _obscureText,
        textCapitalization: TextCapitalization.none,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your password';
          } else if (value.length < 8) {
            return 'Password must be at least 8 characters';
          } else if (widget.controller2 != null &&
              value != widget.controller!.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }
}
