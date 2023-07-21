
import 'package:bookshare/screens/Authentication/login_screen.dart';
import 'package:bookshare/screens/add_book.dart';
import 'package:bookshare/screens/allbook_screen.dart';
import 'package:bookshare/screens/donate_screen.dart';
import 'package:bookshare/screens/home_screen.dart';
import 'package:bookshare/screens/profile_screen.dart';
import 'package:bookshare/screens/users_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);
  void logout() async {
   await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        //padding: EdgeInsets.zero,
        children: [
          SizedBox(
            child: Image.asset(
              "assests/book.png",
              fit: BoxFit.contain,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.my_library_books),
            title: const Text('My Books'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Add/Sell Books'),
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AddBook()), (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_outlined),
            title: const Text('Donate Books'),
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const Donate_Screen() ), (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu_book_sharp),
            title: const Text('All Books'),
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const AllBook_Screen()), (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Users'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Users()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Profile()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('About'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              logout();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
