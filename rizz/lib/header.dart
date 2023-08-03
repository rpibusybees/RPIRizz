import 'package:flutter/material.dart';
import 'package:rizz/profile/user_profile.dart';
import 'browseChat/browsing.dart';
import 'browseChat/messages.dart';

class HeaderPage extends StatefulWidget {
  const HeaderPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HeaderPageState createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  final PageController pageController = PageController(initialPage: 1);
  int currentPageIndex = 1;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        pageController: pageController,
        currentPageIndex: currentPageIndex,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        children: [
          UserProfilePage(),
          // Page 1: Browsing
          const BrowsingPage(),
          const MessagesPage(),
        ],
      ),
    );
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PageController pageController;
  final int currentPageIndex;

  const MainAppBar(
      {Key? key, required this.pageController, required this.currentPageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            const Spacer(flex: 1),
            IconButton(
              icon: const Icon(Icons.person),
              color: currentPageIndex == 0
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.onPrimaryContainer,
              iconSize: MediaQuery.of(context).size.height / 20,
              tooltip: 'Profile',
              onPressed: () {
                pageController.jumpToPage(0); // Go to the Profile page
              },
            ),
            const Spacer(flex: 2),
            IconButton(
              icon: const Icon(Icons.manage_search),
              color: currentPageIndex == 1
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.onPrimaryContainer,
              iconSize: MediaQuery.of(context).size.height / 20,
              tooltip: 'Browse',
              onPressed: () {
                pageController.jumpToPage(1); // Go to the Browsing page
              },
            ),
            const Spacer(flex: 2),
            IconButton(
              icon: const Icon(Icons.mark_chat_unread),
              color: currentPageIndex == 2
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.onPrimaryContainer,
              iconSize: MediaQuery.of(context).size.height / 20,
              tooltip: 'Messages',
              onPressed: () {
                pageController.jumpToPage(2); // Go to the Messages page
              },
            ),
            const Spacer(flex: 1),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
