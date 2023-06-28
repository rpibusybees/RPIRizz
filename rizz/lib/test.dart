import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
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
          child: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height * .5,
                left: MediaQuery.sizeOf(context).width * .25),
            child: Column(
              children: [
                Text('Welcome ${user!.email}!'),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          )),
    );
  }
}
