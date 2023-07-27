/// This is where the user "signs up".
library register;

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rizz/consts.dart';

import 'login_register_helpers.dart';
import 'login.dart';
import 'verification.dart';

/// Used for making a stateful [RegisterButtonState] widget.
class RegisterButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  const RegisterButton(
      {Key? key,
      required this.formKey,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterButtonState();
}

/// Handles, along with [EmailFieldState], the logic for the register button.
class RegisterButtonState extends State<RegisterButton> {
  /// This function is called when the user presses the register button.
  /// It attempts to create a new user with the given [emailController!.text]
  /// and [passwordController!.text].
  void register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: widget.emailController!.text,
          password: widget.passwordController!.text);
      if (!mounted) return;
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VerificationPage()),
      );
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
            register();
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
          'Sign Up',
          style: Theme.of(context).textTheme.titleMedium?.merge(
              TextStyle(color: Theme.of(context).colorScheme.background)),
        ),
      ),
    );
  }
}

/// Used for making a stateful [RegisterFormState] widget.
class RegisterForm extends StatefulWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? confirmPasswordController;
  const RegisterForm(
      {Key? key,
      required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterFormState();
}

/// Container for the three fields needed to register a new user.
class RegisterFormState extends State<RegisterForm> {
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
            FieldFactory(
                controller: widget.passwordController,
                controller2: widget.confirmPasswordController,
                labelPassword: 'Confirm Password'),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RegisterButton(
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

/// If clicked, pushes user to the [LoginPage] page.
class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(51),
          side: BorderSide(
              color: Theme.of(context).colorScheme.tertiary, width: 2),
        ),
        elevation: 10,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      child: Text(
        'Login in here!',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

/// Used for making a stateful [RegisterPageState] widget.
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

/// Creates the register page, including layout and the controllers.
class RegisterPageState extends State<RegisterPage> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;

  /// Initializes the three controllers for user input.
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
    _confirmPasswordController = TextEditingController(text: '');
  }

  /// Disposes of the three controllers for user input.
  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    _confirmPasswordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: Consts.registerPadding,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                    image: AssetImage('assets/RizzLogoFlask.png'),
                    width: 150,
                    height: 150),
              ),
              RegisterForm(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController),
              const LoginButton()
            ],
          ),
        ),
      ),
    );
  }
}
