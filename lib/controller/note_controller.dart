import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes_app/model/notes_model.dart';

class NotesController extends GetxController {
  var notes = <Note>[].obs;

  void fetchNotes() {
    final box = GetStorage();
    if (box.hasData('notes')) {
      List storedNotes = box.read('notes');
      notes.assignAll(storedNotes.map((e) => Note.fromMap(e)));
    }
  }

  void addNotes(String title, String content) {
    int id = notes.isNotEmpty ? notes.last.id + 1 : 1;
    notes.add(Note(id: id, title: title, content: content));
    saveNotes();
  }

  void editNotes(int index, String newTitle, String newNote) {
    notes[index].title = newTitle;
    notes[index].content = newNote;
    saveNotes();
  }

  void deleteNotes(int index) {
    notes.removeAt(index);
    saveNotes();
  }

  void saveNotes() {
    final box = GetStorage();
    box.write('notes', notes.map((note) => note.toMap()).toList());
  }
}
