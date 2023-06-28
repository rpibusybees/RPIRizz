import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_register_helpers.dart';

import 'register.dart';
import 'verification.dart';

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

class LoginForm extends StatefulWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  const LoginForm(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailField(controller: widget.emailController),
          const SizedBox(height: 20),
          PassField(
              controller: widget.passwordController, labelPassword: 'Password'),
          SizedBox(height: MediaQuery.of(context).size.height / 7),
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
      padding: LoginConsts.padding,
      color: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
              image: AssetImage('assets/RizzLogoFlask.png'),
              width: 150,
              height: 150),
          LoginForm(
            emailController: _emailController,
            passwordController: _passwordController,
          ),
          const RegisterButton(),
        ],
      ),
    )));
  }
}
