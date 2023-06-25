import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

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
    FirebaseAuth.instance.authStateChanges().listen((User? u) async {
      setState(() {
        user = u;
      });
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else if (user != null && user!.emailVerified) {
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
            content: const Text(
              'Your account has been verified!',
            ),
            title: const Text('Success'),
          ),
        );
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
          child: Column(
            children: [
              Text(
                'A verification email has been sent to ${user!.email} Please verify your email before logging in.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              ElevatedButton(
                onPressed: () async {
                  await user!.sendEmailVerification();
                },
                child: const Text('Resend Verification Email'),
              ),
              // logout button
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: const Text('Logout'),
              ),
            ],
          )),
    );
  }
}
