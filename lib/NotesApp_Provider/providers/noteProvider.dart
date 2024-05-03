import 'package:flutter/material.dart';
import 'package:provider_wslc_statemanagement/NotesApp_Provider/Database/dbhelper.dart';
import 'package:provider_wslc_statemanagement/NotesApp_Provider/Models/noteModel.dart';

class NotesProvider extends ChangeNotifier
{
  DbHelper db = DbHelper.dbHelper;
  List<NotesModel> arrNotes = [];

  addData(NotesModel notesModel) async {
    await db.addNotes(notesModel);
    notifyListeners();
  }

  List<NotesModel> getNotes() {
    fetchInitialNotes();
    return arrNotes;
  }

  fetchInitialNotes() async {
    arrNotes = await db.fetchData();
    notifyListeners();
  }

  delete(int noteid) async {
    var check = await db.deleteNotes(noteid);
    /// For Below "check" and "check == true" both are same
    if(check)
      {
        arrNotes = await db.fetchData();
        notifyListeners();
      }
  }
}