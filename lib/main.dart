import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/listnotes.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/pages/create_notes.dart';
import 'package:notes_app/pages/edit_notes.dart';

import 'controller/note_controller.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.orange),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NotesController notesController = Get.put(NotesController());

  List tags = [
    "All",
    "Important",
    "Pinned",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => const CreateNotes()),
          child: const Icon(Icons.add),
        ),
        body: Obx(() => ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        "Quick Notes",
                        style: GoogleFonts.poppins(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 500,
                  child: notesController.notes.isEmpty
                      ? Column(
                          children: [
                            Image.asset("assets/add_notes.png"),
                            Center(
                              child: Text(
                                "Create A Note To Get Started",
                                style: GoogleFonts.poppins(
                                    fontSize: 26, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        )
                      : ListView(
                          children: [
                            // SizedBox(
                            //   height: 50,
                            //   child: ListView.builder(
                            //       itemCount: tags.length,
                            //       scrollDirection: Axis.horizontal,
                            //       itemBuilder: (_, index) {
                            //         return Tags(tags: tags[index]);
                            //       }),
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 500,
                              child: ListView.builder(
                                  itemCount: notesController.notes.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (_, index) {
                                    Note note = notesController.notes[index];
                                    return Dismissible(
                                      key: Key(note.id.toString()),
                                      onDismissed: (direction) {
                                        notesController.deleteNotes(index);
                                        Get.showSnackbar(GetSnackBar(
                                          duration: const Duration(seconds: 2),
                                          borderRadius: 20,
                                          backgroundColor: Colors.redAccent,
                                          title: "Deleted",
                                          icon:
                                              const Icon(Icons.delete_forever),
                                          message:
                                              '${note.title} has been deleted',
                                        ));
                                      },
                                      background: Container(
                                        color: Colors.black,
                                        alignment: Alignment.centerRight,
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () => Get.to(() => EditNotes(
                                              index: index,
                                              note: note.content.toString(),
                                              title: note.title.toString(),
                                            )),
                                        child: NotesList(
                                          title: note.title.toString(),
                                          content: note.content,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                )
              ],
            )));
  }
}
