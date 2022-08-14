// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Screens/edit_notes.dart';
import 'package:notes_app/Screens/login.dart';

import 'add_notes.dart';
import 'description.dart';

class Home extends StatefulWidget {
  String? deletNote;

  Home({Key? key, this.deletNote}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  double _crossAxisSpacing = 8, _mainAxisSpacing = 12, _aspectRatio = 2;
  int _crossAxisCount = 2;

  String uid = "";
  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
    setState(() {
      uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70, right: 10),
            child: Text(
              "Welcome to Notes",
              style:
                  GoogleFonts.roboto(fontSize: 21, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 70),
            child: Text(
              "Have a nice day",
              style: GoogleFonts.roboto(
                  fontSize: 15, fontWeight: FontWeight.normal),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Notes')
                  .doc(uid)
                  .collection('MyNotes')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final docs = snapshot.data!.docs;

                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        var time =
                            (docs[index]['timestamp'] as Timestamp).toDate();

                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Description(
                                            title: docs[index]['title'],
                                            description: docs[index]
                                                ['description'],
                                          )));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 7,
                              child: Stack(children: [
                                Positioned(
                                  top: 15,
                                  left: 12,
                                  right: 6,
                                  child: Text(docs[index]['title'],
                                      maxLines: 1,
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Positioned(
                                  top: 50,
                                  left: 12,
                                  right: 6,
                                  child: Text(docs[index]['description'],
                                      maxLines: 4,
                                      style: GoogleFonts.roboto(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal)),
                                ),
                                Positioned(
                                    right: 6,
                                    top: 6,
                                    child: ClipOval(
                                      child: Material(
                                        color: Colors.blue, // Button color
                                        child: InkWell(
                                          splashColor:
                                              Colors.red, // Splash color
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection("Notes")
                                                .doc(uid)
                                                .collection("MyNotes")
                                                .doc(docs[index]['time'])
                                                .delete();
                                          },
                                          child: const SizedBox(
                                              width: 25,
                                              height: 25,
                                              child: Icon(
                                                Icons.delete,
                                                size: 15,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                    )),
                                Positioned(
                                  bottom: 13,
                                  left: 12,
                                  child: Text(
                                    DateFormat.yMd().format(DateTime.now()),
                                    style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Positioned(
                                    right: 9,
                                    bottom: 6,
                                    child: ClipOval(
                                      child: Material(
                                        color: Colors.green, // Button color
                                        child: InkWell(
                                          splashColor:
                                              Colors.red, // Splash color
                                          onTap: () {
                                            titleController.text =
                                                docs[index]['title'];
                                            descriptionController.text =
                                                docs[index]['description'];

                                            showDialog(
                                                context: context,
                                                builder: ((context) => Dialog(
                                                        child: Card(
                                                      child: Container(
                                                        height: 300,
                                                        width: 200,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ListView(
                                                            // ignore: prefer_const_literals_to_create_immutables
                                                            children: [
                                                              TextField(
                                                                maxLines: null,
                                                                controller:
                                                                    titleController,
                                                                decoration:
                                                                    InputDecoration(
                                                                        hintText:
                                                                            "Title"),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              TextField(
                                                                maxLines: null,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .multiline,
                                                                controller:
                                                                    descriptionController,
                                                                decoration:
                                                                    InputDecoration(
                                                                        hintText:
                                                                            "Description"),
                                                              ),
                                                              SizedBox(
                                                                height: 120,
                                                              ),
                                                              MaterialButton(
                                                                color:
                                                                    Colors.blue,
                                                                onPressed: () {
                                                                  snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .reference
                                                                      .update({
                                                                    'title':
                                                                        titleController
                                                                            .text,
                                                                    'description':
                                                                        descriptionController
                                                                            .text,
                                                                  });
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Home()));
                                                                },
                                                                child: Text(
                                                                    "Save"),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ))));
                                          },
                                          child: const SizedBox(
                                              width: 35,
                                              height: 35,
                                              child: Icon(
                                                Icons.edit,
                                                size: 20,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                    )),
                              ]),
                            ));
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 220, // here set custom Height You Want
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 15),
        child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => AddTask())));
            },
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 30,
            )),
      ),
    );
  }
}
