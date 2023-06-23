import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class EmailField extends StatefulWidget {
  final TextEditingController? controller;
  const EmailField({Key? key, required this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      autofocus: true,
      controller: widget.controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          labelText: 'Email',
          suffixIcon: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: widget.controller!.clear,
          )),
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.next,
    );
  }
}

class LoginConsts {
  LoginConsts._();

  static const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 20);
  static const double avatarRadius = 45;
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? _EmailController;

  @override
  void initState() {
    super.initState();
    _EmailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: FractionallySizedBox(
          widthFactor: 9 / 10,
          heightFactor: 2 / 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Picture'),
              const SizedBox(height: 20),
              EmailField(
                controller: _EmailController,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ));
  }
}
