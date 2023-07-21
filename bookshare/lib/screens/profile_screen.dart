
import 'dart:io';

import 'package:bookshare/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String sgender = 'Male';
  final ageList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13"
  ];
  String selectedAge = "1";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? profilePic;
  String? name = '';
  String? gender = '';
  String? email = '';
  String? phone = '';
  String age = '';
  String? password = '';

  void update(){


  }

  Future _getUserData() async {

    final db = FirebaseFirestore.instance;
    //final id = FirebaseAuth.instance.currentUser!;
    final docRef =
        db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    docRef.get().then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          //profilePic = snapshot.data()!["profilePic"];
          name = snapshot.data()!["name"];
          gender = snapshot.data()!["gender"];
          age = snapshot.data()!["Age"].toString();
          email = snapshot.data()!["email"];
          phone = snapshot.data()!["phone"].toString();
          password = snapshot.data()!["password"];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFe7008a),
        title: const Text("Profile Page"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: name!,
                      prefixIcon: const Icon(Icons.person, color: Color(0xFFe7008a)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      children: [
                        Radio(
                            value: "Male",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                sgender = value.toString();
                              });
                            }),
                        const Icon(Icons.person, color: Color(0xFFe7008a)),
                        const Text("Male"),
                        Radio(
                            value: "Female",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                sgender = value.toString();
                              });
                            }),
                        const Icon(Icons.female, color: Color(0xFFe7008a)),
                        const Text("Female"),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          value: selectedAge,
                          items: ageList
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedAge = value as String;
                            });
                          },
                          icon: const Icon(Icons.arrow_drop_down_circle_outlined,
                              color: Color(0xFFe7008a)),
                          decoration: InputDecoration(
                            labelText: 'Age',
                            prefixIcon:
                                const Icon(Icons.person, color: Color(0xFFe7008a)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: email!,
                      prefixIcon: const Icon(Icons.email, color: Color(0xFFe7008a)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: phone!,
                      prefixIcon: const Icon(Icons.phone, color: Color(0xFFe7008a)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: password!,
                      prefixIcon: const Icon(Icons.email, color: Color(0xFFe7008a)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      onPressed: () {
                        update();
                      },
                      text: "Update",
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
