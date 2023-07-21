import 'package:bookshare/navbar.dart';
import 'package:flutter/material.dart';

class MyBooks_Screen extends StatefulWidget {
  const MyBooks_Screen({Key? key}) : super(key: key);

  @override
  State<MyBooks_Screen> createState() => _MyBooks_ScreenState();
}

class _MyBooks_ScreenState extends State<MyBooks_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text("My Books"),
      ),
    );
  }
}
