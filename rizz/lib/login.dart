/// The first page the user sees (and used for logging in).
library login;

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'consts.dart';
import 'login_register_helpers.dart';

import 'register.dart';
import 'verification.dart';

/// Used for making a stateful [SubmitButtonState] widget.
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
  State<StatefulWidget> createState() => SubmitButtonState();
}

/// Handles a login attempt. Actual logic for logging in
/// is handled in [EmailFieldState.build]
class SubmitButtonState extends State<SubmitButton> {
  /// Attempts to log in the user. If there's an error, displays
  /// [e.toString()] and ERROR to the user.
  void _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: widget.emailController!.text,
          password: widget.passwordController!.text);
      if (!mounted) return;
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
          elevation: 10,
        ),
        child: Text(
          'Login',
          style: Theme.of(context).textTheme.titleMedium?.merge(
              TextStyle(color: Theme.of(context).colorScheme.background)),
        ),
      ),
    );
  }
}

/// Used for making a stateful [LoginFormState] widget.
class LoginForm extends StatefulWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  const LoginForm(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginFormState();
}

/// Builds the login form (UI related). See [SubmitButtonState] and
/// [EmailFieldState] for how the logic is handled.
class LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
          children: [
            FieldFactory(
              controller: widget.emailController,
            ),
            FieldFactory(
                controller: widget.passwordController,
                controller2: null,
                labelPassword: 'Password'),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SubmitButton(
                  formKey: _formKey,
                  emailController: widget.emailController,
                  passwordController: widget.passwordController),
            ),
          ],
        ),
      ),
    );
  }
}

// If clicked, sends user to the [RegisterPage].
class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterPage()),
        );
      },
      child: Text(
        'Create an account now!',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
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
    initUser();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
    super.initState();
  }

  void initUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? u) {
      setState(() {
        user = u;
      });
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VerificationPage()),
        );
      }
    });
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
          padding: Consts.loginPadding,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                    image: AssetImage('assets/RizzLogoFlask.png'),
                    width: 150,
                    height: 150),
              ),
              LoginForm(
                emailController: _emailController,
                passwordController: _passwordController,
              ),
              const RegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
