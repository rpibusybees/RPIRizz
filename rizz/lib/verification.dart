import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rizz/test.dart';
import 'login.dart';

class ResendVerifyButton extends StatefulWidget {
  final User? user;
  const ResendVerifyButton({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ResendVerifyButtonState();
}

class ResendVerifyButtonState extends State<ResendVerifyButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await widget.user!.sendEmailVerification();
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
        'Resend Email',
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  User? user;

  @override
  void initState() {
    getAccount();
    super.initState();
  }

  void getAccount() async {
    // is user verified?
    FirebaseAuth.instance.userChanges().listen((User? u) async {
      setState(() {
        user = u;
      });
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else if (user != null && user!.emailVerified) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const TestPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.background,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return Scaffold(
      body: Container(
          color: Theme.of(context).colorScheme.background,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Please check your email for a verification code.',
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'When your email has been verified you may continue with the login process.',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'If you have not received a code after a few minutes click this button to resend the email.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ResendVerifyButton(user: user),
                  // logout button
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ))),
    );
  }
}
