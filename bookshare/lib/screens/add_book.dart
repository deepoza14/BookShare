import 'dart:io';

import 'package:bookshare/navbar.dart';
import 'package:bookshare/screens/home_screen.dart';
import 'package:bookshare/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final _formKey = GlobalKey<FormState>();
  File? bookPic;
  TextEditingController booknameController = TextEditingController();
  TextEditingController bookdesController = TextEditingController();
  TextEditingController bookauthornameController = TextEditingController();
  TextEditingController bookpriceController = TextEditingController();
  TextEditingController booklocationController = TextEditingController();

  Future<void> addBook() async {
    String Bookname = booknameController.text.trim();
    String Authorname = bookauthornameController.text.trim();
    String Bookdesc = bookdesController.text.trim();
    String Bookprice = bookpriceController.text.trim();
    String Booklocation = booklocationController.text.trim();
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("Profile Pictures")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .putFile(bookPic!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    Map<String, dynamic> BookData = {
      "Bookname": Bookname,
      "Authorname": Authorname,
      "Bookdesc": Bookdesc,
      "Bookprice": Bookprice,
      "Booklocation": Booklocation,
      "Bookpic": downloadUrl,
      "samplearray": [
        Bookname,
        Authorname,
        Bookdesc,
        Bookprice,
        Booklocation,
        downloadUrl
      ]
    };
    FirebaseFirestore.instance
        .collection("BookData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(BookData);
    if (BookData != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Book Added Succesfully'),
        ),
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFe7008a),
        title: const Text('ADD BOOK'),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      CupertinoButton(
                        onPressed: () async {
                          XFile? SelectedImage = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (SelectedImage != null) {
                            File convertedFile = File(SelectedImage.path);
                            setState(() {
                              bookPic = convertedFile;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Select Image'),
                              ),
                            );
                          }
                        },
                        padding: EdgeInsets.zero,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              (bookPic != null) ? FileImage(bookPic!) : null,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: booknameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Book Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Book Name',
                          prefixIcon:
                              const Icon(Icons.book, color: Color(0xFFe7008a)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: bookauthornameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Author Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Author Name',
                          prefixIcon:
                              const Icon(Icons.person, color: Color(0xFFe7008a)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: bookdesController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Description';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Description',
                          prefixIcon:
                              const Icon(Icons.description, color: Color(0xFFe7008a)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: bookpriceController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Price';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Price',
                          prefixIcon: const Icon(Icons.currency_rupee,
                              color: Color(0xFFe7008a)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: booklocationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Location';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Location',
                          prefixIcon:
                              const Icon(Icons.location_on, color: Color(0xFFe7008a)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              addBook();
                            }
                          },
                          text: "POST",
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
