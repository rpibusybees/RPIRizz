import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_register_helpers.dart';
import 'login.dart';
import 'verification.dart';

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
  State<StatefulWidget> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  void _register() async {
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
            _register();
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
  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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

class RegisterConsts {
  RegisterConsts._();

  static const EdgeInsets padding =
      EdgeInsets.symmetric(horizontal: 30, vertical: 50);
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
    _confirmPasswordController = TextEditingController(text: '');
  }

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
                padding: RegisterConsts.padding,
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
                ))));
  }
}
