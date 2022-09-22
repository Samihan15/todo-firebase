import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/pages/add_task.dart';
import 'package:todo/pages/display_note.dart';
import 'package:todo/pages/update_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // function for getting user id
  String uid = '';
  @override
  void initState() {
    getUid();
    super.initState();
  }

  getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = await auth.currentUser!;
    setState(() {
      uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text('ToDo', style: GoogleFonts.bebasNeue(fontSize: 24)),
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: Icon(Icons.logout))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('tasks/${uid}/myTasks')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              final docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: [
                        Slidable(
                          startActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                icon: Icons.delete,
                                backgroundColor: Colors.redAccent,
                                onPressed: (context) async {
                                  await FirebaseFirestore.instance
                                      .collection('tasks')
                                      .doc(uid)
                                      .collection('myTasks')
                                      .doc(docs[index]['time'])
                                      .delete();
                                },
                              ),
                              SlidableAction(
                                  icon: Icons.update,
                                  backgroundColor: Colors.blue,
                                  onPressed: (context) async {
                                    Navigator.push(
                                        context,
                                        (MaterialPageRoute(
                                            builder: (context) => UpdatePage(
                                                  description: docs[index]
                                                      ['description'],
                                                  title: docs[index]['title'],
                                                  uid: uid,
                                                  time: docs[index]['time'],
                                                ))));
                                  })
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 15, bottom: 5, left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple[100],
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              title: Text(
                                docs[index]['title'],
                                style: GoogleFonts.dancingScript(
                                    fontSize: 27, fontWeight: FontWeight.w800),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DisplayNote(
                                              description: docs[index]
                                                  ['description'],
                                              title: docs[index]['title'],
                                            )));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        backgroundColor: Colors.deepPurple[300],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
