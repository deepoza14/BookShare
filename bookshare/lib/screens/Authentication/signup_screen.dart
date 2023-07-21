
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bookshare/screens/home_screen.dart';
import 'package:bookshare/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  _SignUpState() {
    selectedAge = ageList[0];
  }

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

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        saveuser();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The password provided is too weak.'),
          ),
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The account already exists for that email.'),
          ),
        );
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void saveuser() async {
    String name = nameController.text.trim();
    String gender = sgender.toString().trim();
    String ageNo = selectedAge.toString().trim();
    String email = emailController.text.trim();
    String phonestring = phoneController.text.trim();
    String password = passwordController.text.trim();
    int age = int.parse(ageNo);
    int phone = int.parse(phonestring);
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("Profile Pictures")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .putFile(profilePic!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    Map<String, dynamic> userData = {
      "name": name,
      "gender": gender,
      "Age": age,
      "email": email,
      "phone": phone,
      "password": password,
      "profilePic": downloadUrl,
      "samplearray": [name, gender, age, email, phone, password, downloadUrl]
    };

    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFe7008a),
        title: const Text("Create an account"),
      ),
      body: SafeArea(
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
                            profilePic = convertedFile;
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
                        radius: 80,
                        backgroundImage: (profilePic != null)
                            ? FileImage(profilePic!)
                            : null,
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
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
                    Center(
                      child: Row(
                        children: [
                          Radio(
                              value: "Male",
                              groupValue: sgender,
                              onChanged: (value) {
                                setState(() {
                                  sgender = value.toString();
                                });
                              }),
                          const Icon(Icons.person, color: Color(0xFFe7008a)),
                          const Text("Male"),
                          Radio(
                              value: "Female",
                              groupValue: sgender,
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
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email Address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: const Icon(Icons.email, color: Color(0xFFe7008a)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Phone Number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: const Icon(Icons.phone, color: Color(0xFFe7008a)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            createAccount();
                          }
                        },
                        text: "Sign Up",
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
