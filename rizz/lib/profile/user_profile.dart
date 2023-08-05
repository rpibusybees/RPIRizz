import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rizz/consts.dart';
import '../userObjects.dart';
import '../questionnaire/name.dart';
import '../login/login.dart';

const bkgSVG = '''
<svg xmlns="http://www.w3.org/2000/svg" width="393" height="411" viewBox="0 0 393 411" fill="none">
  <g filter="url(#filter0_d_24_216)">
    <path d="M393 0L393 354.528C332.11 371.614 265.763 381 196.332 381C127.029 381 60.7978 371.648 0 354.622L6.15047e-05 0H393Z" fill="#FFF8F5"/>
  </g>
  <defs>
    <filter id="filter0_d_24_216" x="-21.8333" y="-14.4436" width="436.667" height="424.667" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
      <feFlood flood-opacity="0" result="BackgroundImageFix"/>
      <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
      <feOffset dy="7.38974"/>
      <feGaussianBlur stdDeviation="10.9167"/>
      <feComposite in2="hardAlpha" operator="out"/>
      <feColorMatrix type="matrix" values="0 0 0 0 0.50592 0 0 0 0 0.571885 0 0 0 0 0.670833 0 0 0 0.1 0"/>
      <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_24_216"/>
      <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_24_216" result="shape"/>
    </filter>
  </defs>
</svg>
''';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  UserData? userData;
  User? user;
  bool? loading;

  final db = FirebaseFirestore.instance;

  void getUserData() async {
    final docRef = db.collection('users').doc(user!.uid).withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData user, SetOptions? options) =>
              user.toFirestore(),
        );
    final userSnap = await docRef.get();
    userData = userSnap.data();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    loading = true;
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Consts.loadingHeart,
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Your Profile',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        shadowColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Positioned(
            child: SvgPicture.string(
              bkgSVG,
              width: MediaQuery.sizeOf(context).width,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(userData!.imgUrlList![0]),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${userData!.name}, ${userData!.getAge()}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20,
                        bottom: 20,
                        right: 20,
                        top: 20), //apply padding to some sides only
                    child: Text(
                      '${userData!.aboutme}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color.fromRGBO(245, 220, 215,
                                1), // Customize the button color here
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              )
                            ]),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NamePage()));
                          },
                          icon: const Icon(
                            Icons.person_2_rounded,
                            size: 24.0,
                            color: Colors.black,
                          ),
                          label: Text(
                            'Edit Information',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color.fromRGBO(188, 83, 100,
                                1), // Customize the button color here
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              )
                            ]),
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 250,
                                  color: Color.fromRGBO(245, 220, 215, 1),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                            'Are you sure you want to Log out?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromRGBO(188, 83,
                                                    100, 1), // Background color
                                          ),
                                          child: Text(
                                            'Log Out',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ), // Change the button text to 'About Me'
                                          onPressed: () {
                                            FirebaseAuth.instance.signOut();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginPage()));
                                          },
                                        ),
                                        ElevatedButton(
                                          child: Text(
                                            'Cancel',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ), // Change the button text to 'About Me'
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .transparent, // Make the button transparent

                            shadowColor:
                                Colors.transparent, // Hide the button shadow
                          ),
                          child: Text(
                            'Log Out',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
