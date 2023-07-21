
import 'package:bookshare/navbar.dart';
import 'package:flutter/material.dart';

class Donate_Screen extends StatefulWidget {
  const Donate_Screen({Key? key}) : super(key: key);

  @override
  State<Donate_Screen> createState() => _Donate_ScreenState();
}

class _Donate_ScreenState extends State<Donate_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text("Donate Book"),
      ),
    );
  }
}
