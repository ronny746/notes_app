import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/Screens/home.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode focusNode = new FocusNode();

  addtasktofirebase() async {
   
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = await auth.currentUser!;
    String uid = user.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('Notes')
        .doc(uid)
        .collection('MyNotes')
        .doc(time.toString())
        .set({
      'title': titleController.text,
      'description': descriptionController.text,
      'time': time.toString(),
      'uid': uid,
      'timestamp': time
    });
    Fluttertoast.showToast(msg: 'Data Added');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: SpeedDial(
          icon: Icons.image,
          backgroundColor: Colors.green,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.camera_alt_outlined, color: Colors.black),
              backgroundColor: Colors.white,
              onTap: () {},
            ),
            SpeedDialChild(
              labelBackgroundColor: Colors.white,
              child: const Icon(Icons.file_copy_outlined, color: Colors.black),
              backgroundColor: Colors.white,
              onTap: () {
                getImage();
              },
            ),
          ]),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Card(
                        elevation: 30,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            },
                            icon: const Icon(Icons.arrow_back))),
                    const SizedBox(
                      width: 40,
                    ),
                    Card(
                        elevation: 30,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: IconButton(
                            onPressed: () {
                              //BlocProvider.of<ListCubic>(context).undo();
                            },
                            icon: const Icon(Icons.undo_outlined))),
                    Card(
                        elevation: 30,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: IconButton(
                            onPressed: () {
                              // BlocProvider.of<ListCubic>(context).redo();
                            },
                            icon: const Icon(Icons.redo_outlined))),
                    Card(
                        elevation: 30,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.delete))),
                    Card(
                        elevation: 30,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: IconButton(
                            onPressed: () {
                              //   BlocProvider.of<ListCubic>(context)
                              //  .newItem(descriptionController.text);
                              addtasktofirebase();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            },
                            icon: const Icon(Icons.save))),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  width: 200,
                  child: TextFormField(
                    maxLines: null,
                    controller: titleController,
                    keyboardType: TextInputType.multiline,
                    autofocus: true,
                    focusNode: focusNode,
                    style: const TextStyle(
                        fontSize: 40,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: descriptionController,
                    style: const TextStyle(
                        fontSize: 25,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Text here',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                
              ],
            )),
      ),
    );
  }

  File? image;
  String imageUrl = " ";

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);

    image = File(img!.path);
  }
}
