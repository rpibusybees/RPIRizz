import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'register.dart';

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
      autofocus: true,
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
        } else if (!value.contains('@rpi.edu')) {
          return 'Please enter a valid rpi email';
        }
        return null;
      },
    );
  }
}

class PassField extends StatefulWidget {
  final TextEditingController? controller;
  const PassField({Key? key, required this.controller}) : super(key: key);

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
      autofocus: true,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              // add onSecondary as border color
              color: Theme.of(context).colorScheme.onSecondary,
              width: 1,
            )),
        labelText: 'Password',
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

class SubmitButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  const SubmitButton(
      {Key? key,
      required this.formKey,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  void _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: widget.emailController!.text,
          password: widget.passwordController!.text);
      if (!mounted) return;
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
          content: Text(
            e.toString(),
          ),
          title: const Text('Error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (widget.formKey.currentState!.validate()) {
            _login();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: const Text('Login'),
      ),
    );
  }
}

class EPForm extends StatefulWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  const EPForm(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormState();
}

class _FormState extends State<EPForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailField(controller: widget.emailController),
          const SizedBox(height: 20),
          PassField(controller: widget.passwordController),
          SizedBox(height: MediaQuery.of(context).size.height / 4),
          SubmitButton(
              formKey: _formKey,
              emailController: widget.emailController,
              passwordController: widget.passwordController),
        ],
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // MaterialPageRoute(builder: (context) => const RegisterPage());
      },
      child: Text(
        'Create an account now!',
        style: Theme.of(context).textTheme.labelMedium,
        
      ),
    );
  }
}

class LoginConsts {
  LoginConsts._();

  static const EdgeInsets padding =
      EdgeInsets.symmetric(horizontal: 30, vertical: 100);
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  User? user;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
    checkUser();
  }

  void checkUser() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: LoginConsts.padding,
      color: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/RizzLogoFlask.png'), ),
          EPForm(
            emailController: _emailController,
            passwordController: _passwordController,
          ),
          const RegisterButton(),
        ],
      ),
    )));
  }
}
