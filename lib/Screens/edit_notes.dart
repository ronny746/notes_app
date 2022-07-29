// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:notes_app/Screens/home.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:notes_app/Screens/list_cubic.dart';

// class EditNotes extends StatefulWidget {
//   String? editToNotes;

//   EditNotes({Key? key, this.editToNotes}) : super(key: key);

//   @override
//   _EditNotesState createState() => _EditNotesState();
// }

// class _EditNotesState extends State<EditNotes> {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   FocusNode focusNode = new FocusNode();

//   addEdittasktofirebase() async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     final User user = await auth.currentUser!;
//     String uid = user.uid;
//     var time = DateTime.now();
//     await FirebaseFirestore.instance
//         .collection('Notes')
//         .doc(uid)
//         .collection('MyNotes')
//         .doc(widget.editToNotes)
//         .update({
//       'title': titleController.text,
//       'description': descriptionController.text,
//       'time': time.toString(),
//       'timestamp': time
//     });
//     Fluttertoast.showToast(msg: 'Data Added');
//   }

//   _addItem() {
//     BlocProvider.of<ListCubic>(context).newItem(descriptionController.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
//       floatingActionButton: SpeedDial(
//           icon: Icons.image,
//           backgroundColor: Colors.green,
//           children: [
//             SpeedDialChild(
//               child: const Icon(Icons.camera_alt_outlined, color: Colors.black),
//               backgroundColor: Colors.white,
//               onTap: () {},
//             ),
//             SpeedDialChild(
//               labelBackgroundColor: Colors.white,
//               child: const Icon(Icons.file_copy_outlined, color: Colors.black),
//               backgroundColor: Colors.white,
//               onTap: () {},
//             ),
//           ]),
//       body: Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 50,
//               ),
//               Row(
//                 children: [
//                   Card(
//                       elevation: 30,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25)),
//                       child: IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Home()));
//                           },
//                           icon: const Icon(Icons.arrow_back))),
//                   const SizedBox(
//                     width: 40,
//                   ),
//                   Card(
//                       elevation: 30,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25)),
//                       child: IconButton(
//                           onPressed: () {
//                             //BlocProvider.of<ListCubic>(context).undo();
//                             print(widget.editToNotes);
//                           },
//                           icon: const Icon(Icons.undo_outlined))),
//                   Card(
//                       elevation: 30,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25)),
//                       child: IconButton(
//                           onPressed: () {
//                             // BlocProvider.of<ListCubic>(context).redo();
//                           },
//                           icon: const Icon(Icons.redo_outlined))),
//                   Card(
//                       elevation: 30,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25)),
//                       child: IconButton(
//                           onPressed: () {}, icon: const Icon(Icons.delete))),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               TextFormField(
//                 autofocus: true,
//                 focusNode: focusNode,
//                 maxLines: 1,
//                 controller: titleController,
//                 style: const TextStyle(
//                     fontSize: 40,
//                     height: 1.5,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//                 decoration: const InputDecoration(
//                   hintText: 'Title',
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//                   border: InputBorder.none,
//                 ),
//               ),
//               TextFormField(
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 controller: descriptionController,
//                 style: const TextStyle(
//                     fontSize: 25,
//                     height: 1.5,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//                 decoration: const InputDecoration(
//                   hintText: 'Enter Your Text here',
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 1, horizontal: 15),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
