// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatePage extends StatefulWidget {
  final title, description, uid, time;
  const UpdatePage({
    Key? key,
    required this.description,
    required this.title,
    required this.uid,
    required this.time,
  }) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  // text editing controller
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  // update function
  Future update() async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(widget.uid)
        .collection('myTasks')
        .doc(widget.time)
        .update({
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim()
    });
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              alignment: Alignment.bottomCenter,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              backgroundColor: Colors.green[800],
              content: Text('Update saved !'));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text(
          'Update Data',
          style: GoogleFonts.bebasNeue(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    labelText: 'Enter New Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                    labelText: 'Enter New Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: update,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[300],
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text('Update',
                        style: GoogleFonts.roboto(
                            fontSize: 20, color: Colors.white)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
