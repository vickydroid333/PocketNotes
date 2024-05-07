import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:notes/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesProvider extends ChangeNotifier with WidgetsBindingObserver {
  List<Note> notes = [];
  Note? selectedNote;
  final List<Map<String, dynamic>> _undoStack = []; // Track deleted info

  NotesProvider() {
    // Load notes from SharedPreferences on initialization
    loadNotes();
  }

  void addNote(Note note) {
    notes.add(note);
    notifyListeners(); // Notify UI of changes
  }

  Future<void> deleteNote(int index) async {
    if (notes.isNotEmpty && index >= 0 && index < notes.length) {
      final deletedNote = notes.removeAt(index);
      _undoStack.add({'note': deletedNote, 'index': index});
      notifyListeners();
    }
  }

  Future<void> undoDelete() async {
    if (_undoStack.isNotEmpty) {
      final lastDeleted = _undoStack.removeLast();
      notes.insert(lastDeleted['index'] as int, lastDeleted['note'] as Note);
      notifyListeners();
    }
  }

  void selectNote(Note note) {
    selectedNote = note;
    notifyListeners();
  }

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getStringList('notes');
    if (notesJson != null) {
      notes = notesJson.map((json) => Note.fromJson(jsonDecode(json))).toList();
    }
    notifyListeners();
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = notes.map((note) => note.toJson()).toList();
    prefs.setStringList(
        'notes', notesJson.map((json) => jsonEncode(json)).toList());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      saveNotes();
    }
    super.didChangeAppLifecycleState(state);
  }
}
