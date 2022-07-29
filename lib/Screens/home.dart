import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Screens/edit_notes.dart';
import 'package:notes_app/Screens/login.dart';


import 'add_task.dart';
import 'description.dart';

class Home extends StatefulWidget {
  String? deletNote;

  Home({Key? key, this.deletNote}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, right: 50),
            child: Text(
              "Welcome to Notes",
              style:
                  GoogleFonts.roboto(fontSize: 33, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 180),
            child: Text(
              "Have a nice day",
              style: GoogleFonts.roboto(
                  fontSize: 20, fontWeight: FontWeight.normal),
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                    return GridView.builder(
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
                            child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 7,
                                  child: Container(
                                    child: Stack(children: [
                                      Positioned(
                                        top: 15,
                                        left: 12,
                                        right: 6,
                                        child: Text(docs[index]['title'],
                                            maxLines: 1,
                                            style: GoogleFonts.roboto(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Positioned(
                                        top: 50,
                                        left: 12,
                                        right: 6,
                                        child: Text(docs[index]['description'],
                                            maxLines: 4,
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal)),
                                      ),
                                      Positioned(
                                          right: 6,
                                          top: 6,
                                          child: ClipOval(
                                            child: Material(
                                              color:
                                                  Colors.blue, // Button color
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
                                                    width: 30,
                                                    height: 30,
                                                    child: Icon(
                                                      Icons.delete,
                                                      size: 23,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ),
                                          )),
                                      Positioned(
                                        bottom: 3,
                                        left: 12,
                                        child: Text(
                                          DateFormat.yMMMd()
                                              .format(DateTime.now()),
                                          style: GoogleFonts.roboto(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ]),
                                  ),
                                )));
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                    );
                  }
                },
              ),
              // color: Colors.red,
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SpeedDial(
            direction: SpeedDialDirection.down,
            animatedIcon: AnimatedIcons.menu_close,
            iconTheme: IconThemeData(color: Colors.black),
            activeBackgroundColor: Colors.red,
            animatedIconTheme: IconThemeData(size: 22),
            backgroundColor: Colors.black,
            visible: true,
            curve: Curves.fastOutSlowIn,
            children: [
              SpeedDialChild(
                label: 'Add Note',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16.0),
                child: const Icon(Icons.add, color: Colors.black),
                backgroundColor: Colors.white,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTask()));
                },
              ),
              SpeedDialChild(
                label: 'Log Out',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.white,
                child: const Icon(Icons.logout, color: Colors.black),
                backgroundColor: Colors.white,
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ]),
      ),
    );
  }
}
