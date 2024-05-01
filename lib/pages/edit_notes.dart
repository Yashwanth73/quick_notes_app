import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/controller/note_controller.dart';

class EditNotes extends StatefulWidget {
  final int index;
  final title;
  final note;
  const EditNotes(
      {super.key,
      required this.title,
      required this.note,
      required this.index});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  final NotesController notesController = Get.put(NotesController());
  TextEditingController title = TextEditingController(),
      note = TextEditingController();
  String etitle = "", enote = "";
  bool isEditingMode = false;
  @override
  void initState() {
    super.initState();
    title.text = widget.title;
    note.text = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: selectedColors,
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 30,
                    ),
                    Text(
                      "Edit Note",
                      style: GoogleFonts.poppins(
                          fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        if (title.text.isNotEmpty && note.text.isNotEmpty) {
                          notesController.editNotes(
                              widget.index, title.text, note.text);
                          Get.showSnackbar(const GetSnackBar(
                            duration: Duration(seconds: 2),
                            borderRadius: 20,
                            backgroundColor: Colors.redAccent,
                            title: "Success",
                            icon: Icon(Icons.delete_forever),
                            message: 'Your Note has been Created',
                          ));
                          Get.back();
                        }
                      },
                      icon: const Icon(Icons.done),
                      iconSize: 30,
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: TextFormField(
              controller: title,
              // initialValue: etitle,
              onChanged: (value) {
                setState(() {
                  etitle = value;
                });
              },
              style: const TextStyle(fontSize: 24, color: Colors.black),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(fontSize: 24, color: Colors.black)),
            ),
          ),
          SizedBox(
            height: 630,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: TextFormField(
                  controller: note,
                  // initialValue: enote,
                  onChanged: (value) {
                    setState(() {
                      enote = value;
                    });
                  },
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
