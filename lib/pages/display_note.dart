// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayNote extends StatefulWidget {
  final String title, description;
  const DisplayNote({
    Key? key,
    required this.description,
    required this.title,
  }) : super(key: key);

  @override
  State<DisplayNote> createState() => _DisplayNoteState();
}

class _DisplayNoteState extends State<DisplayNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text('ToDo', style: GoogleFonts.bebasNeue(fontSize: 24)),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50, right: 50, left: 50),
        height: 500,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300],
        ),
        child: Column(
          children: [
            Container(
              height: 80,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.deepPurple[300],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.title,
                  style: GoogleFonts.dancingScript(
                      fontSize: 34, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    widget.description,
                    style: GoogleFonts.sourceSerifPro(
                        fontSize: 28, fontWeight: FontWeight.w600),
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
