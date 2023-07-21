import 'package:bookshare/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllBook_Screen extends StatefulWidget {
  const AllBook_Screen({Key? key}) : super(key: key);

  @override
  State<AllBook_Screen> createState() => _AllBook_ScreenState();
}

class _AllBook_ScreenState extends State<AllBook_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text("All Books"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("BookData").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> userMap =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                          return Column(
                            children: [
                              SizedBox(
                                height: 200,
                                child: Card(
                                  elevation: 9,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              height: 170,
                                              width: 120,
                                              child: Image.network(
                                                userMap["Bookpic"].toString(),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Flexible(
                                              child: Text(
                                                userMap["Bookname"],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Flexible(
                                                child: Text(
                                              userMap["Bookdesc"],
                                              overflow: TextOverflow.clip,
                                            )),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 20, 20),
                                            child: Text(
                                              "₹" "${userMap["Bookprice"]}",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return const Text("No data!");
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
