import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesList extends StatelessWidget {
  final title;
  final content;
  // final bool isImportant;
  // final bool isCompleted;

  const NotesList({
    super.key,
    required this.title,
    required this.content,
    // required this.isImportant,
    // required this.isCompleted
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                title,
                style: GoogleFonts.poppins(
                    fontSize: 21, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                content,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )));
  }
}
