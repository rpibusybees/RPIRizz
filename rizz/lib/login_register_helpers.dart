import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  final TextEditingController? controller;
  const EmailField({Key? key, required this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      autofocus: false,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              // add onSecondary as border color
              color: Theme.of(context).colorScheme.onSecondary,
              width: 1,
            )),
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
    );
  }
}

class PassField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelPassword;
  const PassField(
      {Key? key, required this.controller, required this.labelPassword})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PassFieldState();
}

class _PassFieldState extends State<PassField> {
  bool _obscureText = true;

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      autofocus: false,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              // add onSecondary as border color
              color: Theme.of(context).colorScheme.onSecondary,
              width: 1,
            )),
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
        }
        return null;
      },
    );
  }
}

class ConfirmPassField extends StatefulWidget {
  final TextEditingController? passcontroller;
  final TextEditingController? repassController;
  final String? labelPassword;
  const ConfirmPassField(
      {Key? key,
      required this.passcontroller,
      required this.labelPassword,
      this.repassController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfirmPassFieldState();
}

class _ConfirmPassFieldState extends State<ConfirmPassField> {
  bool _obscureText = true;

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      autofocus: false,
      controller: widget.repassController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              // add onSecondary as border color
              color: Theme.of(context).colorScheme.onSecondary,
              width: 1,
            )),
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
          return 'Please retype your password';
        } else if (value.length < 8) {
          return 'Password must be at least 8 characters';
        } else if (value != widget.passcontroller!.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }
}
