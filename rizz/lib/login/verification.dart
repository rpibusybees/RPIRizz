import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../consts.dart';
import '../header.dart';
import '../questionnaire/name.dart';
import 'login.dart';

/// Handles a resend verification email attempt. Actual logic for resending
/// verification email is handled in [ResendVerifyButton.build]
class ResendVerifyButton extends StatelessWidget {
  final User? user;

  const ResendVerifyButton({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await user!.sendEmailVerification();
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

/// The verification page. This page is shown when the user is not verified.
/// The user is redirected to this page when they login.
class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerificationPageState();
}

/// Handles the verification page. Checks if the user is verified, and if not,
/// shows a loading indicator. If the user is verified, check if the user data
/// exists. If not, set initial data. Then navigate to the test page.
class _VerificationPageState extends State<VerificationPage> {
  User? user;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    getAccount();
    super.initState();
  }

  void getAccount() async {
    // Check if the user is verified.
    FirebaseAuth.instance.userChanges().listen(
      (User? u) async {
        setState(() {
          user = u;
        });
        if (user == null) {
          // If the user is not logged in, navigate to the login page.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else if (user != null && user!.emailVerified) {
          // If the user is logged in and email is verified, check user data and navigate to the test page.
          final userRef = db.collection('users').doc(user!.uid);
          userRef.get().then((DocumentSnapshot doc) {
            final userData = doc.data();
            if (userData == null) {
              // If user data does not exist, set initial data.
              final initialData = {
                'email': user!.email!,
                'isSetUp': false,
                'uid': user!.uid,
                'seen': [],
                'matches': [''],
              };
              userRef.set(initialData);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NamePage()));
            } else {
              // If user data exists, navigate to the test page.
              doc.get('isSetUp') == true
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HeaderPage()))
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NamePage()));
            }
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      // While checking the user's verification status, show a loading indicator.
      return Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.background,
          child: Consts.loadingHeart,
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
                'When your email has been verified, logout then login again to proceed.',
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                'If you have not received a code after a few minutes, click this button to resend the email.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ResendVerifyButton(user: user),
              // Logout button
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
